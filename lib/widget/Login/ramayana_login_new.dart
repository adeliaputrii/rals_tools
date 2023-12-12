part of 'import.dart';

class RamayanaLogin extends StatefulWidget {
  const RamayanaLogin({super.key});

  static const route = '/ramayana-login-screen';

  @override
  _RamayanaLogin createState() => _RamayanaLogin();
}

class _RamayanaLogin extends State<RamayanaLogin> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool update = false;
  DeviceInfoPlugin devicePlugin = DeviceInfoPlugin();
  late AndroidDeviceInfo deviceInfo;
  AppUpdateInfo? _updateInfo;
  bool _flexibleUpdateAvailable = false;
  String _udid = 'Unknown';
  bool isLoading = false;
  bool _passwordVisible = false;
  Timer? timer;
  bool _isLoading = true;
  var imei2 = '';
  SimData? _simData;
  late LoginCubit loginCubit;
  late PopUpWidget popUpWidget;
  late CreateLogBody createLogBody;
  late SharedPreferences pref;
  var token = '';
  static var fcmToken;
  final _firebaseMessaging = FirebaseMessaging.instance;
  @override
  void initState() {
    loginCubit = context.read<LoginCubit>();
    popUpWidget = PopUpWidget(context);
    init();
    print(versi);
    print('wakwaw 123');
    super.initState();
    _passwordVisible = false;
    deleteUserData();
    // fetchDataNoKartu(id_user: '${userData.getUsername7()}');
  }

  Future<void> init() async {
    deviceInfo = await devicePlugin.androidInfo;
    pref = await SharedPreferences.getInstance();
    checkForUpdate();
    initSim();
    initPlatformState();
    initNotification();
  }

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    fcmToken = "";
    // fcmToken = await _firebaseMessaging.getToken();
    print('Token kirim api : ${fcmToken}');
    return fcmToken;
  }

  _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('token ${prefs.getString('token')}');
    setState(() {
      token = (prefs.getString('token') ?? '');
    });
    return token;
  }

  Future<void> initSim() async {

    SimData simData;
    try {
      var status = await Permission.phone.status;
      if (!status.isGranted) {
        bool isGranted = await Permission.phone.request().isGranted;
        if (!isGranted) return;
      }
      simData = await SimDataPlugin.getSimData();
      setState(() {
        _isLoading = false;
        _simData = simData;

      });
      void printSimCardsData() async {
        try {
          SimData simData = await SimDataPlugin.getSimData();
          SharedPreferences pref = await SharedPreferences.getInstance();
          for (var s in simData.cards) {
             imei2 = '${s.serialNumber}';
            if (s.slotIndex == 1) {
              pref.setString('serialImei', '${s.serialNumber}');
            }
            print('Serial number: ${s.serialNumber}');
            print('Data Roaming: ${s.isNetworkRoaming}');
          }
        } on PlatformException catch (e) {
          debugPrint("error! code: ${e.code} - message: ${e.message}");
        }
      }

      printSimCardsData();
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        _isLoading = false;
        _simData = null;
      });
    }
  }

  Future<void> deleteUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('Reset Username');
    print('delete usernameController');
  }

  Future<void> initPlatformState() async {
    String udid;
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

  Future<void> checkForUpdate() async {
    if (!kDebugMode) {
      InAppUpdate.checkForUpdate().then((info) {
        setState(() {
          _updateInfo = info;
          print('check');
        });
      }).catchError((e) {
        showSnack(e.toString());
      });
    }
  }

  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }

  String? _userId;
  String _password = '';

  UserData userData = UserData();

  void _displayCenterMotionToast() async {
    MotionToast(
      toastDuration: Duration(seconds: 4),
      icon: Icons.error,
      primaryColor: Colors.red,
      title: const Text(
        'Username/Password not found!',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      ),
      width: 350,
      backgroundType: BackgroundType.lighter,
      height: 100,
      description: const Text(
        'Please Check Again',
        style: TextStyle(fontSize: 15),
      ),
      //description: "Center displayed motion toast",
      position: MotionToastPosition.center,
    ).show(context);
  }

  void _displayCenterMotionUsername() async {
    MotionToast(
      toastDuration: Duration(seconds: 4),
      icon: Icons.error,
      primaryColor: Colors.red,
      title: const Text(
        'Username Harus Diisi!',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      ),
      width: 350,
      backgroundType: BackgroundType.lighter,
      height: 100,
      description: const Text(
        'Please Check Again',
        style: TextStyle(fontSize: 15),
      ),
      //description: "Center displayed motion toast",
      position: MotionToastPosition.center,
    ).show(context);
  }

  void _displayCenterMotionUsernameCheck() async {
    MotionToast(
      toastDuration: Duration(seconds: 4),
      icon: Icons.error,
      primaryColor: Colors.red,
      title: const Text(
        'Username Tidak Terdaftar!',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      ),
      width: 350,
      backgroundType: BackgroundType.lighter,
      height: 100,
      description: const Text(
        'Please Check Again',
        style: TextStyle(fontSize: 15),
      ),
      //description: "Center displayed motion toast",
      position: MotionToastPosition.center,
    ).show(context);
  }

  void _displayCenterMotionToastImei() async {
    MotionToast(
      toastDuration: Duration(seconds: 4),
      icon: Icons.error,
      primaryColor: Colors.red,
      // title: const Text(
      //   'ID Sudah Digunakan di Perangkat Lain',
      //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      // ),
      width: 350,
      backgroundType: BackgroundType.lighter,
      height: 100,
      description: const Text(
        'Anda tidak memiliki akses',
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
      //description: "Center displayed motion toast",
      position: MotionToastPosition.center,
    ).show(context);
  }

  void _displayCenterMotionToastSuccess() {
    MotionToast(
      toastDuration: Duration(seconds: 10),
      icon: IconlyBold.tickSquare,
      primaryColor: Colors.green,
      title: const Text(
        "Success",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      ),
      width: 350,
      backgroundType: BackgroundType.lighter,
      height: 100,
      description: const Text(
        'You can login with a new password',
        style: TextStyle(fontSize: 15),
      ),
      //description: "Center displayed motion toast",
      position: MotionToastPosition.top,
    ).show(context);
  }

  void updateAplikasi(BuildContext context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Update Aplikasi",
      desc: "Anda Perlu Memperbarui Aplikasi",
      buttons: [
        DialogButton(
          color: Color.fromARGB(255, 255, 17, 17),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Tidak",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
        DialogButton(
          color: Colors.green,
          onPressed: () async {
            AndroidDeviceInfo info = await devicePlugin.androidInfo;
            var formData = FormData.fromMap({
              'progname': 'RALS_TOOLS ',
              'versi': '${versi}',
              'date_run': '${DateTime.now()}',
              'info1': 'Pop Up Update Aplikasi',
              ' info2': '${info.serialNumber} ',
              'userid': '${userData.getUsernameID()}',
              ' toko': '${userData.getUserToko()}',
              ' devicename': '${info.device}',
              'TOKEN': 'R4M4Y4N4'
            });

            var response = await dio.post('${tipeurl}v1/activity/createmylog',
                data: formData);
            print('berhasil $_udid');
            LaunchReview.launch(
                androidAppId: "com.rals.myactivity_project_dev");
            Navigator.pop(context);
          },
          child: Text(
            "Ya, Perbarui Aplikasi",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ],
    ).show();
    return;
  }

  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  fetchDataNoKartu({required String id_user}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('${userData.getUsername7()}');
    print(tipeurl);
    ApprovalIdcashCustomer.approvalidcashcust.clear();
    final responseku = await http.post(
        Uri.parse('${tipeurl}v1/membercards/tbl_customer'),
        body: {'id_user': '${userData.getUsername7()}'});

    var data = jsonDecode(responseku.body);

    if (data['status'] == 200) {
      print("API Success oooo");
      print(data);
      int count = data['data'].length;
      final Map<String, ApprovalIdcashCustomer> profileMap = new Map();
      for (int i = 0; i < count; i++) {
        ApprovalIdcashCustomer.approvalidcashcust
            .add(ApprovalIdcashCustomer.fromjson(data['data'][i]));
      }
      ApprovalIdcashCustomer.approvalidcashcust.forEach((element) {
        print('oke');
        if (ApprovalIdcashCustomer.noMember.isEmpty) {
          ApprovalIdcashCustomer.noMember.add(element.nokartu);
          prefs.setString('noMember', '${element.nokartu}');
          print('empty');
          print(ApprovalIdcashCustomer.noMember);
        }
        profileMap[element.nokartu] = element;
        ApprovalIdcashCustomer.approvalidcashcust = profileMap.values.toList();
        print(ApprovalIdcashCustomer.approvalidcashcust);
      });

      loginCubit.createLog(createLogBody);
      print('check length ${ApprovalIdcashCustomer.approvalidcashcust.length}');
      print('data customer' + data['data'].toString());
    } else {
      print('NO DATA');
    }

    setState(() {});
  }

  loginPressed() async {
    if (usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      final body = LoginBody(
          userName: usernameController.text,
          password: passwordController.text,
          deviceId: "${imei2}${deviceInfo.device}");
      loginCubit.login(loginBody: body);
    }

    // print(versi);
    // print('daaaaaaamn 23111');
    // print(tipeurl);
    // try {
    //   if (usernameController.text.isNotEmpty && passwordController.text.isNotEmpty) {
    //     SharedPreferences pref = await SharedPreferences.getInstance();
    //     AndroidDeviceInfo info = await devicePlugin.androidInfo;
    //     final body = LoginBody(
    //         userName: usernameController.text,
    //         password: password.text,
    //         deviceId: "samsung");
    //     loginCubit.login(loginBody: body);
    //     // imei = pref.getString('serialImei')!;
    //     http.Response response =
    // await AuthServices.login(usernameController.text, passwordController.text);
    // await AuthServicesLog.login(
    //       //' ini versi yang sama kaya diataskan ya del?
    //       usernameController.text,
    //       passwordController.text,
    //       'RALS-TOOLS',
    //       '${versi}',
    //       '${DateTime.now()}',
    //       'Login Aplikasi RALS',
    //       '${imei}',
    //       '${usernameController.text}',
    //       'toko',
    //       '${info.brand}',
    //       '${_udid}',
    //       // '${imei}${info.device}',
    //     );
    //     if (response.statusCode == 200) {
    //       Map responseMap = jsonDecode(response.body);
    //       if (responseMap['userpass'] == "0") {
    //         await userData.setUser(data: responseMap);
    //         pref.setString("usernameController", "${usernameController.text}");
    //         pref.setString("token", "${responseMap['access_token']}");
    //         pref.setString("waktuLogin", "${formattedDate}");
    //         var formData = FormData.fromMap({
    //           'progname': 'RALS_TOOLS ',
    //           'versi': '${versi}',
    //           'date_run': '${DateTime.now()}',
    //           'info1': 'Login Aplikasi RALS',
    //           ' info2': '${imei}',
    //           'userid': '${userData.getUsernameID()}',
    //           ' toko': '${userData.getUserToko()}',
    //           ' devicename': '${info.device}',
    //           'TOKEN': 'R4M4Y4N4'
    //         });
    //         // var responseDataNoKartu =
    //         //     await fetchDataNoKartu(id_user: usernameController.text.toString());
    //         var response = await dio.post('${tipeurl}v1/activity/createmylog',
    //             data: formData);
    //         print('berhasil $_udid');

    //         Navigator.pushAndRemoveUntil(
    //             context,
    //             MaterialPageRoute(
    //                 builder: (context) =>
    //                     DefaultBottomBarController(child: Ramayana())),
    //             (Route<dynamic> route) => false);
    //       } else if (responseMap['status'] == 909) {
    //         updateAplikasi(context);
    //       } else if (responseMap['userpass'] == "1") {
    //         AlertDialog popup = AlertDialog(
    //           shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(20),
    //           ),
    //           // shadowColor: Colors.black,
    //           titlePadding: EdgeInsets.all(0),
    //           title: Column(
    //             children: [
    //               Container(
    //                   decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.only(
    //                         topLeft: Radius.circular(20),
    //                         topRight: Radius.circular(20),
    //                       ),
    //                       color: Color.fromARGB(255, 254, 234, 233)),
    //                   height: 190,
    //                   width: 2000,
    //                   child: Image.asset(
    //                     'assets/adel.png',
    //                   )),
    //               Container(
    //                 margin: EdgeInsets.only(top: 0),
    //                 color: Colors.black,
    //                 height: 1,
    //                 width: 2000,
    //               ),
    //             ],
    //           ),

    //           content: Form(
    //             key: _formKey2,
    //             child: Container(
    //               height: 230,
    //               width: 500,
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Text(
    //                         'Password:',
    //                         style: TextStyle(
    //                             color: Colors.black,
    //                             fontWeight: FontWeight.bold,
    //                             fontSize: 15),
    //                       ),
    //                       SizedBox(
    //                         height: 10,
    //                       ),
    //                       TextFormField(
    //                           controller: password,
    //                           style:
    //                               TextStyle(fontSize: 20, color: Colors.black),
    //                           validator: (value) {
    //                             if (value!.isEmpty) {
    //                               return "Required";
    //                             }

    //                             if (value.length != 6) {
    //                               return "Password length must be 6 characters";
    //                             }

    //                             if (!value.contains(RegExp(r'[0-9]'))) {
    //                               return "Password must contain a number";
    //                             }

    //                             if (value == usernameController.text) {
    //                               return "Password can't same with usernameController";
    //                             }
    //                           },
    //                           obscureText: true,
    //                           keyboardType: TextInputType.number,
    //                           inputFormatters: [
    //                             FilteringTextInputFormatter.digitsOnly
    //                           ],
    //                           decoration: InputDecoration(
    //                               border: OutlineInputBorder(
    //                                   borderSide: BorderSide(
    //                                       color: Colors.black, width: 5.0),
    //                                   borderRadius: BorderRadius.circular(60)),
    //                               errorBorder: OutlineInputBorder(
    //                                   borderSide: BorderSide(
    //                                     color: Color.fromARGB(255, 255, 17, 17),
    //                                   ),
    //                                   borderRadius: BorderRadius.circular(60)),
    //                               errorStyle: TextStyle(
    //                                   color: Color.fromARGB(255, 255, 17, 17),
    //                                   fontSize: 14,
    //                                   fontWeight: FontWeight.w400),
    //                               labelStyle: TextStyle(color: Colors.black87),
    //                               prefixIcon: Icon(
    //                                 IconlyBroken.lock,
    //                                 color: Color.fromARGB(255, 255, 17, 17),
    //                               ),
    //                               hintStyle: TextStyle(
    //                                   color: Colors.black, fontSize: 20),
    //                               enabledBorder: OutlineInputBorder(
    //                                   borderSide:
    //                                       new BorderSide(color: Colors.black),
    //                                   borderRadius: BorderRadius.circular(60)),
    //                               focusedBorder: OutlineInputBorder(
    //                                   borderSide:
    //                                       new BorderSide(color: Colors.black),
    //                                   borderRadius:
    //                                       BorderRadius.circular(60)))),
    //                     ],
    //                   ),
    //                   Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Text(
    //                         'Re-Enter Password:',
    //                         style: TextStyle(
    //                             color: Colors.black,
    //                             fontWeight: FontWeight.bold,
    //                             fontSize: 15),
    //                       ),
    //                       SizedBox(
    //                         height: 10,
    //                       ),
    //                       TextFormField(
    //                           controller: confirmPasswordController,
    //                           style:
    //                               TextStyle(fontSize: 20, color: Colors.black),
    //                           validator: (value) {
    //                             if (value!.isEmpty) {
    //                               return "Required";
    //                             }

    //                             if (!value.contains(RegExp(r'[0-9]'))) {
    //                               return "Password must contain a number";
    //                             }

    //                             if (value != password.text) {
    //                               return "Please Re-Enter password correctly";
    //                             }
    //                           },
    //                           obscureText: true,
    //                           keyboardType: TextInputType.number,
    //                           inputFormatters: [
    //                             FilteringTextInputFormatter.digitsOnly
    //                           ],
    //                           decoration: InputDecoration(
    //                               border: OutlineInputBorder(
    //                                   borderSide: BorderSide(
    //                                       color: Colors.black, width: 5.0),
    //                                   borderRadius: BorderRadius.circular(60)),
    //                               errorBorder: OutlineInputBorder(
    //                                   borderSide: BorderSide(
    //                                     color: Color.fromARGB(255, 255, 17, 17),
    //                                   ),
    //                                   borderRadius: BorderRadius.circular(60)),
    //                               errorStyle: TextStyle(
    //                                   color: Color.fromARGB(255, 255, 17, 17),
    //                                   fontSize: 14,
    //                                   fontWeight: FontWeight.w400),
    //                               labelStyle: TextStyle(color: Colors.black87),
    //                               prefixIcon: Icon(
    //                                 IconlyBroken.lock,
    //                                 color: Color.fromARGB(255, 255, 17, 17),
    //                               ),
    //                               hintStyle: TextStyle(
    //                                   color: Colors.black, fontSize: 20),
    //                               enabledBorder: OutlineInputBorder(
    //                                   borderSide:
    //                                       new BorderSide(color: Colors.black),
    //                                   borderRadius: BorderRadius.circular(60)),
    //                               focusedBorder: OutlineInputBorder(
    //                                 borderRadius: BorderRadius.circular(60),
    //                                 borderSide:
    //                                     new BorderSide(color: Colors.black),
    //                               )))
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),

    //           actions: [
    //             Container(
    //               margin: EdgeInsets.only(left: 20),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                 children: [
    //                   Container(
    //                     margin: EdgeInsets.only(left: 80, right: 80),
    //                     child: MaterialButton(
    //                         height: 40,
    //                         padding: EdgeInsets.symmetric(horizontal: 80),
    //                         shape: RoundedRectangleBorder(
    //                           borderRadius: BorderRadius.circular(40),
    //                         ),
    //                         color: Color.fromARGB(255, 255, 17, 17),
    //                         child: Text('Submit',
    //                             style: TextStyle(
    //                                 color: Colors.white,
    //                                 fontWeight: FontWeight.w500,
    //                                 fontSize: 17)),
    //                         onPressed: () async {
    //                           if (_formKey2.currentState!.validate()) {
    //                             _displayCenterMotionToastSuccess();

    //                             var formData = FormData.fromMap({
    //                               'user_name': usernameController.text,
    //                               'password': password.text,
    //                             });
    //                             var response = await dio.post(
    //                                 '${tipeurl}api/v1/auth/reset.password',
    //                                 data: formData);

    //                             print(
    //                                 'Berhasil, ${usernameController.text}, ${password.text},${password.text}, ${confirmPasswordController.text}');
    //                             Duration(seconds: 10);

    //                             Navigator.pushAndRemoveUntil(
    //                                 context,
    //                                 MaterialPageRoute(
    //                                   builder: (context) => RamayanaLogin(),
    //                                 ),
    //                                 (Route<dynamic> route) => false);
    //                           }
    //                         }),
    //                   ),
    //                   SizedBox(
    //                     height: 10,
    //                   ),
    //                   Text(
    //                     'Note : ',
    //                     style: TextStyle(
    //                         color: Colors.black,
    //                         fontSize: 15,
    //                         fontWeight: FontWeight.bold),
    //                   ),
    //                   Text(
    //                     'Password baru tidak boleh sama dengan usernameController',
    //                     style: TextStyle(
    //                         color: Colors.black,
    //                         fontSize: 15,
    //                         fontWeight: FontWeight.bold),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //           actionsAlignment: MainAxisAlignment.start,
    //           actionsPadding: EdgeInsets.only(bottom: 30),
    //         );
    //         showDialog(context: context, builder: (context) => popup);
    //       } else if (responseMap['status'] == 201) {
    //         _displayCenterMotionToast();
    //       }
    //     } else {}
    //   }
    // } on Exception {
    //   return _displayCenterMotionToastImei();
    //   //ini buka nya dimana ya del
    // }
  }

  var dio = Dio();

  void showWarning() {
    //do something if usernameController or password isn't filled correctly
  }

  fetchDataCustomer({required String user_name}) async {
    AndroidDeviceInfo info = await devicePlugin.androidInfo;
    final responseku = await http.post(
        Uri.parse('${tipeurl}api/v1/auth/reset.usernameController'),
        body: {'user_name': usernameController.text});

    var data = jsonDecode(responseku.body);

    if (data['status'] == 200) {
      print("API Success oooo");
      print(data);
      // ResetPassword.hidden.add(usernameController.text);
      final SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("Reset Username", "${usernameController.text}");
      var formData = FormData.fromMap({
        'progname': 'RALS_TOOLS ',
        'versi': '${versi}',
        'date_run': '${DateTime.now()}',
        'info1': 'Forgot Password Aplikasi RALS',
        ' info2': '${imei} ',
        'userid': '${usernameController.text}',
        ' toko': '${userData.getUserToko()}',
        ' devicename': '${info.device}',
        'TOKEN': 'R4M4Y4N4'
      });

      var response =
          await dio.post('${tipeurl}v1/activity/createmylog', data: formData);
      print('berhasil $_udid');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RamayanaReset()),
      );
    } else if (data['status'] != 200) {
      _displayCenterMotionUsernameCheck();
    } else {
      print("No Data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading || state is CreateLogLoading) {
          setState(() {
            isLoading = true;
          });
        }
        if (state is LoginSuccess) {
          createLogBody = CreateLogBody(
              toko: state.response.data?.toko,
              userid: state.response.data?.userId,
              versi: versi,
              devicename: deviceInfo.brand,
              progname: logProgname,
              info1: logInfo1,
              info2: deviceInfo.serialNumber,
              dateRun: DateTime.now().toString(),
              token: logToken);
          fetchDataNoKartu(id_user: state.response.data!.userId.toString());
        }
        if (state is LoginFailure) {
          setState(() {
            isLoading = false;
          });
          popUpWidget.showPopUp(pleaseCheck, state.message);
        }
        if (state is CreateLogSuccess) {
          pref.setString("waktuLogin", "${formattedDate}");
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => Ramayana()));
        }
        if (state is CreateLogFailure) {
          setState(() {
            isLoading = false;
          });
          popUpWidget.showPopUp(state.message, state.message);
        }
      },
      child: Scaffold(
        // key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            Container(
              color: Color.fromARGB(255, 240, 238, 238),
            ),
            Container(
              // width: 2000,
              // height: 700,
              color: Color.fromARGB(255, 216, 19, 19),
            ),
            Form(
              key: _formKey,
              child: ListView(
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(25, 50, 25, 0),
                      height: 780,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                          boxShadow: [
                            (BoxShadow(
                                color: Color.fromARGB(255, 185, 185, 185),
                                blurRadius: 5,
                                offset: Offset(2, 4)))
                          ]),
                      child: Column(
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(top: 50),
                              height: 130,
                              child: Image.asset(
                                "assets/rama(C).png",
                                height: 180,
                              )),
                          Container(
                            margin: EdgeInsets.only(top: 35),
                            child: Center(
                                child: Text('Welcome!',
                                    style: GoogleFonts.plusJakartaSans(
                                        fontSize: 35,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600))),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Center(
                                child: Text('Login to Continue',
                                    style: GoogleFonts.plusJakartaSans(
                                        fontSize: 20, color: Colors.black))),
                          ),
                          SizedBox(
                            height: 70,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(
                              cursorColor: Colors.black,
                              controller: usernameController,
                              validator:
                                  RequiredValidator(errorText: 'Please Enter'),
                              keyboardType: TextInputType.multiline,
                              style: GoogleFonts.plusJakartaSans(
                                  color: Colors.black, fontSize: 18),
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 5.0),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(255, 255, 17, 17),
                                      )),
                                  errorStyle: TextStyle(
                                      color: Color.fromARGB(255, 255, 17, 17),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                  labelStyle: TextStyle(color: Colors.black),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Color.fromARGB(255, 255, 17, 17),
                                    size: 30,
                                  ),
                                  hintText: 'Username',
                                  hintStyle: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          new BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(25)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          new BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(25))),
                            ),
                          ),
                          SizedBox(height: 40),
                          Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(
                                controller: passwordController,
                                style: GoogleFonts.plusJakartaSans(
                                    color: Colors.black, fontSize: 18),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter";
                                  }
                                },
                                obscureText: _passwordVisible ? false : true,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 5.0),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 255, 17, 17),
                                        )),
                                    errorStyle: TextStyle(
                                        color: Color.fromARGB(255, 255, 17, 17),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                    labelStyle:
                                        TextStyle(color: Colors.black87),
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Color.fromARGB(255, 255, 17, 17),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Color.fromARGB(255, 255, 17, 17),
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(25)))),
                          ),
                          Column(
                            children: <Widget>[
                              SizedBox(height: 60),
                              FittedBox(
                                fit: BoxFit.fill,
                                child: Row(
                                  children: [
                                    isLoading
                                        ? SpinKitCircle(
                                            color: Color.fromARGB(
                                                255, 255, 17, 17),
                                            size: 60.0,
                                          )
                                        : Container(
                                            margin: EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: MaterialButton(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 150),
                                                height: 45,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Text('LOGIN',
                                                    style: GoogleFonts
                                                        .plusJakartaSans(
                                                            color: Colors.white,
                                                            fontSize: 18)),
                                                color: Color.fromARGB(
                                                    255, 255, 17, 17),
                                                onPressed: _updateInfo
                                                                ?.updateAvailability ==
                                                            UpdateAvailability
                                                                .updateAvailable &&
                                                        update == false
                                                    ? () {
                                                        print(
                                                            "update : ${update}");

                                                        InAppUpdate
                                                                .startFlexibleUpdate()
                                                            .then((_) {
                                                          setState(() {
                                                            _flexibleUpdateAvailable =
                                                                true;
                                                            update = true;
                                                          });
                                                        }).catchError((e) {
                                                          showSnack(
                                                              e.toString());
                                                        });
                                                      }
                                                    : () async {
                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          SharedPreferences
                                                              pref =
                                                              await SharedPreferences
                                                                  .getInstance();
                                                          print(tipeurl);

                                                          setState(() {
                                                            isLoading = true;
                                                          });
                                                          await Future.delayed(
                                                              const Duration(
                                                                  seconds: 3));
                                                          // await init();
                                                          loginPressed();

                                                          setState(() {
                                                            isLoading = false;
                                                          });
                                                          print('huhu');
                                                        }
                                                      }),
                                          ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              MaterialButton(
                                  padding: EdgeInsets.symmetric(horizontal: 50),
                                  height: 40,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text('Forgot Password?',
                                      style: GoogleFonts.plusJakartaSans(
                                          fontSize: 18,
                                          color:
                                              Color.fromARGB(255, 152, 10, 0),
                                          fontWeight: FontWeight.bold)),
                                  // color: Colors.red,
                                  onPressed: () {
                                    if (usernameController.text.isEmpty) {
                                      _displayCenterMotionUsername();
                                    } else {
                                      fetchDataCustomer(
                                          user_name: usernameController.text);
                                    }
                                  }),
                              // SizedBox(
                              //   height: 70,
                              // ),
                            ],
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Version ${versi} Copyright RALS',
                          // ini pak?
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            color: Colors.white,
                          )),
                      Icon(
                        Icons.copyright,
                        color: Colors.white,
                        size: 18,
                      ),
                      Text('${copyright}',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            color: Colors.white,
                          ))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
