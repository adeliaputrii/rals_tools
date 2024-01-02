part of 'import.dart';

class RamayanaLoginOffline extends StatefulWidget {
  const RamayanaLoginOffline({super.key});

  @override
  State<RamayanaLoginOffline> createState() => _RamayanaLoginOfflineState();
}

class _RamayanaLoginOfflineState extends State<RamayanaLoginOffline> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController userIdController = TextEditingController();
  TextEditingController numberCodeController = TextEditingController();
  TextEditingController adminNumberCodeController = TextEditingController();
  bool isEmptyUserId = true;
  late AndroidDeviceInfo deviceInfo;
  DeviceInfoPlugin devicePlugin = DeviceInfoPlugin();
  int randomNum = 0;
  bool generateNumberWidget = false;
  late PopUpWidget popUpWidget;
  UserData userData = UserData();
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  late SharedPreferences pref;
  bool _isLoading = true;
  var imei2 = '';
  SimData? _simData;
  late CreateLogBody createLogBody;
  late LoginCubit loginCubit;
  final urlApi = '${tipeurl}${basePath.api_login}';
  String _nativeId = 'Unknown';
  final _nativeIdPlugin = NativeId();
  String _udid = 'Unknown';
  DbHelperLoginOffline db3 = DbHelperLoginOffline();

  @override
  void initState() {
    loginCubit = context.read<LoginCubit>();
    super.initState();
    popUpWidget = PopUpWidget(context);
    generateNumber();
    generateNumberWidget = true;
    init();
    initPlatformState();
  }

  Future<void> init() async {
    pref = await SharedPreferences.getInstance();
    deviceInfo = await devicePlugin.androidInfo;
    initSim();
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
      _udid = uuid;
    });
  }

  int generateNumber() {
    RandomNumber randomNumber = RandomNumber();
    randomNum = randomNumber.getRandomNumber(111111, 999999);
    numberCodeController.text = randomNum.toString();
    return randomNum;
  }

  Future<bool> compareGenerateCode(int numberFromAdmin) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? imei = pref.getString('serialImei');
    int idUser = int.parse(userData.getUsername7());

    // int uniqueId =
    //     idUser + (randomNum * 2) + (AsciiEncoder().convert(imei!+deviceInfo.device)[0] * 10);
    //     debugPrint('${uniqueId}');

    int uniqueId = idUser + (randomNum * 5) * 2;
    debugPrint('${uniqueId}');

    return numberFromAdmin == uniqueId;
  }

    Future<String> getUserId(int numberFromAdmin) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int idUser = int.parse(numberCodeController.text) - (randomNum * 5) * 2;

    return idUser.toString();
  }

  Future<int> compareGenerateCodeTest() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? imei = pref.getString('serialImei');
    int idUser = int.parse(userData.getUsername7());

    int uniqueId = 0460545 + (825663 * 5) * 2;
    debugPrint('${uniqueId}');

    return uniqueId;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 210, 14, 0),
        toolbarHeight: 0,
      ),
      body: ListView(
        children: [
          Stack(children: [
            Container(
              height: 300,
              color: Color.fromARGB(255, 210, 14, 0),
            ),
            Container(
              // margin: EdgeInsets.only(top: 30),
              child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => RamayanaLogin()));
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.white,
                    size: 20,
                  )),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 50, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login Offline',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Sign In to continue',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              margin: EdgeInsets.only(top: 200),
              child: Container(
                  margin: EdgeInsets.only(top: 30, left: 30, right: 30),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: FadeInImageWidget(
                                imageUrl: "assets/loginOff.png")),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10, left: 10, top: 10),
                                child: Text(
                                  'Unique ID',
                                  style: GoogleFonts.plusJakartaSans(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 19),
                                ),
                              ),
                              TextFormField(
                                readOnly: true,
                                controller: numberCodeController,
                                onTap: () {
                                  setState(() {
                                    userIdController.text;
                                  });
                                },
                                style: GoogleFonts.plusJakartaSans(
                                    color: Colors.black, fontSize: 17),
                                validator: RequiredValidator(
                                    errorText: 'Please Enter'),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(IconlyLight.password),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: const Color.fromARGB(
                                              255, 255, 0, 0)),
                                      borderRadius: BorderRadius.circular(60)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 29, 37, 127)),
                                      borderRadius: BorderRadius.circular(60)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(60)),
                                  disabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(60)),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(60)),
                                ),
                              ),
                            ]),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 10, left: 10, top: 10),
                              child: Text(
                                'Login Code',
                                style: GoogleFonts.plusJakartaSans(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 19),
                              ),
                            ),
                            TextFormField(
                              readOnly: false,
                              keyboardType: TextInputType.number,
                              controller: adminNumberCodeController,
                              style: GoogleFonts.plusJakartaSans(
                                  color: Colors.black, fontSize: 17),
                              validator:
                                  RequiredValidator(errorText: 'Please Enter'),
                              decoration: InputDecoration(
                                prefixIcon: Icon(IconlyLight.password),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: const Color.fromARGB(
                                            255, 255, 0, 0)),
                                    borderRadius: BorderRadius.circular(60)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 29, 37, 127)),
                                    borderRadius: BorderRadius.circular(60)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(60)),
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(60)),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(60)),
                              ),
                            ),
                          ],
                        ),
                        generateNumberWidget
                            ? Container()
                            : Container(
                                margin: EdgeInsets.fromLTRB(10, 50, 10, 0),
                                child: MaterialButton(
                                  minWidth: 500,
                                  height: 50,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  color: Color.fromARGB(255, 210, 14, 0),
                                  onPressed: () async {
                                    debugPrint('tes generate');
                                    String? serialimei =
                                        pref.getString('serialImei');
                                    debugPrint(userData.getUsername7());
                                    debugPrint(imei2);
                                    debugPrint(serialimei);
                                    generateNumber();
                                    setState(() {
                                      numberCodeController.text;
                                      generateNumberWidget = true;
                                      debugPrint(
                                          'genrate number button ${generateNumberWidget}');
                                    });
                                    // if (formKey.currentState!.validate()) {
                                    //   UserData userData = UserData();
                                    //   if (userData.getListMenu
                                    //       .toString()
                                    //       .contains('void')) {
                                    //     debugPrint('user has access void');
                                    //     Navigator.pushAndRemoveUntil(
                                    //         context,
                                    //         MaterialPageRoute(
                                    //             builder: (context) => RamayanaVoid()),
                                    //         (Route<dynamic> route) => false);
                                    //   } else {
                                    //     debugPrint('user cannot access void');
                                    //   }
                                    // }sss
                                  },
                                  child: Text(
                                    'Generate Number',
                                    style: GoogleFonts.plusJakartaSans(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                        generateNumberWidget
                            ? Container(
                                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                                child: MaterialButton(
                                  minWidth: 500,
                                  height: 50,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  color: Color.fromARGB(255, 210, 14, 0),
                                  onPressed: () async {
                                    print(compareGenerateCodeTest());
                                    if (formKey.currentState!.validate()) {
                                      final isSuccess =
                                          await compareGenerateCode(int.parse(
                                              adminNumberCodeController.text));
                                      String? imei = pref.getString('serialImei');
                                      AndroidDeviceInfo info = await devicePlugin.androidInfo;
                                      if (
                                        "${_nativeId}${info.device}" == "${imei ?? ''}${info.device }" 
                                      //  getUserId(int.parse(adminNumberCodeController.text)) == userData.getUsername7()
                                      ) 
                                      {
                                        print(' _nativeId: $_nativeId');
                                        print('imei $imei');
                                        print('imei sama');
                                        if (isSuccess) {
                                        debugPrint(userData.getListMenu());
                                        var listmenu =
                                            '${userData.getListMenu()}';
                                        debugPrint('${listmenu}');

                                        if (listmenu
                                            .contains('mastervoid.void')) {
                                          pref.setString("waktuLoginOffline",
                                              "${formattedDate}");
                                          debugPrint('user has access void');
                                        db3.saveActivityy(LoginOffline(
                                          deskripsi: '${logSucces}',
                                          datetime: '${DateTime.now()}'
                                        ));
                                          
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RamayanaVoid(
                                                        isOffline: true)),
                                          );
                                        } else {
                                          popUpWidget.showPopUpError(
                                              pleaseCheck, userCantAccessVoid);
                                          debugPrint('user cannot access void');
                                          adminNumberCodeController.clear();
                                          db3.saveActivityy(LoginOffline(
                                          deskripsi: '${logCantAccessVoid}-${userCantAccessVoid}',
                                          datetime: '${DateTime.now()}'
                                        ));
                                        //   db3.saveActivityLoginOffline(LoginOfflineVoid(
                                        //   descLogin: '${logCantAccessVoid}-${userCantAccessVoid}',
                                        //   dateLogin: '${DateTime.now()}'
                                        // ));
                                        }
                                      } else {
                                      
                                        //Action jika nomor yang dikasih admin gagal diberikan, popup harap coba lagi
                                        popUpWidget.showPopUpError(
                                            pleaseCheck, uniqeNumberAdmin);
                                        adminNumberCodeController.clear();
                                        db3.saveActivityy(LoginOffline(
                                          deskripsi: '${logCantAccessVoid}-${uniqeNumberAdmin}',
                                          datetime: '${DateTime.now()}'
                                        ));
                                        //  db3.saveActivityLoginOffline(LoginOfflineVoid(
                                        //   descLogin: '${logCantAccessVoid}-${uniqeNumberAdmin}',
                                        //   dateLogin: '${DateTime.now()}'
                                        // ));
                                      }
                                      }
                                      else {
                                        print('imei beda');
                                        popUpWidget.showPopUpError(pleaseCheck, differentDevice);
                                        db3.saveActivityy(LoginOffline(
                                          deskripsi: '${logCantAccessVoid}-${differentDevice}',
                                          datetime: '${DateTime.now()}'
                                        ));
                                      //   db3.saveActivityLoginOffline(LoginOfflineVoid(
                                      //     descLogin: '${logCantAccessVoid}-${differentDevice}',
                                      //     dateLogin: '${DateTime.now()}'
                                      //   ));
                                      }
                                    }
                                  },
                                  child: Text(
                                    isEmptyUserId
                                        ? 'Login'
                                        : 'Tampil Random Number',
                                    style: GoogleFonts.plusJakartaSans(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              )
                            : Container(),
                        Container(
                            margin: EdgeInsets.fromLTRB(20, 50, 20, 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Version ${versi} Copyright RALS',
                                    // ini pak?
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 18,
                                      color: Colors.black,
                                    )),
                                Icon(
                                  Icons.copyright,
                                  color: Colors.black,
                                  size: 18,
                                ),
                                Text('${copyright}',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ))
                              ],
                            ))
                      ],
                    ),
                  )),
            ),
          ]),
        ],
      ),
    );
  }
}
