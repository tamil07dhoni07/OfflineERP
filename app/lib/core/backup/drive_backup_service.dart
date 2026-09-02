import 'dart:async';
import 'dart:io';

import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../database/app_database.dart';

/// Backs up the local SQLite database file to the signed-in user's private
/// Google Drive "app data" folder — storage that never shows up in the
/// user's regular Drive UI and that only this app can read or write,
/// matching the "use [a] common Google [account] for backup" ask without
/// exposing the raw database file anywhere it could be shared by accident.
///
/// NOT wired to a working OAuth client yet. The Firebase project's Android
/// app has no Google Sign-In OAuth client registered (the provided
/// `google-services.json` has an empty `oauth_client` list — that needs a
/// debug/release SHA-1 fingerprint added in Google Cloud Console), and the
/// iOS app has none either (`GoogleService-Info.plist` has no `CLIENT_ID`).
/// Every method here will throw until that's done — see the PR description
/// for exact next steps.
abstract final class DriveBackupService {
  static const scopes = [drive.DriveApi.driveAppdataScope];
  static const _backupFileName = 'nexus_erp_backup.sqlite';
  static const _dbFileName = 'nexus_erp.sqlite';
  static const _stagingSuffix = '.pending_restore';

  static bool _initialized = false;
  static GoogleSignInAccount? _account;

  static GoogleSignInAccount? get signedInAccount => _account;

  static Future<void> _ensureInitialized() async {
    if (_initialized) return;
    final signIn = GoogleSignIn.instance;
    await signIn.initialize();
    signIn.authenticationEvents.listen((event) {
      _account = switch (event) {
        GoogleSignInAuthenticationEventSignIn(:final user) => user,
        GoogleSignInAuthenticationEventSignOut() => null,
      };
    });
    _initialized = true;
    try {
      await signIn.attemptLightweightAuthentication();
    } catch (_) {
      // No previously-remembered session on this device — the user signs
      // in explicitly instead.
    }
  }

  static Future<GoogleSignInAccount> signIn() async {
    await _ensureInitialized();
    final account = await GoogleSignIn.instance.authenticate(scopeHint: scopes);
    _account = account;
    return account;
  }

  static Future<void> signOut() async {
    await _ensureInitialized();
    await GoogleSignIn.instance.disconnect();
    _account = null;
  }

  static Future<drive.DriveApi> _driveApi() async {
    final account = _account;
    if (account == null) throw StateError('Not signed in to Google.');
    final authorization = await account.authorizationClient.authorizeScopes(scopes);
    final client = authorization.authClient(scopes: scopes);
    return drive.DriveApi(client);
  }

  static Future<File> _localDbFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File(p.join(dir.path, _dbFileName));
  }

  /// Finds this app's existing backup file in the appDataFolder, if any.
  static Future<drive.File?> _findBackupFile(drive.DriveApi api) async {
    final result = await api.files.list(
      spaces: 'appDataFolder',
      q: "name = '$_backupFileName' and trashed = false",
      $fields: 'files(id, name, modifiedTime)',
    );
    final files = result.files ?? const <drive.File>[];
    return files.isEmpty ? null : files.first;
  }

  /// Flushes SQLite's WAL journal into the main database file so the bytes
  /// read from disk are a complete, self-contained snapshot rather than
  /// missing whatever's still sitting in the `-wal` sidecar file.
  static Future<void> _checkpoint(AppDatabase db) async {
    await db.customStatement('PRAGMA wal_checkpoint(TRUNCATE)');
  }

  /// When the last backup was made, if any — null if never backed up.
  static Future<DateTime?> remoteBackupTime() async {
    final api = await _driveApi();
    final existing = await _findBackupFile(api);
    return existing?.modifiedTime;
  }

  /// Uploads the current local database as the backup, replacing whatever
  /// was there before.
  static Future<void> upload(AppDatabase db) async {
    await _checkpoint(db);
    final api = await _driveApi();
    final localFile = await _localDbFile();
    final bytes = await localFile.readAsBytes();
    final existing = await _findBackupFile(api);
    final media = drive.Media(Stream.value(bytes), bytes.length);
    if (existing != null) {
      await api.files.update(drive.File(), existing.id!, uploadMedia: media);
    } else {
      await api.files.create(
        drive.File(name: _backupFileName, parents: ['appDataFolder']),
        uploadMedia: media,
      );
    }
  }

  /// Downloads the backup into a staging file next to the real database.
  /// It is NOT applied immediately — swapping the database file out from
  /// under an open native SQLite connection is unsafe. [applyStagedRestoreIfAny]
  /// checks for this staging file on the next app launch, before the real
  /// database is opened, and applies it then.
  ///
  /// Returns true if a backup existed on Drive and was staged.
  static Future<bool> downloadToStaging() async {
    final api = await _driveApi();
    final existing = await _findBackupFile(api);
    if (existing == null) return false;

    final media = await api.files.get(existing.id!, downloadOptions: drive.DownloadOptions.fullMedia) as drive.Media;
    final bytes = <int>[];
    await for (final chunk in media.stream) {
      bytes.addAll(chunk);
    }

    final dir = await getApplicationDocumentsDirectory();
    final staging = File(p.join(dir.path, '$_dbFileName$_stagingSuffix'));
    await staging.writeAsBytes(bytes, flush: true);
    return true;
  }

  /// Compares local vs remote modification time and picks the newer side —
  /// stages a download if Drive is newer, otherwise uploads. Returns which
  /// direction it went, and whether a restart is needed to finish applying
  /// a downloaded backup.
  static Future<({String direction, bool restartRequired})> sync(AppDatabase db) async {
    final api = await _driveApi();
    final existing = await _findBackupFile(api);
    final localFile = await _localDbFile();
    final localModified = await localFile.exists() ? await localFile.lastModified() : null;

    final remoteIsNewer = existing?.modifiedTime != null &&
        (localModified == null || existing!.modifiedTime!.isAfter(localModified));

    if (remoteIsNewer) {
      final staged = await downloadToStaging();
      return (direction: 'downloaded', restartRequired: staged);
    }
    await upload(db);
    return (direction: 'uploaded', restartRequired: false);
  }

  /// Applies a staged restore if one exists — called once during boot,
  /// before the real database is opened. Safe: at this point nothing has a
  /// connection to the database file yet.
  static Future<void> applyStagedRestoreIfAny() async {
    final dir = await getApplicationDocumentsDirectory();
    final staging = File(p.join(dir.path, '$_dbFileName$_stagingSuffix'));
    if (!await staging.exists()) return;

    final target = File(p.join(dir.path, _dbFileName));
    await staging.copy(target.path);
    await staging.delete();

    // Drift/sqlite3 also maintain -wal/-shm sidecar files next to the main
    // database file; a freshly restored database should start clean rather
    // than resuming an old WAL journal against a swapped-out main file.
    for (final suffix in ['-wal', '-shm']) {
      final sidecar = File('${target.path}$suffix');
      if (await sidecar.exists()) await sidecar.delete();
    }
  }
}
