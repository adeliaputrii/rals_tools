part of 'import.dart';

class RamayanaBarcode extends StatefulWidget {
  RamayanaBarcode({super.key, required this.dataMember});
  memberResponse.Data dataMember;

  @override
  State<RamayanaBarcode> createState() => _RamayanaBarcodeState();
}

class _RamayanaBarcodeState extends State<RamayanaBarcode> {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  Dio dio = Dio();
  UserData userData = UserData();
  var balance = "";
  var memberCode = "";

  String _udid = 'Unknown';
  @override
  void initState() {
    super.initState();
    initPlatformState();
    _secureScreen();
    didPush();
    didPopNext();
    setData();
  }

  void setData() {
    balance = widget.dataMember.saldo ?? "0";
    memberCode = widget.dataMember.nokartu ?? "";
  }

  @override
  void didPush() {
    ScreenBrightness().setScreenBrightness(1.0);
  }

  @override
  void didPopNext() {
    ScreenBrightness().setScreenBrightness(1.0);
  }

  _secureScreen() async {
    await FlutterWindowManager.addFlags(
        FlutterWindowManager.FLAG_SECURE); // Menonaktifkan tangkapan layar
  }

  _unsecureScreen() async {
    await FlutterWindowManager.clearFlags(FlutterWindowManager
        .FLAG_SECURE); // Mengaktifkan kembali tangkapan layar
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            _unsecureScreen();
            AndroidDeviceInfo info = await deviceInfo.androidInfo;

            var formData = FormData.fromMap({
              'progname': 'RALS_TOOLS ',
              'versi': '${versi}',
              'date_run': '${DateTime.now()}',
              'info1': 'Barcode No.Kartu Menu ID Cash',
              ' info2': '${_udid} ',
              'userid': '${userData.getUsernameID()}',
              ' toko': '${userData.getUserToko()}',
              ' devicename': '${info.device}',
              'TOKEN': 'R4M4Y4N4'
            });

            var response = await dio.post('${tipeurl}v1/activity/createmylog',
                data: formData);
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return RamayanaIDCash();
            }), (route) => false);
          },
          icon: Icon(Icons.arrow_back_ios,
              color: Colors.white,),
        ),
        title: Container(
            margin: EdgeInsets.only(left: 100, right: 115),
            child: Text('Kode ID Cash',
                style: GoogleFonts.plusJakartaSans(
                    textStyle: TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                        fontWeight: FontWeight.w500)))),
        backgroundColor: Color.fromARGB(255, 255, 0, 0),
        elevation: 0,
        toolbarHeight: 80,
      ),
      body: Stack(fit: StackFit.loose, children: <Widget>[
        Container(
          // height: MediaQuery.of(context).size.height/1.129,
          color: Color.fromARGB(255, 227, 222, 222),
        ),
        Container(
          color: Color.fromARGB(255, 255, 0, 0),
          height: 200,
        ),
        Container(
          //  height: MediaQuery.of(context).size.height/1.129,
          //  color: Colors.green,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipPath(
                    clipper: CustomTicket(),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                      height: MediaQuery.of(context).size.height / 1.555,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                  left: 100, right: 100, top: 10),
                              width: 10000,
                              height: MediaQuery.of(context).size.height / 12,
                              decoration: BoxDecoration(

                                  // color: Colors.green,

                                  ),
                              child: Image.asset('assets/Logo-Ramayana.png')),
                          Container(
                            height: 2.5,
                            color: Color.fromARGB(255, 223, 223, 223),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 2.8,
                            //  color: Colors.amber,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        margin:
                                            EdgeInsets.fromLTRB(20, 20, 0, 0),
                                        child: Text('Max Pembayaran',
                                            style: GoogleFonts.plusJakartaSans(
                                                textStyle: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500)))),
                                    Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 20, 20, 0),
                                        child: Text(
                                            '${int.tryParse(balance)?.toIdr() ?? "-"}',
                                            style: GoogleFonts.plusJakartaSans(
                                                textStyle: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500)))),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
                                  child: PrettyQr(
                                    image: AssetImage('assets/ramayana(C).png'),
                                    size: 230,
                                    data: '${memberCode}',
                                    errorCorrectLevel: QrErrorCorrectLevel.M,
                                    typeNumber: 7,
                                    roundEdges: false,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                  height:
                                      MediaQuery.of(context).size.height / 10,
                                  color: Colors.deepOrange,
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: SfBarcodeGenerator(
                                      value: '${memberCode}',
                                      backgroundColor: Colors.white,
                                      barColor: Colors.black,
                                      symbology: Code128B())),
                              Container(
                                height: MediaQuery.of(context).size.height / 15,
                                // color: Colors.blue,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Copyright RALS',
                                        style: GoogleFonts.plusJakartaSans(
                                            textStyle: TextStyle(
                                                fontSize: 17,
                                                color: Colors.black))),
                                    Icon(
                                      Icons.copyright,
                                      color: Colors.black,
                                      size: 21,
                                    ),
                                    Text('${copyright}',
                                        style: GoogleFonts.plusJakartaSans(
                                            textStyle: TextStyle(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500)))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                    child: MaterialButton(
                        padding: EdgeInsets.symmetric(horizontal: 200),
                        height: MediaQuery.of(context).size.height / 20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text('OK',
                            style: GoogleFonts.plusJakartaSans(
                                textStyle: TextStyle(
                                    fontSize: 20, color: Colors.white))),
                        color: Color.fromARGB(255, 255, 17, 17),
                        onPressed: () async {
                          _unsecureScreen();
                          AndroidDeviceInfo info = await deviceInfo.androidInfo;

                          var formData = FormData.fromMap({
                            'progname': 'RALS_TOOLS ',
                            'versi': '${versi}',
                            'date_run': '${DateTime.now()}',
                            'info1': 'Barcode No.Kartu Menu ID Cash',
                            ' info2': '${_udid} ',
                            'userid': '${userData.getUsernameID()}',
                            ' toko': '${userData.getUserToko()}',
                            ' devicename': '${info.device}',
                            'TOKEN': 'R4M4Y4N4'
                          });

                          var response = await dio.post(
                              '${tipeurl}v1/activity/createmylog',
                              data: formData);
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) {
                            return RamayanaIDCash();
                          }), (route) => false);
                        }))
              ]),
        )
      ]),
    );
  }
}

class CustomTicket extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    //Radius
    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(0),
      ),
    );

    // Left Round In
    // path.addOval(
    //   Rect.fromCircle(
    //     center: Offset(1, (size.height/ 11) * 1.8), // Position Roun In Left
    //     radius: 16, // Size
    //   ),
    // );
    path.addOval(
      Rect.fromCircle(
        center: Offset(5, (size.height / 2.6) * 1.8), // Position Roun In Left
        radius: 16, // Size
      ),
    );

    // Right Round In
    // path.addOval(
    //   Rect.fromCircle(
    //     center: Offset(size.width - 1, (size.height / 11) * 1.8), // Position Roun In Right
    //     radius: 16, // Size
    //   ),
    // );
    path.addOval(
      Rect.fromCircle(
        center: Offset(size.width - 5,
            (size.height / 2.6) * 1.8), // Position Roun In Right
        radius: 16, // Size
      ),
    );

    // Horizontal Line Dash
    const dashWidth = 10;
    const dashSpace = 7;
    final dashCount = size.width ~/ (dashWidth + dashSpace);

    for (var i = 0; i < dashCount; i++) {
      path.addRect(
        Rect.fromLTWH(
          i * (dashWidth + dashSpace).toDouble() + 22,
          (size.height / 2.6) * 1.8,
          dashWidth.toDouble(),
          1.5,
        ),
      );
    }

    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
