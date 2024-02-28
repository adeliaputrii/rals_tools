import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import 'app_shared_pref.dart';

class CheckUser {
  CheckUser._();

  static Future<bool> checkSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var lastLogin = await SharedPref.getLastLogin();
    DateTime dateTime = DateTime.parse(lastLogin ?? '${formattedDate}');
    final sevenDays = DateFormat('yyyy-MM-dd').format(dateTime.add(const Duration(days: 7)));

    return formattedDate == sevenDays || DateTime.now().isAfter(dateTime.add(const Duration(days: 7)));
  }
}
