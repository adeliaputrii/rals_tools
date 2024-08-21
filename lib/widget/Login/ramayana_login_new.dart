part of 'import.dart';

class RamayanaLogin extends StatefulWidget {
  const RamayanaLogin({super.key});

  static const route = '/ramayana-login-screen';

  @override
  _RamayanaLogin createState() => _RamayanaLogin();
}

class _RamayanaLogin extends State<RamayanaLogin> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool update = false;
  DeviceInfoPlugin devicePlugin = DeviceInfoPlugin();
  late AndroidDeviceInfo deviceInfo;
  AppUpdateInfo? _updateInfo;
  bool _flexibleUpdateAvailable = false;
  bool isLoading = false;
  bool _passwordVisible = false;
  Timer? timer;
  bool _isLoading = true;
  final FocusNode _focusNode = FocusNode();

  late LoginCubit loginCubit;
  late PopUpWidget popUpWidget;
  late CreateLogBody createLogBody;
  late SharedPreferences pref;
  bool isloading = false;
  String? _userId;
  String _password = '';
  String _nativeId = 'Unknown';
  final urlApi = '${tipeurl}${basePath.api_login}';

  final _nativeIdPlugin = NativeId();
  UserData userData = UserData();
  GetFile getFile = GetFile();
  KeyboardUtils keyboardUtils = KeyboardUtils();
  var token = '';
  static var fcmToken;
  final _firebaseMessaging = FirebaseMessaging.instance;
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  void initState() {
    loginCubit = context.read<LoginCubit>();
    popUpWidget = PopUpWidget(context);
    init();
    super.initState();
    _passwordVisible = false;
    deleteUserData();
    _unsecureScreen();
  }

  _unsecureScreen() async {
    await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE); // Mengaktifkan kembali tangkapan layar
  }

  Future<void> init() async {
    deviceInfo = await devicePlugin.androidInfo;
    pref = await SharedPreferences.getInstance();
    checkForUpdate();
    initPlatformState();
    initNotification();
  }

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    fcmToken = "";
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

  Future<void> deleteUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('Reset Username');
    print('delete usernameController');
  }

  Future<void> initPlatformState() async {
    String nativeId;
    try {
      nativeId = await _nativeIdPlugin.getId() ?? 'Unknown NATIVE_ID';
    } on PlatformException {
      nativeId = 'Failed to get native id.';
    }
    if (!mounted) return;
    setState(() {
      _nativeId = nativeId;
      pref.setString('serialImei', nativeId);
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
      ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(SnackBar(content: Text(text)));
    }
  }

  sweatAlert() {
    var alertStyle = AlertStyle(
      titlePadding: EdgeInsets.only(bottom: 10),
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: GoogleFonts.plusJakartaSans(
        fontSize: 18,
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
      titleStyle: GoogleFonts.plusJakartaSans(fontSize: 25, color: Color.fromARGB(255, 210, 14, 0), fontWeight: FontWeight.w500),
      alertAlignment: Alignment.center,
    );
    Alert(
      style: alertStyle,
      context: context,
      image: FadeInImageWidget(imageUrl: "assets/loginOffline.png"),
      title: 'Server Offline',
      desc: "Apakah Anda ingin login dengan mode offline? Jika YA harap hubungi DTC dengan angka random di bawah.",
      buttons: [
        DialogButton(
          radius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 210, 14, 0),
          onPressed: () {
            usernameController.clear();
            passwordController.clear();
            Navigator.pop(context);
          },
          child: Text(
            "TIDAK",
            style: GoogleFonts.plusJakartaSans(fontSize: 15, color: Colors.white),
          ),
        ),
        DialogButton(
          radius: BorderRadius.circular(20),
          color: Colors.green,
          onPressed: () async {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => RamayanaLoginOffline()), (Route<dynamic> route) => false);
          },
          child: Text(
            "YA",
            style: GoogleFonts.plusJakartaSans(fontSize: 15, color: Colors.white),
          ),
        ),
      ],
    ).show();
    return;
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
        '${baseParam.pleaseCheck}',
        style: TextStyle(fontSize: 15),
      ),
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
        '${baseParam.pleaseCheck}',
        style: TextStyle(fontSize: 15),
      ),
      position: MotionToastPosition.center,
    ).show(context);
  }

  loginPressed() async {
    keyboardUtils.dissmissKeyboard(context);
    AndroidDeviceInfo info = await devicePlugin.androidInfo;
    if (usernameController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      final body = LoginBody(
        username: usernameController.text, 
        password: passwordController.text, 
        deviceId: "${_nativeId}${info.device}", 
        versi: versi
      );
      loginCubit.logout();
      SharedPref.setDeviceId('${_nativeId}${info.device}');
      loginCubit.login(loginBody: body);
    }}

  fetchDataCustomer({required String user_name}) async {
    AndroidDeviceInfo info = await devicePlugin.androidInfo;
    final responseku = await http.post(
      Uri.parse('${tipeurl}api/v1/auth/reset.username'), 
      body: {'user_name': usernameController.text});
    var data = jsonDecode(responseku.body);
    if (data['status'] == 200) {
      print(data);
      final SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("Reset Username", "${usernameController.text}");
      var formData = FormData.fromMap({
        'progname': '${app_name} ',
        'versi': '${versi}',
        'date_run': '${DateTime.now()}',
        'info1': 'Forgot Password Aplikasi RALS',
        ' info2': '${imei} ',
        'userid': '${usernameController.text}',
        ' toko': '${userData.getUserToko()}',
        ' devicename': '${info.device}',
        'TOKEN': 'R4M4Y4N4'
      });
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
      listener: (context, state) async {
        if (state is LoginLoading || state is CreateLogLoading) {
          setState(() {
            isLoading = true;
          });
        }
        if (state is LoginSuccess) {
          pref.setString('user_token_str', state.response.accessToken ?? '');
          SharedPref.setLastLogin('${formattedDate}');
          SharedPref.setUserId(state.response.data?.username7.toString() ?? 'unknown');
          SharedPref.setUserToko(state.response.data?.toko.toString() ?? 'unknown');
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Ramayana()));
        }

        if (state is LoginFailure) {
          setState(() {
            isLoading = false;
          });
          if (state.message == pleaseCheckConnection) {
            sweatAlert();
          } else {
            final username = usernameController.text;
            popUpWidget.showPopUpError(pleaseCheck, state.message);
          }
        }
        if (state is CreateLogSuccess) {
          setState(() {
            isLoading = false;
          });
        }
        if (state is CreateLogFailure) {
          setState(() {
            isLoading = false;
          });
        }
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              color: Color.fromARGB(255, 240, 238, 238),
            ),
            Container(
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
                      boxShadow: [(BoxShadow(
                        color: Color.fromARGB(255, 185, 185, 185), 
                        blurRadius: 5, 
                        offset: Offset(2, 4)
                      ))
                    ]),
                    child: Column(
                    children: <Widget>[
                      Container(
                      margin: EdgeInsets.only(top: 50),
                      height: 130,
                      child: Image.asset(
                        "assets/rama(C).png",
                        height: 180,
                        )
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 35),
                        child: Center(
                          child: Text('Selamat Datang di Rtools',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 24, 
                              color: Colors.black, 
                              fontWeight: FontWeight.w600)
                            )
                          ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child:
                              Center(child: Text('Masuk untuk melanjutkan', 
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 18, 
                                color: Colors.black)
                              )
                            ),
                          ),
                          SizedBox(
                            height: 70,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(
                              cursorColor: Colors.black,
                              controller: usernameController,
                              validator: RequiredValidator(errorText: 'Wajib diisi'),
                              keyboardType: TextInputType.multiline,
                              style: GoogleFonts.plusJakartaSans(color: Colors.black, fontSize: 18),
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 5.0),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(
                                  color: Color.fromARGB(255, 255, 17, 17),
                                )),
                                errorStyle: TextStyle(color: Color.fromARGB(255, 255, 17, 17), fontSize: 14, fontWeight: FontWeight.w400),
                                labelStyle: TextStyle(color: Colors.black),
                                prefixIcon: Icon(
                                Icons.person,
                                color: Color.fromARGB(255, 255, 17, 17),
                                  size: 30,
                                ),
                                hintText: 'Username',
                                hintStyle: TextStyle(color: Colors.black, fontSize: 20),
                                enabledBorder:UnderlineInputBorder(
                                  borderSide: new BorderSide(color: Colors.black), 
                                  borderRadius: BorderRadius.circular(25)
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: new BorderSide(color: Colors.black), 
                                  borderRadius: BorderRadius.circular(25)
                                )
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(
                              controller: passwordController,
                              style: GoogleFonts.plusJakartaSans(color: Colors.black, fontSize: 18),
                              validator: (value) {
                              if (value!.isEmpty) {
                                return "Wajib diisi";
                                }
                              },
                              obscureText: _passwordVisible ? false : true,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 5.0),
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
                                  fontWeight: FontWeight.w400
                                ),
                                labelStyle: TextStyle(color: Colors.black87),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Color.fromARGB(255, 255, 17, 17),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                  _passwordVisible 
                                  ? 
                                  Icons.visibility 
                                  : 
                                  Icons.visibility_off,
                                  color: Color.fromARGB(255, 255, 17, 17),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },),
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                    color: Colors.black), 
                                    borderRadius: BorderRadius.circular(25)),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: new BorderSide(
                                      color: Colors.black), 
                                      borderRadius: BorderRadius.circular(25)
                                  )
                                )
                              ),
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
                                      color: Color.fromARGB(255, 255, 17, 17),
                                      size: 60.0,
                                    )
                                  : Container(
                                    margin: EdgeInsets.only(left: 20, right: 20),
                                    child: MaterialButton(
                                    padding: EdgeInsets.symmetric(horizontal: 150),
                                    height: 45,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text('MASUK', 
                                    style: GoogleFonts.plusJakartaSans(
                                      color: Colors.white, 
                                      fontSize: 18)
                                    ),
                                    color: Color.fromARGB(255, 255, 17, 17),
                                    onPressed: _updateInfo?.updateAvailability == 
                                    UpdateAvailability.updateAvailable && update == false
                                    ? () {
                                    InAppUpdate.startFlexibleUpdate().then((_) {
                                      setState(() {
                                         _flexibleUpdateAvailable = true;
                                         update = true;
                                      });
                                    }).catchError((e) {
                                      showSnack(e.toString());
                                    });
                                    }
                                    : () async {
                                      if (_formKey.currentState!.validate()) {
                                        await init();
                                        loginPressed();
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
                                child: Text('Lupa Password?',
                                  style: GoogleFonts.plusJakartaSans(
                                  fontSize: 18, 
                                  color: Color.fromARGB(255, 152, 10, 0), 
                                  fontWeight: FontWeight.bold)),
                                  onPressed: () {
                                    if (usernameController.text.isEmpty) {
                                      _displayCenterMotionUsername();
                                    } else {
                                      fetchDataCustomer(user_name: usernameController.text);
                                    }
                                  }
                                ),
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
                      Text('Versi ${versi}  Hak Cipta RALS',
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
                        )
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
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
