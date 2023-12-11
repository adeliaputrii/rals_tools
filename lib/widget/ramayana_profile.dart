part of 'import.dart';

class Profilee extends StatefulWidget {
  const Profilee({super.key});

  @override
  State<Profilee> createState() => _ProfileeState();
}

class _ProfileeState extends State<Profilee> {
  TextEditingController myControllerFullname = TextEditingController();
  TextEditingController myControllerDivisi = TextEditingController();
  TextEditingController myControllerID = TextEditingController();
  TextEditingController myControllerEmail = TextEditingController();

  static UserData userData = UserData();

  String _fullname = '';
  String _scanBarcode = '';
  String _email = '';
  var _member = '';
  String _divisi = '';
  String _udid = 'Unknown';
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  var dio = Dio();
  bool isOn = false;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _loadMember();
  }

  Future<void> initPlatformState() async {
    String udid;
    fcmToken = await _firebaseMessaging.getToken();
    try {
      udid = await FlutterUdid.consistentUdid;
    } on PlatformException {
      udid = 'Failed to get UDID.';
    }

    if (!mounted) return;

    setState(() {
      _udid = udid;
    });
  }

  _loadMember() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print('_member ${prefs.getString('member')}');
    setState(() {
      _member = (prefs.getString('member') ?? '');
    });
    return _member;
  }

  Future<void> dapetinData() async {
    setState(() => loading = true);
    UserData userData = UserData();
    await userData.getPref();
    String userId = userData.getUsernameID();
    print('grgr 123');
    print(userId);
  }

  Widget myWidget = Center(
    child: Container(
        key: ValueKey(2),
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Container(
          width: 700,
          height: 280,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 235, 227, 227),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            image: DecorationImage(
              image: AssetImage('assets/newww.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                height: 25,
                margin:
                    EdgeInsets.only(top: 175, bottom: 0, left: 10, right: 10),
                child: ListTile(
                  trailing: Text(
                    '${userData.getFullname()}',
                    style: GoogleFonts.plusJakartaSans(
                        textStyle: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                height: 50,
                margin: EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
                child: ListTile(
                  trailing: Text(
                    '${userData.getUsernameID()}',
                    style: GoogleFonts.plusJakartaSans(
                        textStyle: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              )
            ],
          ),
        )),
  );

  logoutPressed() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('username');
    pref.remove('waktuLogin');
    pref.remove('serialImei');
    imei = '';
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
      return RamayanaLogin();
    }));
  }

  sweatAlert() {
    var alertStyle = AlertStyle(
      titlePadding: EdgeInsets.only(top: 0),
      animationType: AnimationType.fromRight,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: GoogleFonts.plusJakartaSans(
        fontSize: 19,
        color: Colors.black,
      ),
      descTextAlign: TextAlign.center,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: GoogleFonts.plusJakartaSans(
          fontSize: 23, color: Colors.red, fontWeight: FontWeight.w500),
      alertAlignment: Alignment.center,
    );
    Alert(
      style: alertStyle,
      context: context,
      image: FadeInImageWidget(imageUrl: "assets/logout.png"),
      title: 'Log Out',
      desc: "Are you sure you want to log out?",
      buttons: [
        DialogButton(
          radius: BorderRadius.circular(20),
          color: Colors.green,
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              _selectedIndex = 2;
            });
          },
          child: Text(
            "Cancel",
            style:
                GoogleFonts.plusJakartaSans(fontSize: 15, color: Colors.white),
          ),
        ),
        DialogButton(
          radius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 210, 14, 0),
          onPressed: () async {
            AndroidDeviceInfo info = await deviceInfo.androidInfo;
            var formData = FormData.fromMap({
              'progname': 'RALS_TOOLS ',
              'versi': '${versi}',
              'date_run': '${DateTime.now()}',
              'info1': 'Logout Aplikasi RALS',
              ' info2':
                  '${_udid} ', //ini disini yang imei ya del? iya pak. ini lari nya kemana ya del isi nya? -reza sebentar pak, saya ijin ke belakang

              'userid': '${userData.getUsernameID()}',
              ' toko': '${userData.getUserToko()}',
              ' devicename': '${info.device}',
              'TOKEN': 'R4M4Y4N4'
            });

            var response = await dio.post('${tipeurl}v1/activity/createmylog',
                data: formData);
            print('berhasil $_udid');
            logoutPressed();
            Navigator.pop(context);
          },
          child: Text(
            "Log Out",
            style:
                GoogleFonts.plusJakartaSans(fontSize: 15, color: Colors.white),
          ),
        ),
      ],
    ).show();
    return;
  }

  var fcmToken;
  int _selectedIndex = 2;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        sweatAlert();
      } else if (_selectedIndex == 1) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
          return DefaultBottomBarController(child: Ramayana());
        }));
      }
    });
  }

  final _firebaseMessaging = FirebaseMessaging.instance;
  initNotification() async {
    await _firebaseMessaging.requestPermission();
    setState(() async {});
    print('Token : ${fcmToken}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Profile', style: TextStyle(fontSize: 23)),
          backgroundColor: Color.fromARGB(255, 210, 14, 0),
          elevation: 0,
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 18,
          unselectedFontSize: 15,
          selectedIconTheme: IconThemeData(color: Colors.white, size: 35),
          selectedItemColor: Colors.white,
          unselectedIconTheme: IconThemeData(
              color: Color.fromARGB(255, 216, 216, 216), size: 23),
          unselectedItemColor: Color.fromARGB(255, 216, 216, 216),
          selectedLabelStyle: GoogleFonts.plusJakartaSans(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
          unselectedLabelStyle:
              GoogleFonts.plusJakartaSans(fontSize: 11, color: Colors.grey),
          currentIndex: _selectedIndex, //New
          onTap: _onItemTapped,
          backgroundColor: Color.fromARGB(255, 210, 14, 0),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(IconlyBold.logout),
              label: 'LOG OUT',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyBold.home),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyBold.profile),
              label: 'PROFILE',
            ),
          ],
        ),
        body: ListView(
          children: [
            Stack(fit: StackFit.loose, children: <Widget>[
              Container(
                // height: MediaQuery.of(context).size.height/1.29,
                color: Colors.white,
              ),
              Container(
                height: 100,
                color: Color.fromARGB(255, 210, 14, 0),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 500,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(17, 370, 17, 0),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 80,
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 210, 14, 0),
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage('assets/fullname.png')),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text(
                                      'Fullname',
                                      style: GoogleFonts.plusJakartaSans(
                                          textStyle: TextStyle(
                                              fontSize: 19,
                                              color: Color.fromARGB(
                                                  255, 71, 70, 70),
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text(
                                      userData.getFullname() == null
                                          ? '-'
                                          : '${userData.getFullname()}',
                                      style: GoogleFonts.plusJakartaSans(
                                          textStyle: TextStyle(
                                              fontSize: 17,
                                              color: Color.fromARGB(
                                                  255, 71, 70, 70))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        height: 80,
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 210, 14, 0),
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage('assets/email.png')),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text(
                                      'Email',
                                      style: GoogleFonts.plusJakartaSans(
                                          textStyle: TextStyle(
                                              fontSize: 19,
                                              color: Color.fromARGB(
                                                  255, 71, 70, 70),
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text(
                                      userData.getEmail() == null
                                          ? '-'
                                          : '${userData.getEmail()}',
                                      style: GoogleFonts.plusJakartaSans(
                                          textStyle: TextStyle(
                                              fontSize: 17,
                                              color: Color.fromARGB(
                                                  255, 71, 70, 70))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Container(
                      //        height: 80,
                      //        margin: EdgeInsets.only(bottom: 20),
                      //        decoration: BoxDecoration(
                      //       color: Colors.grey[200],
                      //       borderRadius: BorderRadius.circular(20)
                      //     ),
                      //     child: Row(
                      //       children: [
                      //         Container(
                      //           margin: EdgeInsets.only(left: 20),
                      //           child: CircleAvatar(
                      //           backgroundColor: Color.fromARGB(255, 210, 14, 0),
                      //           radius: 30,
                      //           backgroundImage: AssetImage('assets/telp.png')),
                      //         ),
                      //         Container(
                      //           margin: EdgeInsets.only(top: 12),
                      //           child: Column(
                      //             mainAxisAlignment: MainAxisAlignment.start,
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //                 Container(
                      //                   margin: EdgeInsets.only(left: 20),
                      //                   child: Text('No. HP',
                      //                   style: GoogleFonts.plusJakartaSans(
                      //                     textStyle: TextStyle(
                      //                       fontSize: 19,
                      //                       color: Color.fromARGB(255, 71, 70, 70),
                      //                       fontWeight: FontWeight.w500
                      //                       )
                      //                   ),
                      //                   ),
                      //                 ),
                      //                 SizedBox(
                      //                   height: 5,
                      //                 ),
                      //                  Container(
                      //                   margin: EdgeInsets.only(left: 20),
                      //                    child: Text(userData.getPhone() != null ? '-' : '${userData.getPhone()}',
                      //                     style: GoogleFonts.plusJakartaSans(
                      //                     textStyle: TextStyle(
                      //                       fontSize: 17,
                      //                       color: Color.fromARGB(255, 71, 70, 70))), ),
                      //                  ),
                      //             ],),
                      //         ),
                      //       ],
                      //     ),
                      //   ),

                      Container(
                        height: 80,
                        margin: EdgeInsets.only(bottom: 30),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 210, 14, 0),
                                  radius: 30,
                                  backgroundImage: AssetImage('assets/id.png')),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text(
                                      'ID',
                                      style: GoogleFonts.plusJakartaSans(
                                          textStyle: TextStyle(
                                              fontSize: 19,
                                              color: Color.fromARGB(
                                                  255, 71, 70, 70),
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text(
                                      userData.getUsernameID() == null
                                          ? '-'
                                          : '${userData.getUsernameID()}',
                                      style: GoogleFonts.plusJakartaSans(
                                          textStyle: TextStyle(
                                              fontSize: 17,
                                              color: Color.fromARGB(
                                                  255, 71, 70, 70))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 10, bottom: 30),
                          child: Text(
                            'Version ${versi} Copyright RALS@2023',
                            style: GoogleFonts.plusJakartaSans(
                                textStyle: TextStyle(
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 71, 70, 70))),
                          ),
                        ),
                      )
                    ],
                  )),
              Container(
                  margin: EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AnimatedSwitcher(
                          child: myWidget,
                          duration: Duration(seconds: 1),
                          transitionBuilder: (child, animation) =>
                              FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Switch(
                            activeColor: Color.fromARGB(255, 210, 14, 0),
                            activeThumbImage: AssetImage(
                              'assets/ramayana(C).png',
                            ),
                            value: isOn,
                            onChanged: (newValue) {
                              isOn = newValue;
                              setState(() {
                                if (isOn)
                                  myWidget = Center(
                                    child: Container(
                                      key: ValueKey(1),
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Container(
                                          width: 700,
                                          height: 280,
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 235, 227, 227),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                            ),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/desain(C).png'),
                                                fit: BoxFit.fill),
                                          ),
                                          child: Container(
                                              margin: EdgeInsets.only(
                                                  top: 20,
                                                  bottom: 30,
                                                  left: 10,
                                                  right: 10),
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    QrImage(
                                                      foregroundColor:
                                                          Colors.white,
                                                      data: "${_member}",
                                                      version: QrVersions.auto,
                                                      size: 85.0,
                                                    ),
                                                    BarCodeImage(
                                                      backgroundColor:
                                                          Colors.white,
                                                      params:
                                                          Code128BarCodeParams(
                                                        "${_member}",
                                                        lineWidth: 1.5,
                                                        barHeight: 75,
                                                        // withText: true,
                                                      ),
                                                      padding: EdgeInsets.only(
                                                          bottom: 7),
                                                      onError: (error) {
                                                        // Error handler
                                                        print('error = $error');
                                                      },
                                                    ),
                                                  ]))),
                                    ),
                                  );
                                else
                                  myWidget = Center(
                                      child: Container(
                                    key: ValueKey(2),
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Container(
                                      width: 700,
                                      height: 280,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 235, 227, 227),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                        image: DecorationImage(
                                            image:
                                                AssetImage('assets/newww.png'),
                                            fit: BoxFit.fill),
                                      ),
                                      child: ListView(
                                        children: [
                                          Container(
                                            alignment: Alignment.centerRight,
                                            height: 25,
                                            margin: EdgeInsets.only(
                                                top: 175,
                                                bottom: 0,
                                                left: 10,
                                                right: 10),
                                            child: ListTile(
                                              trailing: Text(
                                                '${userData.getFullname()}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            height: 50,
                                            margin: EdgeInsets.only(
                                                top: 0,
                                                bottom: 0,
                                                left: 10,
                                                right: 10),
                                            child: ListTile(
                                              trailing: Text(
                                                '${userData.getUsernameID()}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                              });
                            })
                      ])),
            ]),
          ],
        ));
  }
}
