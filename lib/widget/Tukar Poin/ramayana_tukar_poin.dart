
part of'import.dart';

class RamayanaTukarPoin extends StatefulWidget {
  static const routeName = '/RamayanaVoid';
  const RamayanaTukarPoin({super.key});

  @override
  State<RamayanaTukarPoin> createState() => _RamayanaTukarPoinState();
}

class _RamayanaTukarPoinState extends State<RamayanaTukarPoin> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DbHelper db = DbHelper();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String _udid = 'Unknown';
  var dio = Dio();
  UserData userData = UserData();
  bool _isKeptOn = true;
  double _brightness = 1.0;
  bool _barcode = true;
  var imei2 = '';

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
    _loadImei();
  }

  _loadImei() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print('imei2 ${prefs.getString('serialImei')}');
    setState(() {
      imei2 = (prefs.getString('serialImei') ?? '');
      imei = imei2;
    });
    return imei2;
  }

  TextEditingController myController = TextEditingController();

  String _scanBarcode = '';
  bool _visible = false;

    List length = [];
    List ganjil = [];
    List genap = [];
    // String nokartu = '${ApprovalIdcashCustomer.noMember[0]}';
    String hasilAkhir = '';
    bool? _isConnected;

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

   Future<String>step1() async {
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
        if(current.isEven){
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

  if(perhitunganGanjil < 0) {
    perhitunganGanjil = perhitunganGanjil * -1;
  } 

  if(perhitunganGenap < 0) {
    perhitunganGenap = perhitunganGenap * -1;
  }

  print('Plus 5 Ganjil $perhitunganGanjil');
  print('Minus 5 Genap $perhitunganGenap');

  var hasilGanjil = perhitunganGanjil.toString();
  var hasilGenap = perhitunganGenap.toString();

  hasilAkhir = hasilGanjil+hasilGenap;
  print(hasilAkhir);
  return hasilAkhir;

}
  
  String data = '';
  

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: RelativeBuilder(builder: (context, height, width, sy, sx) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () async {
                await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
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
              ),
            ),
            title: Text('Tukar Poin', style: TextStyle(fontSize: 23)),
            backgroundColor: Color.fromARGB(255, 255, 17, 17),
            elevation: 7.20,
            toolbarHeight: 90,
          ),
          body: ListView(
            children: [
              Stack(children: <Widget>[
                Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    color: Color.fromARGB(255, 253, 249, 249)),
                Container(
                  width: MediaQuery.of(context).size.width / 1,
                  height: 170,
                  color: Color.fromARGB(255, 255, 17, 17),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
                  child: Text(
                    'Tukar Poin',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 23,
                        color: Colors.white),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 100, 10, 0),
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 255, 255, 255),
                      boxShadow: [BoxShadow(blurRadius: 5)]),
                ),
                SizedBox(
                  height: 30,
                  width: 30,
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(30, 130, 30, 0),
                    child: Form(
                        key: _formKey,
                        child: TextFormField(
                            controller: myController,
                            style: TextStyle(fontSize: 20, color: Colors.black),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Required";
                              }
                              if (value.length != 4) {
                                return "Password length must be 4 characters";
                              }
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 5.0),
                                    borderRadius: BorderRadius.circular(25)),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 255, 17, 17),
                                    ),
                                    borderRadius: BorderRadius.circular(25)),
                                errorStyle: TextStyle(
                                    color: Color.fromARGB(255, 255, 17, 17),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                                labelStyle: TextStyle(color: Colors.black87),
                                prefixIcon: Icon(
                                  Icons.keyboard,
                                  color: Color.fromARGB(255, 255, 17, 17),
                                  size: 30,
                                ),
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 20),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(25)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide:
                                      new BorderSide(color: Colors.black),
                                ))))),
                Container(
                  margin: EdgeInsets.fromLTRB(160, 230, 160, 0),
                  width: 150,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 17, 17),
                      borderRadius: BorderRadius.circular(30)),
                  height: 40,
                  child: TextButton(
                    child: Text(
                      'GENERATE',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                      didPush();
                      didPopNext();
                      data = await step1();
                        await _checkInternetConnection();
                                if (_isConnected == true) {
                                 
                                    print('is connect');
                                    AndroidDeviceInfo info = await deviceInfo.androidInfo;
                          var formData = FormData.fromMap({
                                'progname': 'RALS_TOOLS ',
                                'versi': '${versi}',
                                'date_run': '${DateTime.now()}',
                                'info1': 'Aktivitas Tukar Poin - Menu Tukar Poin',
                                ' info2': '${imei2} ',
                                'userid': '${userData.getUsernameID()}',
                                ' toko': '${userData.getUserToko()}',
                                ' devicename': '${info.device}',
                                'TOKEN': 'R4M4Y4N4'
                              });
                              
                               
                              var response = await dio.post(
                                  '${tipeurl}v1/activity/createmylog',
                                  data: formData);   
                                  
                                  print('berhasil $_udid');    
                                
                                } else if (_isConnected == false){
                                   String format = DateFormat.Hms().format(DateTime.now());
                                    print('not connect');
                                     db.saveActivityy(LogOffline(
                                      deskripsi: 'Aktivitas Tukar Poin - Menu Tukar Poin ',
                                      datetime: '${DateTime.now()}',
                                      
      ));
                                
                                }
                        length.clear;
                        ganjil.clear();
                        genap.clear();
                        
                        
                        setState(() {
                          _visible = true;
                        });
                        print(_visible);
                                  if (_visible == true) {
                                    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
                                  } else {
                                    await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
                                  }
                      }
                    },
                  ),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(10, 350, 10, 0),
                    child: AnimatedOpacity(
                        opacity: _visible ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 500),
                        child: Container(
                          height: 400,
                          // color: Colors.red,
                          child: Column(children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color.fromARGB(255, 214, 210, 210),
                              ),
                              height: 50,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      minWidth: 225,
                                      height: 50,
                                      color: _barcode
                                          ? Color.fromARGB(255, 255, 17, 17)
                                          : Color.fromARGB(255, 214, 210, 210),
                                      onPressed: () {
                                        setState(() {
                                          _barcode = true;
                                        });
                                      },
                                      child: Text(
                                        "Barcode",
                                        style: TextStyle(
                                            color: _barcode
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      minWidth: 225,
                                      height: 50,
                                      color: _barcode
                                          ? Color.fromARGB(255, 214, 210, 210)
                                          : Color.fromARGB(255, 255, 17, 17),
                                      onPressed: () {
                                        setState(() {
                                          _barcode = false;
                                          length.clear();
                                          ganjil.clear();
                                          genap.clear();
                                        });
                                      },
                                      child: Text(
                                        "QR",
                                        style: TextStyle(
                                            color: _barcode
                                                ? Colors.black
                                                : Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                   
                                  ]),
                            ),
                            Container(
                                child: _barcode
                                    ? Column(
                                      children: [
                                        Container(
                                            margin:
                                                EdgeInsets.fromLTRB(10, 100, 10, 0),
                                            child: Center(
                                                child: BarCodeImage(
                                              backgroundColor: Colors.white,
                                              params: Code128BarCodeParams(
                                                "${data}",
                                                lineWidth:
                                                    1.5, // width for a single black/white bar (default: 2.0)
                                                barHeight:
                                                    100, // height for the entire widget (default: 100.0)
                                                withText:
                                                    false, // Render with text label or not (default: false)
                                              ),
                                              padding: EdgeInsets.only(bottom: 7),
                                              onError: (error) {
                                                // Error handler
                                                print('error = $error');
                                              },
                                            ))),
                                             Text('${hasilAkhir}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                                      ],
                                    )
                                    : Column(
                                      children: [
                                        Container(
                                            margin: EdgeInsets.fromLTRB(
                                                100, 50, 100, 0),
                                            child: PrettyQr(
                                              image: AssetImage(
                                                  'assets/ramayana(C).png'),
                                              size: 200,
                                              data: '$data',
                                              errorCorrectLevel:
                                                  QrErrorCorrectLevel.M,
                                              typeNumber: 7,
                                              roundEdges: false,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text('${hasilAkhir}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                                      ],
                                    ))
                          ]),
                        )

                        // Container(
                        //   margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     children: [
                        //       Container(
                        //           margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        //           child: Center(
                        //             child: BarCodeImage(
                        //               backgroundColor: Colors.white,
                        //               params: Code128BarCodeParams(
                        //                 "${data}",
                        //                 lineWidth:
                        //                     1.5, // width for a single black/white bar (default: 2.0)
                        //                 barHeight:
                        //                     100, // height for the entire widget (default: 100.0)
                        //                 withText:
                        //                     false, // Render with text label or not (default: false)
                        //               ),
                        //               padding: EdgeInsets.only(bottom: 7),
                        //               onError: (error) {
                        //                 // Error handler
                        //                 print('error = $error');
                        //               },
                        //             ),
                        //           )),
                        //       Container(
                        //         margin: EdgeInsets.fromLTRB(100, 30, 100, 0),
                        //         child: PrettyQr(
                        //           image: AssetImage('assets/ramayana(C).png'),
                        //           size: 200,
                        //           data: '$data',
                        //           errorCorrectLevel: QrErrorCorrectLevel.M,
                        //           typeNumber: 7,
                        //           roundEdges: false,
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // )
                        )),
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
