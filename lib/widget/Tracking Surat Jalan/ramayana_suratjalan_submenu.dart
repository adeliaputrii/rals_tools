part of 'import.dart';

class RamayanaSuratJalan extends StatefulWidget {
  const RamayanaSuratJalan({super.key});

  @override
  State<RamayanaSuratJalan> createState() => _RamayanaSuratJalanState();
}

class _RamayanaSuratJalanState extends State<RamayanaSuratJalan> {
  TextEditingController barcodeScan = TextEditingController();
  TextEditingController barcodeLacak = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (true) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => DefaultBottomBarController(child: Ramayana()),
              ),
              (Route<dynamic> route) => false);
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Lacak Surat Jalan', style: GoogleFonts.plusJakartaSans(fontSize: 25, color: Colors.white)),
          backgroundColor: Color.fromARGB(255, 210, 14, 0),
          elevation: 3,
          toolbarHeight: 90,
        ),
        body: ListView(
          children: [
            Stack(children: [
              Container(
                color: Colors.white,
              ),
              Container(
                height: 480,
                child: Image.asset(
                  'assets/sj_submenu_background.png',
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 480, left: 20, right: 20),
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(bottom: 40),
                        child: MaterialButton(
                            height: 80,
                            color: Color.fromARGB(255, 227, 227, 227),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                            onPressed: () async {
                              // scanBarcodeScan();
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return RamayanaSuratJalanScan();
                              }));
                              print(barcodeScan.text);
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Container(height: 40, width: 40, child: Image.asset('assets/sj_submenu_lacakscann.png')),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Scan',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 27,
                                    color: Color.fromARGB(255, 210, 0, 0),
                                  ),
                                )
                              ],
                            ))),
                    Container(
                        margin: EdgeInsets.only(bottom: 50),
                        child: MaterialButton(
                            height: 80,
                            color: Color.fromARGB(255, 227, 227, 227),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                            onPressed: () async {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return RamayanaSuratJalanLacak();
                              }));
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Container(height: 50, width: 50, child: Image.asset('assets/sj_submenu_lacak.png')),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Lacak',
                                  style: GoogleFonts.plusJakartaSans(fontSize: 27, color: Color.fromARGB(255, 185, 24, 24)),
                                )
                              ],
                            ))),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
