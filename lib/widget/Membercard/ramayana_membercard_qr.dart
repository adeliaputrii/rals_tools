part of 'import.dart';

class RamayanaMembercardQr extends StatefulWidget {
  const RamayanaMembercardQr({
    super.key,
    required this.icon,
    required this.nokartu
    });
  final bool icon;
  final String nokartu;

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
  late PopUpWidget popUpWidget;

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
    popUpWidget = PopUpWidget(context);
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

  
 Future<String>logic() async {
  //Step 1 get device ID
  String getDeviceId = userData.getImei();
  String deviceIdStart = getDeviceId.substring(0,5);
  String deviceIdEnd = getDeviceId.substring(getDeviceId.length - 5,getDeviceId.length);
  
  // Step2 no kartu
  String noKartu = '${widget.nokartu}';
  int digitSum = 0;
  for (int i = 0; i < noKartu.length; i++) {
    digitSum += int.parse(noKartu[i]);
    }
  if (digitSum < 1) {
    digitSum = 1;
  } else {
    digitSum;
  }

  //Step 3 random number
  String randomNum = '${myController.text}';
  String randomNumStart = randomNum.substring(0,3);
  String randomNumEnd = randomNum.substring(randomNum.length - 3,randomNum.length);

  //Step 4 Perkalian
  int resultLeft = int.parse(randomNumStart) * digitSum;
  int resultRight= int.parse(randomNumEnd) * digitSum;
  String resTostr = resultLeft.toString();
  String result = resTostr + resultRight.toString();

  //Step 5 Join Result
  String joinResult = deviceIdStart + result + deviceIdEnd;

  // Print the result
  debugPrint("device id: $getDeviceId");
  debugPrint("Sum of digits: $digitSum");
  debugPrint("Random Number: $randomNum");
  debugPrint("5 digit awal device id: $deviceIdStart");
  debugPrint("5 digit akhir device id: $deviceIdEnd");
  debugPrint("3 digit awal random number: $randomNumStart");
  debugPrint("3 digit akhirrandom number: $randomNumEnd");
  debugPrint("Result left: $resultLeft");
  debugPrint("Result right: $resultRight");
  debugPrint("Result: $result");
  debugPrint("Result Join: $joinResult");
  
  return joinResult;
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
                Navigator.pop(context);
                // print(logic());
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            title: Text('Kartu Tambahan',
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
                  height: 250,
                  // color: Colors.green,
                  child: Center(
                    child: 
                    widget.icon
                    ?
                    Image.asset(
                      'assets/payment_rms.png',
                      fit: BoxFit.cover,
                    )
                    :
                    Image.asset(
                      'assets/payment_trr.png',
                      fit: BoxFit.cover,
                    )
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
                              color:
                              widget.icon
                              ?
                               Color.fromARGB(255, 210, 14, 0)
                               :
                               Color.fromARGB(255, 240, 133, 179),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: MaterialButton(
                              onPressed: () async {
                                if (myController.text == '') {
                                  popUpWidget.showPopUpError(baseParam.pleaseCheck, baseParam.cantempty);
                                } else {
                                  didPush();
                                  didPopNext();
                                 
                                  length.clear;
                                  ganjil.clear();
                                  genap.clear();

                                  data = await logic();
                                  // print(step1);

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
                                  Future.delayed(Duration(minutes: 1), () {
                                  if (mounted) {
                                    setState(() {
                                      Navigator.pop(context);
                                    });
                                  }
                                });
                                }
                              },
                              child: Text(
                                'Kirim',
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
                                    color: 
                                    widget.icon
                                    ?
                                    Color.fromARGB(255, 210, 14, 0)
                                    :
                                    Color.fromARGB(255,82,74,156),
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
                                          'Barcode Pembayaran',
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
                                            color: 
                                            widget.icon
                                            ?
                                            Color.fromARGB(
                                                255,190,215,44)
                                            :
                                            Color.fromARGB(
                                                255, 240, 133, 179),
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
                                                  color: 
                                                  widget.icon
                                                  ?
                                                  _barcode
                                                      ? Color.fromARGB(
                                                          255,197,18,19)
                                                      : Color.fromARGB(
                                                          255,190,215,44)
                                                  :
                                                  _barcode
                                                      ? Color.fromARGB(
                                                          255,82,74,156)
                                                      : Color.fromARGB(
                                                          255, 240, 133, 179),
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
                                                  color: 
                                                  widget.icon
                                                  ?
                                                  _barcode
                                                      ? Color.fromARGB(
                                                          255,190,215,44)
                                                      : Color.fromARGB(
                                                          255,197,18,19)
                                                  :
                                                    _barcode
                                                      ? Color.fromARGB(
                                                          255, 240, 133, 179)
                                                      : Color.fromARGB(
                                                          255,82,74,156),
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
                                                        height: 120,
                                                          margin:
                                                              EdgeInsets.fromLTRB(10, 40, 10, 0),
                                                          child: Center(
                                                              child:SfBarcodeGenerator(
                                                                  value:
                                                                      '$data'
'',
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  barColor:
                                                                     Colors
                                                                          .black,
                                                                  symbology:
                                                                      Code128A()))),
                                                      
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
