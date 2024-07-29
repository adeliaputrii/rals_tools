part of 'import.dart';

class RamayanaTukarPoin extends StatefulWidget {
  static const routeName = '/RamayanaVoid';
  const RamayanaTukarPoin({super.key});

  @override
  State<RamayanaTukarPoin> createState() => _RamayanaTukarPoinState();
}

class _RamayanaTukarPoinState extends State<RamayanaTukarPoin> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController myController = TextEditingController();
  DbHelper db = DbHelper();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  late PopUpWidget popUpWidget;
  late LoginCubit loginCubit;
  late IDCashCubit cubit;
  final urlApi = '${tipeurl}${basePath.api_login}';

  bool isLoading = false;
  bool _flip = false;
  bool container = true;
  var dio = Dio();
  UserData userData = UserData();
  bool _isKeptOn = true;
  double _brightness = 1.0;
  bool _barcode = true;
  Color _containerColorSj = Color.fromARGB(255, 210, 14, 0);
  Color _containerColorLacak = Color.fromARGB(255, 201, 201, 201);


  String _scanBarcode = '';
  bool _visible = false;

  List length = [];
  List ganjil = [];
  List genap = [];
  String data = '';

  String? token = '';

  String hasilAkhir = '';
  bool? _isConnected;
  String poin = '-';

  @override
  void didPush() {
    ScreenBrightness().setScreenBrightness(1.0);
  }


  @override
  void initState() {
    super.initState();
    popUpWidget = PopUpWidget(context);
    loginCubit = context.read<LoginCubit>();
    cubit = context.read<IDCashCubit>();
    tokenHeader();
  }

  @override
  void dispose() {
    try {
      myController.dispose();
    } catch (e) {}
    super.dispose();
  }


  _checkInternetConnection() async {
    try {
      final response = await InternetAddress.lookup('www.kindacode.com');
      if (response.isNotEmpty) {
        setState(() {
          _isConnected = true;
          print(_isConnected);
        });
      }
    } on Exception catch (err) {
      setState(() {
        _isConnected = false;
        print(_isConnected);
      });
      if (kDebugMode) {
        print(err);
      }
    }
    print(_isConnected);
  }

  tokenHeader() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    token = await SharedPref.getToken();
    final body = DataMemberCardBody(idUser: '${userData.getUsername7()}');
    cubit.getDataMember(token!, body);
  }

  Future<String> step1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserData userData = UserData();
    await userData.getPref();
    var member = await SharedPref.getMember();
    String userId = '${member}';
    String? randomAngka = myController.text;
    List noMember = userId.split('');
    int current = 1;
    for (int i = 0; i < noMember.length; i++) {
      current = i + 1;
      if (current.isEven) {
        genap.add(noMember[i]);
      } else if (current.isOdd) {
        ganjil.add(noMember[i]);
      }
    }
    var sum = 0;
    ganjil.forEach((val) {
      sum += int.parse(val);
    });
    var sum2 = 0;
    genap.forEach((val2) {
      sum2 += int.parse(val2);
    });
    var perhitunganGanjil = (sum + 5) * int.parse(myController.text.substring(0, 4));
    var perhitunganGenap = (sum2 - 5) * int.parse(myController.text.substring(0, 4));
  
    if (perhitunganGanjil < 0) {
      perhitunganGanjil = perhitunganGanjil * -1;
    }

    if (perhitunganGenap < 0) {
      perhitunganGenap = perhitunganGenap * -1;
    }
    var hasilGanjil = perhitunganGanjil.toString();
    var hasilGenap = perhitunganGenap.toString();
    hasilAkhir = hasilGanjil + hasilGenap;
    return hasilAkhir;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: RelativeBuilder(builder: (context, height, width, sy, sx) {
        return BlocListener<IDCashCubit, IDCashState>(
        listener: (context, state) {
          if (state is IDCashSuccess) {
            setState(() {
              poin = state.response.data?.first.poin.toString() ?? "0";
            });
          }
          if (state is IDCashFailure) {
           poin = '-';
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () async {
                await FlutterWindowManager.clearFlags(
                FlutterWindowManager.FLAG_SECURE);
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
                size: 20,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            title: Text('Tukar Poin',
              style: GoogleFonts.plusJakartaSans(
              fontSize: 23, color: Colors.white)),
            backgroundColor: Color.fromARGB(255, 210, 14, 0),
            toolbarHeight: 70,
            ),
          
            body: ListView(
              children: [
                Stack(children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    color: Color.fromARGB(255, 253, 249, 249)
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 40, left: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ramayana Poin',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Image.asset('assets/dollar_coin.png'),
                                Text('Saldo : ${poin ?? "-"} Poin',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 16,
                                  color: Colors.black
                                ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Center(
                          child: FadeInImageWidget(imageUrl: 'assets/tp.png',)
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: container
                        ? Column(children: [
                            Center(
                              child: Text(
                                'Masukkan Kode Verifikasi',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 23,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                              ),
                            Center(
                              child: Text(
                                'Masukkan 4 digit kode pada mesin kassa',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 17, color: Colors.black),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 25),
                              child: PinCodeFields(
                                controller: myController,
                                length: 4,
                                fieldBorderStyle: FieldBorderStyle.square,
                                responsive: false,
                                fieldHeight: 60.0,
                                fieldWidth: 60.0,
                                borderWidth: 1.0,
                                animation: Animations.fade,
                                activeBorderColor: Color.fromARGB(255, 255, 213, 213),
                                activeBackgroundColor: Color.fromARGB(255, 255, 213, 213),
                                borderRadius: BorderRadius.circular(20.0), 
                                keyboardType: TextInputType.number,
                                autoHideKeyboard: false,
                                fieldBackgroundColor: Colors.black12,
                                borderColor: Colors.black12,
                                textStyle: GoogleFonts.plusJakartaSans(
                                  fontSize: 30, color: Colors.black),
                                onComplete: (output) {},
                                ),
                              ),
                              Container(
                                margin:
                                EdgeInsets.only(left: 40, right: 40, top: 40),
                                height: 50,
                                width: 10000,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 210, 14, 0),
                                  borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: MaterialButton(
                                    onPressed: () async {
                                    if (myController.text == '') {
                                      popUpWidget.showPopUpError(baseParam.pleaseCheck, baseParam.logCantEmpty);
                                    } else {
                                      didPush();
                                      data = await step1();
                                      length.clear;
                                      ganjil.clear();
                                      genap.clear();
                                      setState(() {
                                        isLoading = true;
                                        container = false;
                                        _visible = true;
                                      });
                                      await Future.delayed(
                                      const Duration(seconds: 3));
                                      if (_visible == true) {
                                        await FlutterWindowManager.addFlags(
                                          FlutterWindowManager.FLAG_SECURE);
                                        } else {
                                          await FlutterWindowManager.clearFlags(
                                            FlutterWindowManager.FLAG_SECURE);
                                        }
                                        setState(() {
                                          isLoading = false;
                                        });
                                        await _checkInternetConnection();
                                        if (_isConnected == true) {
                                          AndroidDeviceInfo info =
                                            await deviceInfo.androidInfo;
                                          } else if (_isConnected == false) {
                                            String format = DateFormat.Hms().format(DateTime.now());
                                            db.saveActivityy(LogOffline(
                                              deskripsi: 'Aktivitas Tukar Poin - Menu Tukar Poin ',
                                              datetime: '${DateTime.now()}',
                                            ));
                                          }
                                          }
                                        },
                                    child: Text('Kirim',
                                      style: GoogleFonts.plusJakartaSans(
                                         fontSize: 18, 
                                         color: Colors.white),
                                      ),
                                     ),
                                  ),
                              ])
                        : Container(
                            margin: EdgeInsets.only(left: 30, right: 30, top: 0),
                            child: isLoading
                              ? Container(
                                margin: EdgeInsets.only(top: 100),
                                child: SpinKitThreeBounce(
                                  color: Color.fromARGB(255, 210, 14, 0),
                                    size: 50.0,
                                  ),
                                )
                              : AnimatedOpacity(
                                opacity: _visible ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 500),
                                child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Barcode Member',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text('Tunjukkan barcode untuk scan di kasir',
                                    style: GoogleFonts.plusJakartaSans(
                                     fontSize: 17, color: Colors.black),
                                   ),
                                  Container(
                                    margin: EdgeInsets.only(top: 30),
                                    decoration: BoxDecoration(
                                      borderRadius:BorderRadius.circular(35),
                                      color: Color.fromARGB(255, 214, 210, 210),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 45,
                                          width: 195,
                                          decoration: BoxDecoration(
                                            borderRadius:BorderRadius.circular(30)),
                                            child: MaterialButton(
                                              elevation: 0.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:BorderRadius.circular(30)),
                                                minWidth: 225,
                                                height: 50,
                                                color: _barcode
                                                ? Color.fromARGB(255, 210, 14, 0)
                                                : Color.fromARGB(255, 214, 210, 210),
                                                onPressed: () {
                                                  setState(() {
                                                    _barcode = true;
                                                  });
                                                },
                                                child: Text("Barcode",
                                                  style: GoogleFonts.plusJakartaSans(
                                                    color: _barcode
                                                    ? Colors.white
                                                    : Colors.black,
                                                    fontSize: 18,
                                                )),
                                              ),
                                            ),
                                        Container(
                                          height: 45,
                                          width: 195,
                                          decoration: BoxDecoration(
                                            color: _containerColorLacak,
                                            borderRadius:BorderRadius.circular(30)),
                                            child: MaterialButton(
                                              elevation: 0.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30)),
                                                minWidth: 225,
                                                height: 50,
                                                color: _barcode
                                                ? Color.fromARGB(255, 214, 210, 210)
                                                : Color.fromARGB( 255, 210, 14, 0),
                                                onPressed: () {
                                                  setState(() {
                                                    _barcode = false;
                                                    length.clear();
                                                    ganjil.clear();
                                                    genap.clear();
                                                  });
                                                },
                                                child: Text("QR Code",
                                                  style: GoogleFonts.plusJakartaSans(
                                                    color: _barcode
                                                    ? Colors.black
                                                    : Colors.white,
                                                    fontSize: 18,
                                                  )),
                                                ),
                                                )
                                              ],
                                            ),
                                          ),
                                  Container(
                                    child: _barcode
                                    ? Column(
                                    children: [
                                      Container(
                                      margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
                                      height: 110,
                                      child:SfBarcodeGenerator(
                                        value: '$data', 
                                        backgroundColor: Colors.white, 
                                        barColor: Colors.black, 
                                          symbology: Code128()),
                                        ),
                                      Center(
                                        child: Text('${hasilAkhir}',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 18,
                                          color: Colors.black)),
                                      )
                                    ],)
                                    : Column(
                                      children: [
                                        Container(
                                          margin:EdgeInsets.fromLTRB(100, 20, 100,0),
                                          child: PrettyQr(
                                          image: AssetImage('assets/ramayana(C).png'),
                                            size: 200,
                                            data: '$data',
                                            errorCorrectLevel:QrErrorCorrectLevel.M,
                                            typeNumber: 7,
                                            roundEdges: false,
                                          ),
                                        ),
                                        SizedBox(
                                           height: 10,
                                        ),
                                        Text('${hasilAkhir}',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 18,
                                            color: Colors.black))
                                           ],
                                       )),
                                 ]),
                     )),
                  )
                ]),
                ],
                  ),
              ],
            ),
          ),
        );
      }),
      onWillPop: () async {
        if (true) {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return DefaultBottomBarController(child: Ramayana());
          }), (route) => false);
          return true;
        }
      },
    );
  }
}
