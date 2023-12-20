part of 'import.dart';

class RamayanaIdcashNewPin extends StatefulWidget {
  RamayanaIdcashNewPin({super.key, required this.dataMember});
  memberResponse.Data dataMember;
  @override
  State<RamayanaIdcashNewPin> createState() => _RamayanaIdcashNewPinState();
}

class _RamayanaIdcashNewPinState extends State<RamayanaIdcashNewPin> {
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  UserData userData = UserData();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String _udid = 'Unknown';
  bool _passwordControllerVisible = false;
  Dio dio = Dio();
  bool isLoading = false;
  late LoginCubit loginCubit;
  KeyboardUtils keyboardUtils = KeyboardUtils();

  @override
  void initState() {
    super.initState();
    loginCubit = context.read<LoginCubit>();
    initPlatformState();
    _passwordControllerVisible = false;
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

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  loginPressed() async {
    print(versi);
    print('daaaaaaamn 23111');
    print(tipeurl);
    keyboardUtils.dissmissKeyboard(context);
    // // try {
    if (passwordController.text.isNotEmpty) {
      UserData userData = UserData();
      SharedPreferences pref = await SharedPreferences.getInstance();
      AndroidDeviceInfo info = await deviceInfo.androidInfo;
      var username = userData.getUsername7();
      final phoneSerialNum = pref.getString('serialImei');
      final body = LoginBody(
          userName: "${username}",
          password: passwordController.text,
          deviceId: "${info.brand}${info.device}${info.id}",
          version: versi
          );
      print(username);
      loginCubit.login(loginBody: body);
      //     http.Response response =
      //         //  await AuthServices.login(username.text, pass.text);
      //         await AuthServicesLog.login(
      //       //' ini versi yang sama kaya diataskan ya del?
      //       '${username}',
      //       passwordController.text,
      //       'RALS-TOOLS',
      //       '${versi}',
      //       '${DateTime.now()}',
      //       'Login Aplikasi RALS',
      //       '${imei}',
      //       '${userData.getUsername7()}',
      //       'toko',
      //       'xiaomi',
      //       '${_udid}',
      //       // '${imei}${info.device}',
      //     );
      //     Map responseMap = jsonDecode(response.body);
      //     print(responseMap);
      //     if (responseMap['userpass'] == "0") {
      //       await userData.setUser(data: responseMap);
      //       var formData = FormData.fromMap({
      //         'progname': 'RALS_TOOLS ',
      //         'versi': '${versi}',
      //         'date_run': '${DateTime.now()}',
      //         'info1': 'Enter PIN ID CASH',
      //         ' info2': '${_udid} ',
      //         'userid': '${userData.getUsernameID()}',
      //         ' toko': '${userData.getUserToko()}',
      //         ' devicename': '${info.device}',
      //         'TOKEN': 'R4M4Y4N4'
      //       });

      //       var response = await dio.post('${tipeurl}v1/activity/createmylog',
      //           data: formData);
      //       print('berhasil $_udid');

      //       Navigator.pushAndRemoveUntil(
      //           context,
      //           MaterialPageRoute(builder: (context) => RamayanaBarcode()),
      //           (Route<dynamic> route) => false);
      //     } else if (responseMap['status'] == 201) {
      //       snackBar('PIN SALAH');
      //     }
      //   }
      // } on Exception {
      //   return snackBar('PIN TIDAK SESUAI');
      //   //ini buka nya dimana ya del
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            setState(() {
              isLoading = true;
            });
          }
          if (state is LoginSuccess) {
            setState(() {
              isLoading = false;
            });
            final response = state.response;
            if (response.userpass == "0") {
              userData.setUser(data: response.toJson());
              snackBar("Success!!!");
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RamayanaBarcode(dataMember: widget.dataMember),
                  ),
                  (Route<dynamic> route) => false);
            }
          }
          if (state is LoginFailure) {
            setState(() {
              isLoading = false;
            });
            snackBar('PIN SALAH');
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  color: Colors.white,
                ),
                Container(
                  height: 500,
                  color: Color.fromARGB(255, 210, 14, 0),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, top: 50, right: 20),
                  // color: Colors.green,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) {
                            return RamayanaIDCash();
                          }), (route) => false);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      Text('ID CASH',
                          style: GoogleFonts.plusJakartaSans(
                              textStyle: TextStyle(
                                  fontSize: 23,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500))),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_back,
                          color: Color.fromARGB(255, 210, 14, 0),
                          size: 30,
                        ),
                      )
                    ],
                  ),
                ),
                ClipPath(
                  clipper: BottomClipperIdCash(),
                  child: Container(
                    margin: EdgeInsets.only(left: 20, top: 50, right: 20),
                    // color: Colors.green,
                    height: 320,
                    child: Center(
                        child: Image.asset(
                      'assets/idcashpin_password_enter.png',
                    )),
                  ),
                ),
                Container(
                  // color: Colors.amber,
                  // height: 600,
                  margin: EdgeInsets.only(
                      left: 20, top: 350, right: 20, bottom: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 192, 192, 192),
                                blurRadius: 10,
                                offset: Offset(4, 8),
                              )
                            ]),

                        // margin: EdgeInsets.only(left: 20, top: 350, right: 20),
                        height: 400,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Masukkan Password",
                                  style: GoogleFonts.plusJakartaSans(
                                      textStyle: TextStyle(
                                          fontSize: 23,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500))),
                              Form(
                                key: _formKey,
                                child: Container(
                                  margin: EdgeInsets.only(left: 30, right: 30),
                                  child: TextFormField(
                                    style: GoogleFonts.plusJakartaSans(
                                        textStyle: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    )),
                                    controller: passwordController,
                                    obscureText: _passwordControllerVisible
                                        ? false
                                        : true,
                                    validator: RequiredValidator(
                                        errorText: 'Enter Password'),
                                    decoration: InputDecoration(
                                        labelText: 'Enter Password',
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 5.0),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 255, 17, 17),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        errorStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 17, 17),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                        labelStyle:
                                            TextStyle(color: Colors.black87),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            // Based on passwordControllerVisible state choose the icon
                                            _passwordControllerVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Color.fromARGB(
                                                255, 255, 17, 17),
                                          ),
                                          onPressed: () {
                                            // Update the state i.e. toogle the state of passwordControllerVisible variable
                                            setState(() {
                                              _passwordControllerVisible =
                                                  !_passwordControllerVisible;
                                            });
                                          },
                                        ),
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color:
                                              Color.fromARGB(255, 255, 17, 17),
                                        ),
                                        hintStyle: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: new BorderSide(
                                              color: Colors.black),
                                        )),
                                  ),
                                ),
                              ),
                              isLoading
                                  ? SpinKitCircle(
                                      color: Color.fromARGB(255, 255, 17, 17),
                                      size: 60.0,
                                    )
                                  : MaterialButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          await loginPressed();
                                          // setState(() {
                                          //   isLoading = true;
                                          // });
                                          // await Future.delayed(
                                          //     const Duration(seconds: 3));
                                          // await loginPressed();
                                          // setState(() {
                                          //   isLoading = false;
                                          // });
                                        }
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      color: Color.fromARGB(255, 255, 17, 17),
                                      height: 50,
                                      minWidth: 200,
                                      child: Text('Submit',
                                          style: GoogleFonts.plusJakartaSans(
                                              textStyle: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ))),
                                    )
                            ]),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 15,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Copyright RALS',
                                style: GoogleFonts.plusJakartaSans(
                                    textStyle: TextStyle(
                                        fontSize: 18, color: Colors.black))),
                            Icon(
                              Icons.copyright,
                              color: Colors.black,
                              size: 21,
                            ),
                            Text('${copyright}',
                                style: GoogleFonts.plusJakartaSans(
                                    textStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500)))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class BottomClipperIdCash extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 200);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - size.width / 4, size.height, size.width,
        size.height - 100);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
