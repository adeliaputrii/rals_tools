
part of 'import.dart';

class RamayanaVoid extends StatefulWidget {
    static const routeName = '/RamayanaVoid';
  const RamayanaVoid({super.key});

  @override
  State<RamayanaVoid> createState() => _RamayanaVoidState();
}

class _RamayanaVoidState extends State<RamayanaVoid> with RouteAware {
  DbHelper db = DbHelper();
  

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String _udid = 'Unknown';
    var dio = Dio();
  UserData userData = UserData();
  bool _isKeptOn = true;
  double _brightness = 1.0;
  var imei2 = '';

  @override
  void initState() {
    super.initState();
    _loadImei();
    _checkInternetConnection();
    setState(() {
      _isConnected;
    });
    print('123');
  }
//adel kalo void apa?


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
  bool? _isConnected;

  @override
  void didPush() {
    super.didPush();
    ScreenBrightness().setScreenBrightness(1.0);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    ScreenBrightness().setScreenBrightness(1.0);
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

  Future<String> _getLogikaVoid() async {
    // user id
    UserData userData = UserData();
    await userData.getPref();
    String userId = userData.getUsernameID();
    // String userId = '460545';
    String? randomAngka = myController.text;
    print('grgr 123');
    print(userId);
    
    late int numberStepOne;
    late int numberStepTwo;

    late String result;

    if (randomAngka != null && userId != null) {
    numberStepOne = stepOne(input: randomAngka);
    numberStepTwo = stepTwo(input: numberStepOne);
    result = stepThree(
      angkaKedua: numberStepTwo.toString(), angkaPertama: userId);
    print('Hasil : ${result}');
  }
  return result;
}

  int stepOne({required String input}) {
  int current = 1;
  for (int i = 0; i < input.length; i++) {
    print('Check number :${input[i]} at index $i');
    if (input[i] == '0') {
      print('catch 1');
      print('current = $current * ${i + 1}');
      current = current * (i + 1);
      print('coba current if');
      print(current);
    } else {
      print('catch 2');
      print('current = $current * ${int.parse(input[i])}');
      current = current * int.parse(input[i]);
      print('coba current else');
      print(current);
    }
    print('current val is $current');
  }
  return current;
}

int stepTwo({required int input}) {
  print('coba hasil input');
  print(input);
  return (input * 121) - 100;
}

String stepThree({required String angkaPertama, required String angkaKedua}) {
  int prefixNumber = 0;
  int postNumber = 0;
  if (angkaPertama.length >= 3) {
    prefixNumber = int.parse(angkaPertama.substring(0, 3)) + 13;
    postNumber = int.parse(angkaPertama.substring(3, angkaPertama.length)) + 18;
  }
   else if (angkaPertama.length > 0) {
    prefixNumber = 
      int.parse(angkaPertama.substring(0, angkaPertama.length)) + 13;
  } 
  else {}
  return '${prefixNumber}X${angkaKedua}B${postNumber}';
}
  
  String data = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
        appBar: AppBar(
           leading: 
           IconButton(onPressed: () async{
            await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => DefaultBottomBarController(child: Ramayana()),), (Route<dynamic> route) => false);
           },
          icon: Icon(Icons.arrow_back_ios, size: 20,),),
          title: Text('Void', style: GoogleFonts.plusJakartaSans(textStyle: TextStyle(fontSize: 23, color: Colors.white,fontWeight: FontWeight.w500 ))),
          backgroundColor: Color.fromARGB(255, 255, 17, 17),
          elevation: 7.20  ,
          toolbarHeight: 90,
          ),
    
        body: 
        
        ListView(
          children: [
            Stack(
                children: <Widget>[
          
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    color: Color.fromARGB(255, 253, 249, 249)
                  ),
          
                  Container(
                    width: MediaQuery.of(context).size.width/1,
                    height: 170,
                    color: Color.fromARGB(255, 255, 17, 17),
                  ),
                  
                  Container(
                  margin: EdgeInsets.fromLTRB(30, 30,30, 0),
                  
                  child:
                    Text(
                    'Approval Void & Return', style: GoogleFonts.plusJakartaSans(textStyle: TextStyle(fontSize: 21, color: Colors.white ))
                     ),
                    ),
          
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 100, 10, 0),  
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 255, 255, 255),
                      boxShadow: [BoxShadow( 
                      blurRadius: 5
                      )]
                      ),
                ),
                    
                  SizedBox(
                  height: 30,
                  width: 30,
                  ),
                          
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 130, 30, 0),
                    child:
          
                      Form(
                        key: _formKey,
                          child: 
          
                          TextFormField(
                            controller: myController,
                            style: TextStyle(fontSize: 20, color: Colors.black),
                            validator: (value) {
                            if(value!.isEmpty){
                            return "Required";
                           }
                          },
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                              color: Colors.black, 
                              width: 5.0),
                              borderRadius: BorderRadius.circular(25)
                             ),
                            errorBorder: OutlineInputBorder( 
                              borderSide: BorderSide(color: Color.fromARGB(255, 255, 17, 17),), borderRadius: BorderRadius.circular(25)),
                            errorStyle: TextStyle(color: Color.fromARGB(255, 255, 17, 17), fontSize: 14, fontWeight: FontWeight.w400),
                            labelStyle: TextStyle(
                             color: Colors.black87
                              ),
                            prefixIcon: Icon(
                             Icons.keyboard,
                             color: Color.fromARGB(255, 255, 17, 17),
                             size: 30,
                            ),
                            hintStyle: TextStyle(
                             color:  Colors.black,
                             fontSize: 20
                             ),
                            enabledBorder: OutlineInputBorder(borderSide: new BorderSide(color: Colors.black),borderRadius: BorderRadius.circular(25)),
                            focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: new BorderSide(color: Colors.black),
                            )
                            )      
                          )
                      )
                    ),
          
                    Container(
                      margin: EdgeInsets.fromLTRB(160, 230, 160, 0),
                      width: 150,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 17, 17),
                        borderRadius: BorderRadius.circular(30)
                        ),
                        height: 40,
                        child: 
                         
                            TextButton(
                              child: 
                               Text(
                              'GENERATE', style: GoogleFonts.plusJakartaSans(textStyle: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500 ))
                               ),
                              onPressed: () async {
                                 if (_formKey.currentState!.validate()) {
                                  didPush();
                                 didPopNext();
                                  data = await _getLogikaVoid();    
                                  setState(() {
                                    _visible = true;
                                  });
                                 print(_visible);
                                  if (_visible == true) {
                                    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
                                  } else {
                                    await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
                                  }
                                  await _checkInternetConnection();
                                if (_isConnected == true) {
                                 
                                  print('is connect');
                                   AndroidDeviceInfo info = await deviceInfo.androidInfo;
                                var formData = FormData.fromMap({
                                'progname': 'RALS_TOOLS ',
                                'versi': '${versi}',
                                'date_run': '${DateTime.now()}',
                                'info1': 'Aktivitas Void - Menu Void ,',
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
                                      deskripsi: 'Aktivitas Void - Menu Void',
                                      datetime: '${DateTime.now()}',
                                      ));
                                    }
                                 }
                                 else {
                                  print('required');
                                 }
                                },
                              ),
                          
                            ),
                     
                    Container(
                     margin: EdgeInsets.fromLTRB(10, 350, 10, 0),
                     child: 
                     AnimatedOpacity(
                     opacity: _visible ? 1.0 : 0.0,
                     duration: const Duration(milliseconds: 500),
                     child: 
                     
                     Container(
                         margin: EdgeInsets.fromLTRB(10, 0,10, 0),
                          child: 
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
          
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 0,10, 0),
                                     child: 
                                      Center(
                                        child: 
                                        BarCodeImage(
                                          backgroundColor: Colors.white,
                                          params: Code128BarCodeParams(
                                          "${data}",
                                          lineWidth: 1.5,                // width for a single black/white bar (default: 2.0)
                                          barHeight: 100,               // height for the entire widget (default: 100.0)
                                          withText: false,                // Render with text label or not (default: false)
                                         ),
                                        padding: EdgeInsets.only(bottom: 7),
                                        onError: (error) {               // Error handler
                                          print('error = $error');
                                        },
                                    ),
                                   )
                                ),
                             
                    Container(
                      margin: EdgeInsets.fromLTRB(100,30, 100, 0),
                      child: 
                      PrettyQr(
                        image: AssetImage('assets/ramayana(C).png'),
                        size: 200,
                        data: '$data',
                        errorCorrectLevel: QrErrorCorrectLevel.M,
                        typeNumber: 7,
                        roundEdges: false,
                      ),
                      )
                   ],
                  ),
                  )
                     )
                  ),
                 
                
              ]
              ),
          ],
        ),
      );
      }
      ),
      onWillPop: () async {
        if (true) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
              return DefaultBottomBarController(child: Ramayana());
            }), (route) => false);
            return true;
        }
      },
    );
  }
}




