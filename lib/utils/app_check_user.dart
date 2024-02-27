import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import 'app_shared_pref.dart';

class CheckUser {
  CheckUser._();

  static Future<bool> checkSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var waktuLogin = await SharedPref.getLastLogin();

    return waktuLogin == formattedDate;
  }
}
