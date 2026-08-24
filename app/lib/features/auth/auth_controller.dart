import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/app_database.dart';
import '../../core/providers.dart';

const currentDeviceId = 'WIN-MUM-04';

class AuthController extends StateNotifier<AppUser?> {
  AuthController(this._ref) : super(null);
  final Ref _ref;

  String? lastError;

  Future<bool> signIn(String username, String password) async {
    final repo = _ref.read(authRepositoryProvider);
    final user = await repo.signIn(username: username, password: password);
    if (user == null) {
      lastError = 'Incorrect username or password.';
      return false;
    }
    lastError = null;
    state = user;
    return true;
  }

  void signOut() => state = null;
}

final authControllerProvider = StateNotifierProvider<AuthController, AppUser?>((ref) => AuthController(ref));

final isAuthedProvider = Provider<bool>((ref) => ref.watch(authControllerProvider) != null);
