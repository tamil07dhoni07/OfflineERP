import 'package:shared_preferences/shared_preferences.dart';

/// Persists "keep me signed in" across app restarts. Deliberately a thin
/// wrapper over [SharedPreferences] rather than anything in the SQLite
/// database — this is device-local UI state (should this device skip the
/// login screen next launch?), not ERP data, so it doesn't belong in the
/// synced/backed-up database.
abstract final class SessionStore {
  static const _key = 'keep_signed_in_user_id';

  static Future<String?> restoreUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key);
  }

  static Future<void> remember(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, userId);
  }

  static Future<void> forget() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
