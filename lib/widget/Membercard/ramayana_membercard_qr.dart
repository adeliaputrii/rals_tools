part of 'import.dart';

class RamayanaMembercardQr extends StatefulWidget {
  static const routeName = '/RamayanaVoid';
  const RamayanaMembercardQr({super.key});

  @override
  State<RamayanaMembercardQr> createState() => _RamayanaMembercardQrState();
}

class _RamayanaMembercardQrState extends State<RamayanaMembercardQr> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DbHelper db = DbHelper();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String _udid = 'Unknown';
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

  @override
  void didPush() {
    ScreenBrightness().setScreenBrightness(1.0);
  }

  @override
  void didPopNext() {
    ScreenBrightness().setScreenBrightness(1.0);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    try {
      myController.dispose();
    } catch (e) {} // Dispose the controller when widget is disposed
    super.dispose();
  }

  TextEditingController myController = TextEditingController();

  String _scanBarcode = '';
  bool _visible = false;

  List length = [];
  List ganjil = [];
  List genap = [];
  String data = '';
  // String nokartu = '${ApprovalIdcashCustomer.noMember[0]}';
  String hasilAkhir = '';
  bool? _isConnected;

  
  Future<String> step1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // user id
    UserData userData = UserData();
    await userData.getPref();
    var member = prefs.getString('noMember');
    String userId = '${member}';
    String? randomAngka = myController.text;
    print('grgr 123');
    print(member);
    print(userId);
    List noMember = userId.split('');
    print(noMember);
    print(noMember);
    print(noMember[0]);
    print(noMember[15]);
    int current = 1;

    for (int i = 0; i < noMember.length; i++) {
      current = i + 1;
      print(current);
      if (current.isEven) {
        genap.add(noMember[i]);
        print('valuegenap : ${noMember[i]}');
      } else if (current.isOdd) {
        ganjil.add(noMember[i]);
        print('valueganjil : ${noMember[i]}');
      }
    }

    print('ganjil : $ganjil');
    print('genap : $genap');

    var sum = 0;
    ganjil.forEach((val) {
      sum += int.parse(val);
    });
    print('jumlah ganjil $sum');

    var sum2 = 0;
    genap.forEach((val2) {
      sum2 += int.parse(val2);
    });
    print('jumlah genap $sum2');

    var perhitunganGanjil = (sum + 5) * int.parse(myController.text);
    var perhitunganGenap = (sum2 - 5) * int.parse(myController.text);
    // var perhitunganGenap = -32;

    if (perhitunganGanjil < 0) {
      perhitunganGanjil = perhitunganGanjil * -1;
    }

    if (perhitunganGenap < 0) {
      perhitunganGenap = perhitunganGenap * -1;
    }

    print('Plus 5 Ganjil $perhitunganGanjil');
    print('Minus 5 Genap $perhitunganGenap');

    var hasilGanjil = perhitunganGanjil.toString();
    var hasilGenap = perhitunganGenap.toString();

    hasilAkhir = hasilGanjil + hasilGenap;
    print(hasilAkhir);
    return hasilAkhir;
  }

  Future<void> popup() async {
    AlertDialog popup1 = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      // shadowColor: Colors.black,
      titlePadding: EdgeInsets.all(0),
      title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          height: 170,
          width: 2000,
          child: Image.asset(
            'assets/omaigat.png',
          )),
      content: Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 30,
        child: Center(
          child: Text(
            'Masukkan 4 digit kode pada mesin kassa',
            style:
                GoogleFonts.plusJakartaSans(fontSize: 17, color: Colors.black),
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.start,
      actionsPadding: EdgeInsets.only(bottom: 20),
    );
    showCupertinoModalPopup(context: context, builder: (context) => popup1);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: RelativeBuilder(builder: (context, height, width, sy, sx) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () async {
                await FlutterWindowManager.clearFlags(
                    FlutterWindowManager.FLAG_SECURE);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          RamayanaMembercardTrr()
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
            title: Text('Company Card',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 23, color: Colors.white)),
            backgroundColor: Color.fromARGB(255, 210, 14, 0),
            // elevation: 7.20,
            toolbarHeight: 70,
          ),
          body: ListView(
            children: [
              Stack(children: <Widget>[
                Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    color: Color.fromARGB(255, 253, 249, 249)),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 300,
                  // color: Colors.green,
                  child: Center(
                    child: Image.asset(
                      'assets/tp_tukarpoin.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 280),
                  child: container
                      ? Column(children: [
                          Center(
                            child: Text(
                              'Masukkan Kode POS',
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
                              'Masukkan 6 digit kode pada mesin kassa',
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 17, color: Colors.grey),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 25, left: 10, right: 10),
                            child: PinCodeFields(
                              controller: myController,
                              length: 6,
                              fieldBorderStyle: FieldBorderStyle.square,
                              responsive: false,
                              fieldHeight: 40.0,
                              fieldWidth: 40.0,
                              borderWidth: 1.0,
                              activeBorderColor:
                                  Color.fromARGB(255, 255, 213, 213),
                              activeBackgroundColor:
                                  Color.fromARGB(255, 255, 213, 213),
                              borderRadius: BorderRadius.circular(5.0),
                              keyboardType: TextInputType.number,
                              autoHideKeyboard: false,
                              fieldBackgroundColor: Colors.black12,
                              borderColor: Colors.black12,
                              textStyle: GoogleFonts.plusJakartaSans(
                                  fontSize: 25, color: Colors.black),
                              onComplete: (output) {
                                // Your logic with pin code
                                print(output);
                              },
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(left: 30, right: 30, top: 40),
                            height: 50,
                            width: 10000,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 210, 14, 0),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: MaterialButton(
                              onPressed: () async {
                                if (myController.text == '') {
                                  popup();
                                } else {
                                  didPush();
                                  didPopNext();
                                 
                                  length.clear;
                                  ganjil.clear();
                                  genap.clear();

                                  data = await step1();

                                  setState(() {
                                    isLoading = true;
                                    container = false;
                                    _visible = true;
                                  });
                                  await Future.delayed(
                                      const Duration(seconds: 3));

                                  print(_visible);
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
                                }
                              },
                              child: Text(
                                'Send',
                                style: GoogleFonts.plusJakartaSans(
                                    fontSize: 18, color: Colors.white),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Barcode Payment',
                                          style: GoogleFonts.plusJakartaSans(
                                              fontSize: 23,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'Tunjukkan barcode untuk scan di kasir',
                                          style: GoogleFonts.plusJakartaSans(
                                              fontSize: 17, color: Colors.grey),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 30),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(35),
                                            color: Color.fromARGB(
                                                255, 214, 210, 210),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 45,
                                                width: 195,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child: MaterialButton(
                                                  elevation: 0.0,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  minWidth: 225,
                                                  height: 50,
                                                  color: _barcode
                                                      ? Color.fromARGB(
                                                          255, 210, 14, 0)
                                                      : Color.fromARGB(
                                                          255, 214, 210, 210),
                                                  onPressed: () {
                                                    setState(() {
                                                      _barcode = true;
                                                    });
                                                  },
                                                  child: Text("Barcode",
                                                      style: GoogleFonts
                                                          .plusJakartaSans(
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child: MaterialButton(
                                                  elevation: 0.0,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  minWidth: 225,
                                                  height: 50,
                                                  color: _barcode
                                                      ? Color.fromARGB(
                                                          255, 214, 210, 210)
                                                      : Color.fromARGB(
                                                          255, 210, 14, 0),
                                                  onPressed: () {
                                                    setState(() {
                                                      _barcode = false;
                                                      length.clear();
                                                      ganjil.clear();
                                                      genap.clear();
                                                    });
                                                  },
                                                  child: Text("QR Code",
                                                      style: GoogleFonts
                                                          .plusJakartaSans(
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
                                                        height: 100,
                                                          margin:
                                                              EdgeInsets.fromLTRB(10, 40, 10, 0),
                                                          child: Center(
                                                              child:SfBarcodeGenerator(
                                                                  value:
                                                                      '123456',
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  barColor:
                                                                      Colors
                                                                          .black,
                                                                  symbology:
                                                                      Code128()))),
                                                      Text('${hasilAkhir}',
                                                          style: GoogleFonts
                                                              .plusJakartaSans(
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .black))
                                                    ],
                                                  )
                                                : Column(
                                                    children: [
                                                      Container(
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                100,
                                                                40,
                                                                100,
                                                                0),
                                                        child: PrettyQr(
                                                          image: AssetImage(
                                                              'assets/ramayana(C).png'),
                                                          size: 200,
                                                          data: '$data',
                                                          errorCorrectLevel:
                                                              QrErrorCorrectLevel
                                                                  .M,
                                                          typeNumber: 7,
                                                          roundEdges: false,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text('${hasilAkhir}',
                                                          style: GoogleFonts
                                                              .plusJakartaSans(
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .black))
                                                    ],
                                                  )),
                                      ]),
                                )),
                )
              ]),
            ],
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
