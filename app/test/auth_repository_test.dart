import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_erp/core/database/app_database.dart';
import 'package:nexus_erp/core/database/repositories/auth_repository.dart';
import 'package:nexus_erp/core/security/password_hasher.dart';

Future<AppDatabase> _openTestDb() => Future.value(AppDatabase.forTesting(NativeDatabase.memory()));

Future<AppUser> _insertUser(AppDatabase db, {String username = 'test.user'}) async {
  final hash = await PasswordHasher.hash('correct-password');
  return db
      .into(db.appUsers)
      .insertReturning(
        AppUsersCompanion.insert(
          username: username,
          displayName: 'Test User',
          initials: 'TU',
          passwordHash: hash,
          role: 'admin',
        ),
      );
}

void main() {
  group('AuthRepository', () {
    late AppDatabase db;
    late AuthRepository repo;

    setUp(() async {
      db = await _openTestDb();
      repo = AuthRepository(db);
    });

    tearDown(() => db.close());

    test('signIn accepts the right password and rejects the wrong one', () async {
      await _insertUser(db);
      expect(await repo.signIn(username: 'test.user', password: 'correct-password'), isNotNull);
      expect(await repo.signIn(username: 'test.user', password: 'wrong'), isNull);
    });

    test('signInWithPin fails until a PIN has been set', () async {
      final user = await _insertUser(db);
      expect(await repo.signInWithPin(username: 'test.user', pin: '1234'), isNull);

      await repo.setPin(user.id, '1234');
      final signedIn = await repo.signInWithPin(username: 'test.user', pin: '1234');
      expect(signedIn, isNotNull);
      expect(signedIn!.id, user.id);
    });

    test('signInWithPin rejects the wrong PIN', () async {
      final user = await _insertUser(db);
      await repo.setPin(user.id, '1234');
      expect(await repo.signInWithPin(username: 'test.user', pin: '9999'), isNull);
    });

    test('clearPin removes the PIN so PIN sign-in stops working', () async {
      final user = await _insertUser(db);
      await repo.setPin(user.id, '1234');
      await repo.clearPin(user.id);
      expect(await repo.signInWithPin(username: 'test.user', pin: '1234'), isNull);
      final reloaded = await repo.byId(user.id);
      expect(reloaded!.pinHash, isNull);
    });
  });
}
