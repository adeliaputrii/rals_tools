part of 'SP_service.dart';

class UserData {
  Dio dio = Dio();
  RamayanaLogin ramayanaLogin = RamayanaLogin();

  static const String logstatus = "_statuslog_str";
  static const String user_id_str = "user_id_str";
  static const String user_name_str = "user_name_str";
  static const String user_fullname_str = "user_name_str";
  static const String user_email_str = "user_email_str";
  static const String user_address_str = "user_address_str";
  static const String user_phone_str = "user_phone_str";
  static const String user_pass_str = "password_str";
  static const String isAdmin_str = "is_admin_str";
  static const String username_str = "username_str";
  static const String user_picUrl_str = "userpic_url_str";
  static const String user_token_str = "user_token_str";
  static const String user_toko_str = "user_toko_str";
  static const String user_role_str = "user_role_str";
  static const String user_akses_str = "user_akses_str";
  static const String user_subdivisi_str = "user_subdivisi_str";
  static const String username7_str = "username7_str";
  static const String listmenu_str = "listmenu_str";

  static bool _isAdmin = false;
  static bool _statuslog = false;
  static String _userName = '';
  static String _userFullName = '';
  static String _userNameOfUser = '';
  static String _userAdress = '';
  static String _userEmail = '';
  static String _userSubdivisi = '';
  static String _userPassword = '';
  static String _userPhone = '';
  static String _userPicUrl = '';
  static String _userID = '';
  static String _userRole = '';
  static String _listmenu = '';
  static late String _userToken = '';
  static late String _userToko = '';
  static late String _userAkses = '';
  static late String _username7 = '';
  var token = '';
  var fcmToken;
  final _firebaseMessaging = FirebaseMessaging.instance;

  bool getAdminStatus() {
    return _isAdmin;
  }

  bool getStatusLog() {
    return _statuslog;
  }

  String getUserToken() {
    return _userToken;
  }

  String getUserToko() {
    return _userToko;
  }

  String getUserAkses() {
    return _userAkses;
  }

  String getUserRole() {
    return _userRole;
  }

  String getUserPassword() {
    return _userPassword;
  }

  String getUserID() {
    return _userID;
  }

  String getFullname() {
    return _userFullName;
  }

  String getUsernameID() {
    return _userName;
  }

  String getnameofUser() {
    return _userNameOfUser;
  }

  String getEmail() {
    return _userEmail;
  }

  String getSubdivisi() {
    return _userSubdivisi;
  }

  String getPhone() {
    return _userPhone;
  }

  String getPicurl() {
    return _userPicUrl;
  }

  String getAdress() {
    return _userAdress;
  }

  String getUsername7() {
    return _username7;
  }

  String getListMenu() {
    return _listmenu;
  }

  void debugPrintdevinfo() {
    debugPrint("\n\n======[info]=======]");
    debugPrint("ID       : $_userID");
    debugPrint("Username : $_userName");
    debugPrint("Name     : $_userFullName");
    debugPrint("Toko     : $_userToko");
    debugPrint("Email    : $_userEmail");
    debugPrint("Subdivisi: $_userSubdivisi");
    debugPrint("Role     : $_userRole");
    debugPrint("Akses    : $_userAkses");
    debugPrint("Username7 : $_username7");
    debugPrint("List Menu : $_listmenu");
    // debugPrint("Phone    : $_userPhone");
    // debugPrint("adress   : $_userAdress");
    // debugPrint("Password : $_userPassword");
    // debugPrint("Pic URL  : $_userPicUrl");
    // debugPrint("Log stat : $_statuslog");
    // debugPrint("Admin    : $_isAdmin");
  }

  Future<void> logOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    const String nodata = 'No Data Avail';
    pref.setString(UserData.user_id_str, nodata);
    pref.setString(UserData.username_str, nodata);
    pref.setString(UserData.user_name_str, nodata);
    pref.setString(UserData.user_fullname_str, nodata);
    pref.setString(UserData.user_email_str, nodata);
    pref.setString(UserData.user_subdivisi_str, nodata);
    pref.setString(UserData.user_pass_str, nodata);
    pref.setString(UserData.user_phone_str, nodata);
    pref.setString(UserData.user_picUrl_str, nodata);
    pref.setString(UserData.user_address_str, nodata);
    pref.setString(UserData.user_token_str, nodata);
    pref.setString(UserData.user_toko_str, nodata);
    pref.setString(UserData.user_role_str, nodata);
    pref.setString(UserData.user_akses_str, nodata);
    pref.setString(UserData.username7_str, nodata);
    pref.setString(UserData.listmenu_str, nodata);
    pref.setBool(UserData.isAdmin_str, false);
    pref.setBool(UserData.logstatus, false);
    await getPref();
    debugPrint('[Account dev] : Data wiped out');
    debugPrintdevinfo();
    return;
  }

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    fcmToken = await _firebaseMessaging.getToken();
    debugPrint('Token kirim api : ${fcmToken}');
    return fcmToken;
  }

  @override
  void initState() {
    initNotification();
  }

  sendTokenFirebase() async {
    debugPrint(getUserToken());
    debugPrint('${fcmToken}');
    debugPrint('${initNotification()}');
  }

  Future<void> setUser({required Map data}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(UserData.logstatus, true);
    pref.setString(UserData.user_id_str, data['data']['user_id'].toString());
    pref.setString(UserData.username_str, data['data']['username'].toString());
    pref.setString(UserData.user_fullname_str, data['data']['name'].toString());
    pref.setString(UserData.user_email_str, data['data']['email'].toString());
    pref.setString(
        UserData.user_subdivisi_str, data['data']['id_sub_divisi'].toString());
    pref.setString(UserData.user_token_str, data['access_token'].toString());
    pref.setString(UserData.user_toko_str, data['data']['toko'].toString());
    pref.setString(UserData.user_role_str, data['data']['role'].toString());
    pref.setString(
        UserData.user_akses_str, data['data']['akses_menu'].toString());
    pref.setString(
        UserData.username7_str, data['data']['username7'].toString());
    pref.setString(UserData.listmenu_str, data['data']['list_menu'].toString());
    // pref.getString('tokenApi', data['access_token'].toString());
    // if (data['akses'] == 'adm') {
    //   pref.setBool(UserData.isAdmin_str, true);
    // } else {
    //   pref.setBool(UserData.isAdmin_str, false);
    // }
    var token = pref.getString('firebaseToken');
    await getPref();
    debugPrint('[LOGIN INFO] : Updated..!');
    debugPrintdevinfo();
    try {
      var formData = FormData.fromMap({
        'device_token': '${token}',
      });
      var response = await dio.post(
        '${tipeurl}api/v1/auth/fcm-token',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${getUserToken()}',
            'Content-Type': 'application/json',
          },
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
    return;
  }

  Future<void> setDataUser(LoginResponse data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(UserData.logstatus, true);
    pref.setString(UserData.user_id_str, data.data!.userId.toString());
    pref.setString(UserData.username_str, data.data!.username.toString());
    pref.setString(UserData.user_fullname_str, data.data!.name.toString());
    pref.setString(UserData.user_email_str, data.data!.email.toString());
    pref.setString(
        UserData.user_subdivisi_str, data.data!.idSubDivisi.toString());
    pref.setString(UserData.user_token_str, data.accessToken.toString());
    pref.setString(UserData.user_toko_str, data.data!.toko.toString());
    pref.setString(UserData.user_role_str, "Admin");
    pref.setString(UserData.user_akses_str, data.data!.aksesMenu.toString());
    pref.setString(UserData.username7_str, data.data!.username7.toString());
    pref.setString(UserData.listmenu_str, data.data!.listMenu.toString());
    // pref.getString('tokenApi', data['access_token'].toString());
    // if (data['akses'] == 'adm') {
    //   pref.setBool(UserData.isAdmin_str, true);
    // } else {
    //   pref.setBool(UserData.isAdmin_str, false);
    // }
    var token = pref.getString('firebaseToken');
    await getPref();
    debugPrint('[LOGIN INFO] : Updated..!');
    debugPrintdevinfo();
    try {
      var formData = FormData.fromMap({
        'device_token': '${token}',
      });
      var response = await dio.post(
        '${tipeurl}api/v1/auth/fcm-token',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${getUserToken()}',
            'Content-Type': 'application/json',
          },
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
    return;
  }

  Future<void> getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _userID = pref.getString(user_id_str).toString();
    _userName = pref.getString(username_str).toString();
    _userFullName = pref.getString(user_fullname_str).toString();
    _userNameOfUser = pref.getString(user_name_str).toString();
    _userPassword = pref.getString(user_pass_str).toString();
    _userEmail = pref.getString(user_email_str).toString();
    _userSubdivisi = pref.getString(user_subdivisi_str).toString();
    _userPicUrl = pref.getString(user_picUrl_str).toString();
    _userPhone = pref.getString(user_phone_str).toString();
    _userAdress = pref.getString(user_address_str).toString();
    _userToken = pref.getString(user_token_str).toString();
    _userToko = pref.getString(user_toko_str).toString();
    _userRole = pref.getString(user_role_str).toString();
    _userAkses = pref.getString(user_akses_str).toString();
    _username7 = pref.getString(username7_str).toString();
    _listmenu = pref.getString(listmenu_str).toString();
    if (pref.getBool(logstatus) == null || pref.getBool(logstatus) == false) {
      _statuslog = false;
    } else {
      _statuslog = true;
    }
    if (pref.getBool(isAdmin_str) == null ||
        pref.getBool(isAdmin_str) == false) {
      _isAdmin = false;
    } else {
      _isAdmin = true;
    }
    return;
  }
}
