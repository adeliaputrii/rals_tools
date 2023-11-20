part of'import.dart';

class RamayanaSuratJalanLacak extends StatefulWidget {
  const RamayanaSuratJalanLacak({super.key});

  @override
  State<RamayanaSuratJalanLacak> createState() => _RamayanaSuratJalanLacakState();
}

class _RamayanaSuratJalanLacakState extends State<RamayanaSuratJalanLacak> with SingleTickerProviderStateMixin {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController noSj = TextEditingController();
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  late TabController _controller;
  
    double turns = 0.0;
    bool _flip = false;
    bool isLoading = false;
    bool _visible = false;
    Color _containerColorSj = Color.fromARGB(255, 210, 14, 0);
    Color _containerColorLacak = Color.fromARGB(255, 201, 201, 201);
    final _stepperData = List.generate(4, (index) => StepperItemData(
    id: '$index',
    content: ({
      'name': 'Packing',
      'occupation': 'Ramayana Yogyakarta',
      'deskripsi': 'Barang diterima',
      'mobileNumber': 'Petugas deskripsi disini',
      'email': 'Radit',
      'no_truck' : '123456',
      'born_date': '12\nOkt',
    }),
    
  )).toList();

  Future<void> scanBarcodeScan() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
       if (barcodeScanRes == '-1') {
      print('Barcode not valid');
    } else {
       noSj..text = barcodeScanRes;
    }
      
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    if (!mounted) return;
    setState(() {
      noSj..text = barcodeScanRes;
    });
   
  }
  }

   @override
  void initState() {
    
    super.initState();
    _controller = TabController(length: 2, vsync: this)
      ..addListener(() {
        if (_controller.index == 0) {
          print("Tab 0 is selected");
          setState(() {
            turns += 1/2;
            _containerColorSj = Color.fromARGB(255, 210, 14, 0);
            _containerColorLacak = Color.fromARGB(255, 201, 201, 201);
            
          });
          // Do your specific action here
        } else {
         setState(() {
          turns += 1/2;
           _containerColorSj = Color.fromARGB(255, 201, 201, 201);
          _containerColorLacak = Color.fromARGB(255, 210, 14, 0);
          
          });
        }
      });
      
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          
          body: 
          Stack(
            children: [
              Container(
                color: Color.fromARGB(255, 210, 14, 0),
                height: 220,
              ),
              Container(
            margin: EdgeInsets.only(top: 30, left: 20),
            height: 50,
            child: IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> RamayanaSuratJalan()
                ), (route) => false);
              },
              icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 23,),
              )
          ),
          Container(
            margin: EdgeInsets.only(top: 80, left: 30),
            height: 50,
            child: Text('Lacak Surat Jalan',
              style: GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 140),
              decoration: BoxDecoration(
              color: Color.fromARGB(255, 254, 252, 252),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 211, 210, 210),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(2,4)
                )
              ]
              ),
              height: 185,
              child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10, top: 20, left: 30),
                        child: Text('No.Surat Jalan',
                        style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black),
                        )),
                      Container(
                        margin: EdgeInsets.only(bottom: 5, left: 20,),
                        // height: 60,
                        decoration: BoxDecoration(
                        // color: Color.fromARGB(255, 236, 236, 236),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 50,
                              // color: Colors.green,
                              child: IconButton(
                                onPressed: () {
                                  scanBarcodeScan();
                                },
                                icon: Icon(IconlyBold.scan,
                                color: Color.fromARGB(255, 210, 14, 0),
                                size: 40,
                                ),
                              ),
                            ),
                            Form(
                              key: _formKey,
                              child: Container(
                                margin: EdgeInsets.only(left: 20, bottom: 10),
                                width: 300,
                                // color: Colors.blue,
                                child: TextFormField(
                                  validator:
                                RequiredValidator(errorText: ' Please Enter'),
                                  controller: noSj,
                                  style: GoogleFonts.plusJakartaSans(color: Colors.black, fontSize: 18),
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                   enabledBorder: UnderlineInputBorder(      
                                    borderSide: BorderSide(color: Colors.black),   
                                  ),  
                                  focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  ),  
                                ),
                                  
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Center(
                        child: MaterialButton(
                          color: Color.fromARGB(255, 210, 14, 0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          onPressed: () async{
                             if (_formKey.currentState!.validate()) {
                            setState(() {
                            isLoading = true;
                            _visible = true;
                          });
                          await Future.delayed(const Duration(seconds: 3));
                          
                          setState(() {
                            isLoading = false;
                          });
                             }
                          },
                          child: Text('Search', style: GoogleFonts.plusJakartaSans(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),),
                          ),
                      )
                    ],
                  ),
            ),
            
              Container(
                margin: EdgeInsets.only(top: 390),
                child: isLoading
                ? SpinKitThreeBounce(
                    color: Color.fromARGB(255, 210, 14, 0),
                    size: 50.0,
                  )
                :
                AnimatedOpacity(
                  opacity: _visible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: TabBarView(
                    controller: _controller,
                    children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
                    child: ListView(
                      children: [
                        
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10, bottom: 10),
                              child: Text('No.Dokumen',
                              style: GoogleFonts.plusJakartaSans(fontSize: 17),
                              )),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              height: 50,
                              decoration: BoxDecoration(
                              color: Color.fromARGB(255, 236, 236, 236),
                                borderRadius: BorderRadius.circular(20)
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10, bottom: 10),
                              child: Text('Tipe Dokumen',
                              style: GoogleFonts.plusJakartaSans(fontSize: 17),
                              )),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              height: 50,
                              decoration: BoxDecoration(
                              color: Color.fromARGB(255, 236, 236, 236),
                                borderRadius: BorderRadius.circular(20)
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10, bottom: 10),
                              child: Text('Asal',
                              style: GoogleFonts.plusJakartaSans(fontSize: 17),
                              )),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              height: 50,
                              decoration: BoxDecoration(
                              color: Color.fromARGB(255, 236, 236, 236),
                                borderRadius: BorderRadius.circular(20)
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10, bottom: 10),
                              child: Text('Tujuan',
                              style: GoogleFonts.plusJakartaSans(fontSize: 17),
                              )),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              height: 50,
                              decoration: BoxDecoration(
                              color: Color.fromARGB(255, 236, 236, 236),
                                borderRadius: BorderRadius.circular(20)
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10, bottom: 10),
                              child: Text('Status',
                              style: GoogleFonts.plusJakartaSans(fontSize: 17),
                              )),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              height: 50,
                              decoration: BoxDecoration(
                              color: Color.fromARGB(255, 236, 236, 236),
                                borderRadius: BorderRadius.circular(20)
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10, bottom: 10),
                              child: Text('Petugas',
                              style: GoogleFonts.plusJakartaSans(fontSize: 17),
                              )),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              height: 50,
                              decoration: BoxDecoration(
                              color: Color.fromARGB(255, 236, 236, 236),
                                borderRadius: BorderRadius.circular(20)
                              ),
                            ),
                            
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10, bottom: 10),
                              child: Text('No.Mobil',
                              style: GoogleFonts.plusJakartaSans(fontSize: 17),
                              )),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              height: 50,
                              decoration: BoxDecoration(
                              color: Color.fromARGB(255, 236, 236, 236),
                                borderRadius: BorderRadius.circular(20)
                              ),
                            ),
                            
                          ],
                        ),Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10, bottom: 10),
                              child: Text('Catatan',
                              style: GoogleFonts.plusJakartaSans(fontSize: 17),
                              )),
                            Container(
                              margin: EdgeInsets.only(bottom: 30),
                              height: 120,
                              decoration: BoxDecoration(
                              color: Color.fromARGB(255, 236, 236, 236),
                                borderRadius: BorderRadius.circular(20)
                              ),
                            ),
                            
                          ],
                        ),
                      ]),
                  ),
                              //-----------------------------------------------------------------------------------------------------------------------------------------------
                  Container(
                    margin: EdgeInsets.only(top: 0),
                    
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: StepperListView(
                      showStepperInLast: true,
                      stepperData: _stepperData,
                      stepAvatar: (_, data) {
                        final stepData = data as StepperItemData;
                        return PreferredSize(
                          preferredSize: const Size.fromRadius(20),
                          child: CircleAvatar(
                      backgroundImage: AssetImage('assets/menu/surat_jalan/paket.png')
                          ),
                        );
                      },
                      stepWidget: (_, data) {
                        final stepData = data as StepperItemData;
                        return PreferredSize(
                          preferredSize: const Size.fromWidth(30),
                          child: Text(
                      stepData.content['born_date'] ?? '',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center,
                          ),
                        );
                      },
                      stepContentWidget: (_, data) {
                        final stepData = data as StepperItemData;
                        return Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(179, 241, 241, 241),
                            borderRadius: BorderRadius.circular(30)
                          ),
                          margin: const EdgeInsets.only(
                      bottom: 10
                          ),
                          padding: const EdgeInsets.all(
                      10,
                          ),
                          child: ListTile(
                      contentPadding: const EdgeInsets.all(7),
                      title: Container(
                        margin: EdgeInsets.only(top: 0),
                        child: Row(
                          children: [
                            Text('Status                   : ', style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),),
                            Container(
                              height: 30,
                              width: 100,
                              decoration: BoxDecoration(
                              color: Color.fromARGB(255, 195, 0, 0),
                              borderRadius: BorderRadius.circular(20)
                              ),
                              child: Center(
                                child: Text(stepData.content['name'] ?? '',
                                style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      subtitle: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Expanded(
                                child: Icon(IconlyLight.location, color: Colors.red,size: 25,),
                              ),
                               Text('Lokasi         : ', style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Color.fromARGB(255, 87, 87, 87)),),
                              Expanded(
                                flex: 7,
                                child: Text(stepData.content['occupation'] ?? '',
                                style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Color.fromARGB(255, 87, 87, 87)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Expanded(
                                child: Icon(IconlyLight.paper, color: Colors.red,size: 25,),
                              ),
                              Text('Deskripsi : ', style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Color.fromARGB(255, 87, 87, 87)),),
                              Expanded(
                                flex: 7,
                                child: Text(stepData.content['deskripsi'] ?? '',
                                style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Color.fromARGB(255, 87, 87, 87)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Expanded(
                                child: Icon(IconlyLight.document, color: Colors.red,size: 25,),
                              ),
                              Text('Note            : ', style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Color.fromARGB(255, 87, 87, 87)),),
                              Expanded(
                                flex: 7,
                                child: Text(stepData.content['mobileNumber'] ?? '',
                                style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Color.fromARGB(255, 87, 87, 87)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          
                          Row(
                            children: [
                              const Expanded(
                                child: Icon(IconlyLight.profile, color: Colors.red,size: 25,),
                              ),
                              Text('Petugas   : ', style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Color.fromARGB(255, 87, 87, 87)),),
                              Expanded(
                                flex: 7,
                                child: Text(stepData.content['email'] ?? '',
                                style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Color.fromARGB(255, 87, 87, 87)),
                                ),
                              ),
                            ],
                          ), const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Expanded(
                                child: Icon(Icons.fire_truck_outlined, color: Colors.red,size: 25,),
                              ),
                              Text('No. Mobil : ', style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Color.fromARGB(255, 87, 87, 87)),),
                              Expanded(
                                flex: 7,
                                child: Text(stepData.content['no_truck'] ?? '',
                                style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Color.fromARGB(255, 87, 87, 87)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    
                          ),
                        );
                      },
                      stepperThemeData: StepperThemeData(
                        lineColor: Colors.red,
                        lineWidth: 1,
                      ),
                      physics: const BouncingScrollPhysics(),
                      ),
                    ),
                  ),
                        ]),
                ),
              ),
              // -------------------------------------------------------------------------------------------------------------------------------
              Container(
              margin: EdgeInsets.only(top: 345, left: 20, right: 20, bottom: 30),
              // color: Colors.blue, 
              // height: 50,
             child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Container(
                  height: 45, 
                  width: 180,
                  decoration: BoxDecoration(
                  color: _containerColorSj,
                  borderRadius: BorderRadius.circular(30)
                  ),
                  child: Center(child: Text('Surat Jalan', style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.white),)),
                ),
                
                MaterialButton(
                  // color: Colors.green,
                  minWidth: 5,
                  onPressed: () {
             
                    if (_controller.index == 0) {
                      print(_controller.index);
                      setState(() {
                        turns += 1/2;
                      _controller.animateTo(_controller.index + 1);
                      print(_controller.index);
                      
                      });
                    } else {
                      print(_controller.index);
                      setState(() {
                      turns += 1/2;
                      _controller.animateTo(_controller.index - 1);
                      print(_controller.index);
                     
                      });
                    }
                  }, 
                  child: 
                  AnimatedRotation(
                    turns: turns,
                    duration: Duration(milliseconds: 400),
                    child: Icon(Icons.swap_horiz_rounded,
                    color: Colors.black,
                    size: 28,
                    ),
                  ),
                
                  ),
                Container(
                  height: 45, 
                  width: 180,
                  decoration: BoxDecoration(
                  color: _containerColorLacak,
                  borderRadius: BorderRadius.circular(30)
                  ),
                  child: Center(child: Text('Lacak Lokasi', style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.white),)),
                )
                ],),
            ),
            ],
          ),
        ),
      );
    
  }
}