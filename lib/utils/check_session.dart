import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class CheckSession {
  Future<bool> checkSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var waktuLogin = prefs.getString("waktuLogin");

    return waktuLogin == formattedDate;
  }
}
