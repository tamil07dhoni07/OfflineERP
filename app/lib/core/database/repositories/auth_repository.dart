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
    if (!PasswordHasher.verify(password, user.passwordHash)) return null;
    return user;
  }

  Future<AppUser?> byId(String id) => (_db.select(_db.appUsers)..where((t) => t.id.equals(id))).getSingleOrNull();
}
