part of 'import.dart';

class RamayanaMembercardAuthentication extends StatefulWidget {
  const RamayanaMembercardAuthentication({super.key});

  @override
  State<RamayanaMembercardAuthentication> createState() => _RamayanaMembercardAuthenticationState();
}

class _RamayanaMembercardAuthenticationState extends State<RamayanaMembercardAuthentication> {
  UserData userData = UserData();
  KeyboardUtils keyboardUtils = KeyboardUtils();
  DeviceInfoPlugin devicePlugin = DeviceInfoPlugin();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();

  String _nativeId = 'Unknown';
  final _nativeIdPlugin = NativeId();
  late LoginCubit loginCubit;
  late PopUpWidget popUpWidget;
  bool isLoading = false;
  late SharedPreferences pref;
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final urlApi = '${tipeurl}${basePath.api_login}';

  @override
  void initState() {
    super.initState();
    loginCubit = context.read<LoginCubit>();
    popUpWidget = PopUpWidget(context);
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String udid;
    String nativeId;
    String uuid;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      nativeId = await _nativeIdPlugin.getId() ?? 'Unknown NATIVE_ID';
    } on PlatformException {
      nativeId = 'Failed to get native id.';
    }

    try {
      uuid = await _nativeIdPlugin.getUUID() ?? 'Unknown UUID';
    } on PlatformException {
      uuid = 'Failed to get uuid.';
    }

    if (!mounted) return;

    setState(() {
      _nativeId = nativeId;
    });
  }

  loginPressed() async {
    keyboardUtils.dissmissKeyboard(context);
    AndroidDeviceInfo info = await devicePlugin.androidInfo;
    if (passwordController.text.isNotEmpty) {
      final body = LoginBody(
          username: '${userData.getUsername7()}',
          password: passwordController.text,
          deviceId: "${_nativeId}${info.device}",
          versi: versi);

      loginCubit.login(loginBody: body);
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
          loginCubit.createLog(
              baseParam.logInfoLoginPage, baseParam.logInfoLoginSucc, urlApi);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => RamayanaMembercardCard()));
        }

        if (state is LoginFailure) {
          setState(() {
            isLoading = false;
          });
          if (state.message == baseParam.pleaseCheckConnection) {
            popUpWidget.showPopUpError(baseParam.pleaseCheck, state.message);
          } else {
            final username = '${userData.getUsername7()}';
            loginCubit.createLog(
                baseParam.logInfoLoginPage,
                '${baseParam.logInfoLoginFail} ${state.message} user ${username}',
                urlApi);
            popUpWidget.showPopUpError(baseParam.pleaseCheck, state.message);
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

          // popUpWidget.showPopUpError(state.message, state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DefaultBottomBarController(child: Ramayana()),
                    ),
                    (Route<dynamic> route) => false);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 23,
                color: Colors.white,
              ),
            ),
            title: Text('Company Card',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 23, 
                    color: Colors.white)),
            backgroundColor: Color.fromARGB(255, 210,14,0),
            elevation: 0,
            toolbarHeight: 80,
          ),
      
        body: Container(
          color: Color.fromARGB(255, 210,14,0),
          child: ListView(
            children: [
              Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                        ),
                        // color: Colors.blue,
                        height: 350,
                        width: 400,
                        child:  FadeInImageWidget(
                          imageUrl: 'assets/idcashpin_password_enter.png')
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                          60, 0, 50, 0),
                        // color: Colors.amber,
                        // height: 200,
                        width: 3500,
                        child: Text(
                          'Enter your login password',
                          style: GoogleFonts.plusJakartaSans(
                          fontSize: 20, 
                          color: Colors.white)
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(
                            50, 30, 50, 0),
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 10
                            ),
                            child: TextFormField(
                              controller: passwordController,
                              style: GoogleFonts.plusJakartaSans(
                              fontSize: 18, 
                              color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 50, 
                        ),
                        child: MaterialButton(
                        minWidth: 150,
                        color: Colors.white,
                        height: 45,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                         onPressed: () {
                          if (_formKey.currentState!.validate()) {
                           loginPressed();
                          }
                         },
                         child: Text(
                           'Confirm',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 20, 
                            color: Color.fromARGB(255, 210, 14, 0))
                         ),
                        )
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 200
                        ),
                        // height: 100,
                        decoration: BoxDecoration(
                          // color: Colors.white,
                        ),
                        child: Center(
                          child:  Row(
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
                          ),
                        )
                      )
                    ],
                  ),
                ]),
            ],
          ),
        ),
      ),
    );
  }
}