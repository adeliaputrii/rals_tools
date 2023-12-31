import 'package:shared_preferences/shared_preferences.dart';
import 'package:myactivity_project/base/base_prefs.dart';

class SharedPref {
  const SharedPref._();

  static const String prefKey = 'RAMAYANA_PREF';

  static Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(key_token, token);
  }

  static Future<void> setUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(key_user_id, userId);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(key_token);
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(key_user_id);
  }

  static Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString('name');
  }

  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString('role');
  }
}
