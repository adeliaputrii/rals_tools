part of 'import.dart';

class RamayanaReset extends StatefulWidget {
  const RamayanaReset({Key? key}) : super(key: key);

  @override
  State<RamayanaReset> createState() => _RamayanaResetState();
}

class _RamayanaResetState extends State<RamayanaReset> {
  TextEditingController email = TextEditingController();
  var dio = Dio();
  bool _isLoading = false;
  String _udid = 'Unknown';
  UserData userData = UserData();
  late LoginCubit loginCubit;

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  @override
  void initState() {
    super.initState();
    loginCubit = context.read<LoginCubit>();
    initPlatformState();
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

  // void _displayCenterMotionToastSuccess() {
  //       MotionToast(
  //         toastDuration: Duration(seconds: 10),
  //         icon: IconlyBold.tickSquare,
  //         primaryColor: Color.fromARGB(255, 250, 66, 41),
  //         title: Text(
  //           message,
  //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
  //         ),
  //         width: 350,
  //         backgroundType: BackgroundType.lighter,
  //         height: 100,
  //         description: const Text(
  //           '',
  //           style: TextStyle(fontSize: 15),
  //         ),
  //         //description: "Center displayed motion toast",
  //         position: MotionToastPosition.top,
  //       ).show(context);
  //     }

  fetchDataApi({required String user_name}) async {
    AndroidDeviceInfo info = await deviceInfo.androidInfo;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var reset2 = pref.getString("Reset Username");

    void _displayCenterMotionToastEmail() {
      MotionToast(
        toastDuration: Duration(seconds: 10),
        icon: IconlyBold.tickSquare,
        primaryColor: Color.fromARGB(255, 250, 66, 41),
        title: Text(
          "Email Tidak Terdaftar",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        width: 350,
        backgroundType: BackgroundType.lighter,
        height: 100,
        description: const Text(
          '',
          style: TextStyle(fontSize: 15),
        ),
        //description: "Center displayed motion toast",
        position: MotionToastPosition.top,
      ).show(context);
    }

    try {
      final url = '${tipeurl}api/v1/auth/reset.password';
      final responseku = await http.post(Uri.parse(url),
          body: {'user_name': reset2, 'email': email.text});

      var data = jsonDecode(responseku.body);
      var message = "${data['message']}";

      void _displayCenterMotionToastSuccess() {
        MotionToast(
          toastDuration: Duration(seconds: 10),
          icon: IconlyBold.tickSquare,
          primaryColor: Color.fromARGB(255, 47, 221, 4),
          title: Text(
            message,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          width: 350,
          backgroundType: BackgroundType.lighter,
          height: 100,
          description: const Text(
            '',
            style: TextStyle(fontSize: 15),
          ),
          //description: "Center displayed motion toast",
          position: MotionToastPosition.top,
        ).show(context);
      }

      // var message = "${data['message']}";
      void _displayCenterMotionToastFailed() {
        MotionToast(
          toastDuration: Duration(seconds: 10),
          icon: IconlyBold.tickSquare,
          primaryColor: Color.fromARGB(255, 250, 66, 41),
          title: Text(
            message,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          width: 350,
          backgroundType: BackgroundType.lighter,
          height: 100,
          description: const Text(
            '',
            style: TextStyle(fontSize: 15),
          ),
          //description: "Center displayed motion toast",
          position: MotionToastPosition.top,
        ).show(context);
      }

      if (data['status'] == 200) {
        print("API Success oooo");
        print(data);
        var formData = FormData.fromMap({
          'progname': '${app_name} ',
          'versi': '${versi}',
          'date_run': '${DateTime.now()}',
          'info1': 'Forget Password Aplikasi RALS',
          ' info2': '${_udid} ',
          'userid': '${reset2}',
          ' toko': '${userData.getUserToko()}',
          ' devicename': '${info.device}',
          'TOKEN': 'R4M4Y4N4'
        });

        // var response =
        //     await dio.post('${tipeurl}v1/activity/createmylog', data: formData);
        loginCubit.createLog(
            baseParam.logInfoResetPage, baseParam.logInfoResetSucc, url);

        _displayCenterMotionToastSuccess();
        // ResetPassword.hidden.add(username.text);
      } else if (data['status'] != 200) {
        print(message);
        loginCubit.createLog(baseParam.logInfoResetPage,
            '${baseParam.logInfoResetFail} ${message}', url);
        print("ini yang salah");
        _displayCenterMotionToastFailed();
      } else {
        print("No Data");
      }
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return RamayanaLogin();
      }));
    } on Exception {
      _displayCenterMotionToastEmail();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed : () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return RamayanaLogin();
      }));
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white,)
          ),
        backgroundColor: Color.fromARGB(255, 238, 34, 34),
        title: Center(
          child: Text(
            "Lupa Password",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top: 100),
                child: CircleAvatar(
                  child: Image.asset('assets/gembok.png'),
                  backgroundColor: Color.fromARGB(157, 238, 182, 178),
                  radius: 100,
                ),
              ),
              // Container(
              //     margin: EdgeInsets.only(top: 100),
              //     child: Image.asset('assets/affah.png')),
              Container(
                margin: EdgeInsets.only(left: 60, right: 60, top: 50),
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    hintText: "Email",
                  ),
                ),
              ),
              // Container(
              //   margin: EdgeInsets.only(left: 60, right: 60, top: 50),
              //   child: TextFormField(
              //     decoration: InputDecoration(
              //       hintText: "Username",
              //     ),
              //   ),
              // ),
              Container(
                  margin: EdgeInsets.only(left: 150, right: 150, top: 20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  child: _isLoading
                      ? SpinKitFadingCircle(
                          // itemBuilder: (BuildContext context, int index) {
                          //   return DecoratedBox(
                          //     decoration: BoxDecoration(
                          //       color: index.isEven ? Colors.red : Colors.green,
                          //     ),
                          //   );
                          // },
                          color: Colors.red,
                        )
                      : MaterialButton(
                          color: Color.fromARGB(255, 241, 200, 75),
                          child: Text("Kirim"),
                          onPressed: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            await Future.delayed(const Duration(seconds: 3));

                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            var reset = pref.getString("Reset Username");
                            var formData = FormData.fromMap({
                              'user_name': reset,
                              'email': email.text,
                            });
                            var response = await dio.post(
                                '${tipeurl}api/v1/auth/reset.password',
                                data: formData);
                            print('Berhasil, ${reset}, ${email.text}');

                            setState(() {
                              _isLoading = false;
                            });

                            // pref.remove("Reset Username");
                            if (reset != null) {
                              fetchDataApi(user_name: reset);
                              print(reset);
                            }
                            // _displayCenterMotionToastSuccess();
                            Duration(seconds: 10);
                          }))
            ],
          )
        ],
      ),
    );
  }
}
