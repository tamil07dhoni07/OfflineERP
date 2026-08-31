import 'package:drift/drift.dart';

import '../../security/password_hasher.dart';
import '../app_database.dart';

class AuthRepository {
  AuthRepository(this._db);
  final AppDatabase _db;

  /// Verifies against the local user table only — no network round-trip,
  /// per the offline-first auth requirement.
  Future<AppUser?> signIn({required String username, required String password}) async {
    final user = await (_db.select(_db.appUsers)..where((t) => t.username.equals(username))).getSingleOrNull();
    if (user == null) return null;
    if (!await PasswordHasher.verify(password, user.passwordHash)) return null;
    return user;
  }

  /// The quick-unlock path: a PIN set on this device stands in for the
  /// full password. A user with no PIN configured yet (`pinHash == null`)
  /// simply can't use this path — never treated as "any PIN matches".
  Future<AppUser?> signInWithPin({required String username, required String pin}) async {
    final user = await (_db.select(_db.appUsers)..where((t) => t.username.equals(username))).getSingleOrNull();
    if (user == null || user.pinHash == null) return null;
    if (!await PasswordHasher.verify(pin, user.pinHash!)) return null;
    return user;
  }

  Future<void> setPin(String userId, String pin) async {
    final hash = await PasswordHasher.hash(pin);
    await (_db.update(_db.appUsers)..where((t) => t.id.equals(userId))).write(AppUsersCompanion(pinHash: Value(hash)));
  }

  Future<void> clearPin(String userId) async {
    await (_db.update(_db.appUsers)..where((t) => t.id.equals(userId)))
        .write(const AppUsersCompanion(pinHash: Value(null)));
  }

  Future<AppUser?> byId(String id) => (_db.select(_db.appUsers)..where((t) => t.id.equals(id))).getSingleOrNull();
}
