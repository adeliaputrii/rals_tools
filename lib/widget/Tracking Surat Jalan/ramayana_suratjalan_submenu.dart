part of'import.dart';

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
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(width: 10),
        centerTitle: true,
        title: Text(
          'Tracking Surat Jalan',
          style: GoogleFonts.plusJakartaSans(fontSize: 23, color: Colors.white)
        ),
        backgroundColor: Color.fromARGB(255, 210, 14, 0),
        elevation: 3,
        toolbarHeight: 90,
      ),

      body: Stack(children: [
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
                              Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) => RamayanaSuratJalanScan(),),(Route<dynamic> route) => false);
                            print(barcodeScan.text);
                          },
                          child: Row(
                            children: [
                            SizedBox(
                              width: 20,
                            ),
                             Container(
                              height: 40,
                              width: 40,
                              child: Image.asset('assets/sj_submenu_lacakscann.png')),
                             SizedBox(
                              width: 20,
                            ),
                             Text('Scan',
                             style:GoogleFonts.plusJakartaSans(fontSize: 27, color: Color.fromARGB(255, 210, 0, 0),),
                             )
                            ],
                          )
                        )
                          ),

              Container(
                        margin: EdgeInsets.only(bottom: 50),
                        child: MaterialButton(
                          height: 80,
                          color: Color.fromARGB(255, 227, 227, 227),
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                          ),
                          onPressed: () async {
                             Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) => RamayanaSuratJalanLacak(),),(Route<dynamic> route) => false);
                          },
                          child: Row(
                            children: [
                            SizedBox(
                              width: 20,
                            ),
                             Container(
                              height: 50,
                              width: 50,
                              child: Image.asset('assets/sj_submenu_lacak.png')),
                             SizedBox(
                              width: 20,
                            ),
                             Text('Lacak',
                             style: GoogleFonts.plusJakartaSans(fontSize: 27, color: Color.fromARGB(255, 185, 24, 24)),
                             )
                            ],
                          )
                        )
                          )
            ],
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 210, 14, 0),
    onPressed: () { 
      Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => 
       DefaultBottomBarController(child: Ramayana()),), 
       (Route<dynamic> route) => false);
     },
    child: const Icon(IconlyBold.home),
  ),
  floatingActionButtonLocation:    
      FloatingActionButtonLocation.centerFloat,
  bottomNavigationBar: new BottomAppBar(
    color: Colors.white,
)
    );
  }
}