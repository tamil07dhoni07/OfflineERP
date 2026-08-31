import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/app_database.dart';
import '../../core/providers.dart';
import '../../core/security/session_store.dart';

const currentDeviceId = 'WIN-MUM-04';

class AuthController extends StateNotifier<AppUser?> {
  AuthController(this._ref, {AppUser? initialUser}) : super(initialUser);
  final Ref _ref;

  String? lastError;

  Future<bool> signIn(String username, String password, {bool keepSignedIn = false}) async {
    final repo = _ref.read(authRepositoryProvider);
    final user = await repo.signIn(username: username, password: password);
    if (user == null) {
      lastError = 'Incorrect username or password.';
      return false;
    }
    lastError = null;
    state = user;
    if (keepSignedIn) {
      await SessionStore.remember(user.id);
    } else {
      await SessionStore.forget();
    }
    return true;
  }

  /// The "Use PIN" quick-unlock path. Signing in with a PIN implies this
  /// device should stay signed in as that user — typing a 4-6 digit PIN
  /// every app launch defeats the point of a quick-unlock shortcut.
  Future<bool> signInWithPin(String username, String pin) async {
    final repo = _ref.read(authRepositoryProvider);
    final user = await repo.signInWithPin(username: username, pin: pin);
    if (user == null) {
      lastError = 'Incorrect PIN, or no PIN is set for this account yet.';
      return false;
    }
    lastError = null;
    state = user;
    await SessionStore.remember(user.id);
    return true;
  }

  Future<void> setPin(String pin) async {
    final user = state;
    if (user == null) return;
    final repo = _ref.read(authRepositoryProvider);
    await repo.setPin(user.id, pin);
    state = await repo.byId(user.id);
  }

  Future<void> clearPin() async {
    final user = state;
    if (user == null) return;
    final repo = _ref.read(authRepositoryProvider);
    await repo.clearPin(user.id);
    state = await repo.byId(user.id);
  }

  void signOut() {
    state = null;
    SessionStore.forget();
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, AppUser?>((ref) => AuthController(ref));

final isAuthedProvider = Provider<bool>((ref) => ref.watch(authControllerProvider) != null);
