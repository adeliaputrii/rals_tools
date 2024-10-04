part of 'import.dart';

class RamayanaMembercardQr extends StatefulWidget {
  const RamayanaMembercardQr({super.key, required this.icon, required this.nokartu});
  final String icon;
  final String nokartu;

  @override
  State<RamayanaMembercardQr> createState() => _RamayanaMembercardQrState();
}

class _RamayanaMembercardQrState extends State<RamayanaMembercardQr> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DbHelper db = DbHelper();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  bool isLoading = false;
  bool _flip = false;
  bool container = true;
  var dio = Dio();
  UserData userData = UserData();
  bool _isKeptOn = true;
  double _brightness = 1.0;
  bool _barcode = true;
  Color _containerColorSj = baseColor.primaryColor;
  Color _containerColorLacak = Color.fromARGB(255, 201, 201, 201);
  late PopUpWidget popUpWidget;
  late LoginCubit loginCubit;
  final urlApi = '${tipeurl}${basePath.api_get_company_card_detail}';

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
    loginCubit = context.read<LoginCubit>();
  }

  @override
  void dispose() {
    try {
      myController.dispose();
    } catch (e) {} 
    super.dispose();
  }

  TextEditingController myController = TextEditingController();

  String _scanBarcode = '';
  bool _visible = false;
  String data = '';
  bool? _isConnected;

  Future<String> logic() async {
    //Step 1 get device ID
    String getDeviceId = userData.getImei();
    String deviceIdStart = getDeviceId.substring(0, 5);
    String deviceIdEnd = getDeviceId.substring(getDeviceId.length - 5, getDeviceId.length);
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
    String randomNumStart = randomNum.substring(0, 3);
    String randomNumEnd = randomNum.substring(randomNum.length - 3, randomNum.length);
    //Step 4 Perkalian
    int resultLeft = int.parse(randomNumStart) * digitSum;
    int resultRight = int.parse(randomNumEnd) * digitSum;
    String resTostr = resultLeft.toString();
    String result = resTostr + resultRight.toString();
    //Step 5 Join Result
    String joinResult = deviceIdStart + result + deviceIdEnd;
    return joinResult;
  }

  _onBackPressed() async {
    await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return RamayanaMembercardAuthentication();
    }), (route) => false);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () async {
              _onBackPressed();
              print(userData.getImei());
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: Text(baseParam.companyCardTitle, style: GoogleFonts.plusJakartaSans(fontSize: 23, color: Colors.white)),
          backgroundColor: baseColor.primaryColor,
          // elevation: 7.20,
          toolbarHeight: 70,
        ),
        body: WillPopScope(
          onWillPop: () {
            return _onBackPressed();
          },
          child: ListView(
            children: [
              Stack(children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0), 
                  color: Color.fromARGB(255, 253, 249, 249)
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: getImageForType(widget.icon)),
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
                        style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Colors.grey),
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
                        activeBorderColor: Color.fromARGB(255, 255, 213, 213),
                        activeBackgroundColor: Color.fromARGB(255, 255, 213, 213),
                        borderRadius: BorderRadius.circular(5.0),
                        keyboardType: TextInputType.number,
                        autoHideKeyboard: false,
                        fieldBackgroundColor: Colors.black12,
                        borderColor: Colors.black12,
                        textStyle: GoogleFonts.plusJakartaSans(fontSize: 25, color: Colors.black),
                        onComplete: (output) {
                          print(output);
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30, top: 40),
                      height: 50,
                      width: 10000,
                      decoration: BoxDecoration(
                        color: getColorForTypePayment(widget.icon),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: MaterialButton(
                      onPressed: () async {
                        if (myController.text == '') {
                          popUpWidget.showPopUpError(baseParam.pleaseCheck, baseParam.cantempty);
                        } else {
                          didPush();
                          didPopNext();
                          data = await logic();
                          setState(() {
                            isLoading = true;
                            container = false;
                            _visible = true;
                          });
                          await Future.delayed(const Duration(seconds: 3));
                          if (_visible == true) {
                            await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
                           } else {
                            await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
                          }
                          setState(() {
                            isLoading = false;
                          });
                          Future.delayed(Duration(minutes: 1), () {
                            if (mounted) {
                              setState(() {
                                 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                                 return RamayanaMembercardAuthentication();
                                }), (route) => false);
                               });
                              }
                           });
                        }
                      },
                       child: Text( 'Kirim',
                        style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.white),
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
                        color: getColorForTypePayment(widget.icon),
                        size: 50.0,
                      ),
                    )
                    : AnimatedOpacity(
                      opacity: _visible ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 500),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, 
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
                          Text('Tunjukkan barcode untuk scan di kasir',
                            style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Colors.grey),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35), 
                              color: getColorForTypeHistory(widget.icon)
                            ),
                            child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                              height: 45,
                              width: 195,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30)
                              ),
                              child: MaterialButton(
                                elevation: 0.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)
                                ),
                                minWidth: 225,
                                height: 50,
                                color: getBarcodeColor(widget.icon),
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
                                borderRadius: BorderRadius.circular(30)
                              ),
                              child: MaterialButton(
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)
                              ),
                              minWidth: 225,
                              height: 50,
                              color: getQrColor(widget.icon),
                              onPressed: () {
                                setState(() {
                                   _barcode = false;
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
                           ],),
                          ),
                          Container(
                            child: _barcode
                            ? Column(
                            children: [
                               Container(
                               height: 120,
                               margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
                               child: Center(
                                child:
                                  BarcodeWidget(
                                  data: '$data', 
                                  barcode: Barcode.code128(), 
                                  height: 300,
                                  drawText: false,
                                )
                              ),
                            )
                          ],)
                          : Column(
                            children: [
                              Container(
                              margin: EdgeInsets.fromLTRB(100, 40, 100, 0),
                                child: PrettyQr(
                                  image: AssetImage('assets/ramayana(C).png'),
                                  size: 200,
                                  data: '$data',
                                  errorCorrectLevel: QrErrorCorrectLevel.M,
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
        ),
      );
    });
  }

  ImageProvider<Object> getImageForType(String type) {
    print('type : $type');
    switch (type) {
      case '6':
        return AssetImage('assets/payment_trr.png');
      case '7':
        return AssetImage('assets/payment_rms.png');
      case '8':
        return AssetImage('assets/payment_ifs.png');
      default:
        return AssetImage('assets/default.png'); // Gambar default jika type tidak sesuai
    }
  }

  Color getBarcodeColor(String type) {
    // untuk warna container
    switch (type) {
      case '6':
        if (_barcode) {
          return baseColor.trrColor;
        } else {
          return baseColor.trrColorPink;
        }
      case '7':
        if (_barcode) {
          return baseColor.primaryColor;
        } else {
          return baseColor.rmsColor;
        }
      case '8':
        if (_barcode) {
          return baseColor.ifsGreen;
        } else {
          return baseColor.ifsYellow;
        }
      default:
        return Colors.grey; // Warna default jika type tidak sesuai
    }
  }

  Color getQrColor(String type) {
    // untuk warna container
    switch (type) {
      case '6':
        if (_barcode) {
          return baseColor.trrColorPink;
        } else {
          return baseColor.trrColor;
        }
      case '7':
        if (_barcode) {
          return baseColor.rmsColor;
        } else {
          return baseColor.primaryColor;
        }
      case '8':
        if (_barcode) {
          return baseColor.ifsYellow;
        } else {
          return baseColor.ifsGreen;
        }
      default:
        return Colors.grey; // Warna default jika type tidak sesuai
    }
  }
}
