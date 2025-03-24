import 'dart:developer';

import 'package:myactivity_project/base/base_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  static Future<void> setUserToko(String userToko) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(key_user_toko, userToko);
  }

  static Future<void> setUserRole(String userRole) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(key_user_role, userRole);
  }

  static Future<void> setDeviceId(String deviceId) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(key_device_id, deviceId);
  }

  static Future<void> setDeviceName(String deviceName) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(key_device_name, deviceName);
  }

  static Future<void> setSubmit(String deviceName) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(key_submit, deviceName);
  }

  static Future<void> setMember(String member) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(key_member, member);
  }

  static Future<void> setLastLogin(String lastLogin) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(key_last_login, lastLogin);
  }

  static Future<void> setAccessMenu(String accessMenu) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(key_list_access, accessMenu);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(key_token);
  }

  static Future<String?> getRoleNew() async {
    final prefs = await SharedPreferences.getInstance();
    String? role = prefs.getString('role');

    log("Cek role: $role");

    return prefs.getString(key_user_role);
  }




  static Future<String?> getSubmit() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(key_submit);
  }

  static Future<String?> getMember() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(key_member);
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(key_user_id);
  }

  // static Future<String?> getVersion() async {
  //   final prefs = await SharedPreferences.getInstance();

  //   return prefs.getString(version);
  // }

  // static Future<String?> getAppName() async {
  //   final prefs = await SharedPreferences.getInstance();

  //   return prefs.getString(appName);
  // }

  static Future<String?> getUserToko() async {
    final prefs = await SharedPreferences.getInstance();
    log("cek toko ${prefs}");
    return prefs.getString(key_user_toko);
  }

  static Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString('name');
  }

  static Future<String?> getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(key_device_id);
  }

  static Future<String?> getDeviceName() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(key_device_name);
  }

  static Future<String?> getLastLogin() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(key_last_login);
  }

  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    log("cek role ${prefs}");
    return prefs.getString('role');
  }

  static Future<String?> getUserAccess() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key_list_access);
  }

  static Future<void> clearLastLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key_last_login);
  }

  static Future<void> clearSubmit() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key_submit);
  }

  static Future<void> clearUserId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key_user_id);
  }
}
