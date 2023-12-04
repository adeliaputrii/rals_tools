part of 'import.dart';

class RamayanaSuratJalanScan extends StatefulWidget {
  const RamayanaSuratJalanScan({super.key});

  @override
  State<RamayanaSuratJalanScan> createState() => _RamayanaSuratJalanScanState();
}

class _RamayanaSuratJalanScanState extends State<RamayanaSuratJalanScan> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> _formKeySearch = GlobalKey<FormState>();
  TextEditingController catatan = TextEditingController();
  TextEditingController noSjController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  bool isLoading = false;
  bool _visible = false;
  late SuratJalanCubit sjCubit;
  late PopUpWidget popUp;

  @override
  void initState() {
    popUp = PopUpWidget(context);
    sjCubit = context.read<SuratJalanCubit>();
    super.initState();
  }

  Future<void> scanBarcodeScan() async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
      if (barcodeScanRes == '-1') {
        popUp.showPopUp(notFound, 'Barcode tidak terdeteksi');
      } else {
        noSjController.text = barcodeScanRes;
        sjCubit.getScanTracking(noSjController.text);
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
      if (!mounted) return;
      setState(() {
        noSjController.text = barcodeScanRes;
        ScreenBrightness().resetScreenBrightness();
      });
    }
  }

  popup() {
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
            'SUCCESS',
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
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
    return Scaffold(
        body: BlocListener<SuratJalanCubit, SuratJalanState>(
      listener: (context, state) {
        if (state is SuratJalanSuccess) {
          setState(() {
            isLoading = false;
            _visible = true;
          });
          statusController.text =
              state.response.data!.trackingStatus!.description!;
        }
        if (state is SuratJalanLoading) {
          setState(() {
            isLoading = true;
          });
        }
        if (state is SuratJalanFailure) {
          setState(() {
            isLoading = false;
            _visible = false;
          });
          popUp.showPopUp(notFound, state.message);
        }
      },
      child: Stack(
        children: [
          Container(
            color: Color.fromARGB(255, 210, 14, 0),
          ),
          Container(
            margin: EdgeInsets.only(top: 330),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              color: Colors.white,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 130, left: 30, right: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            height: 185,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(bottom: 10, top: 20, left: 20),
                    child: Text(
                      'No.Surat Jalan',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 18, color: Colors.black),
                    )),
                Container(
                  margin: EdgeInsets.only(bottom: 5, left: 10),
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
                          icon: Icon(
                            IconlyBold.scan,
                            color: Color.fromARGB(255, 210, 14, 0),
                            size: 40,
                          ),
                        ),
                      ),
                      Form(
                        key: _formKeySearch,
                        child: Container(
                          margin: EdgeInsets.only(left: 20, bottom: 10),
                          width: 300,
                          // color: Colors.blue,
                          child: TextFormField(
                            validator:
                                RequiredValidator(errorText: ' Please Enter'),
                            controller: noSjController,
                            style: GoogleFonts.plusJakartaSans(
                                color: Colors.black, fontSize: 18),
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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () async {
                      if (_formKeySearch.currentState!.validate()) {
                        sjCubit.getScanTracking(noSjController.text.toString());
                      }
                    },
                    child: Text(
                      'Search',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 30, left: 20),
              height: 50,
              // color: Colors.amber,
              child: IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RamayanaSuratJalan()),
                      (route) => false);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 23,
                ),
              )),
          Container(
            margin: EdgeInsets.only(top: 80, left: 30),
            height: 50,
            // color: Colors.amber,
            child: Text(
              'Form Surat Jalan',
              style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 350, 30, 0),
            // color: Colors.amber,
            child: isLoading
                ? SpinKitThreeBounce(
                    color: Color.fromARGB(255, 210, 14, 0),
                    size: 50.0,
                  )
                : AnimatedOpacity(
                    opacity: _visible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: ListView(children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 10, bottom: 10),
                              child: Text(
                                'No.Dokumen',
                                style:
                                    GoogleFonts.plusJakartaSans(fontSize: 17),
                              )),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            height: 50,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 236, 236, 236),
                                borderRadius: BorderRadius.circular(20)),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 10, bottom: 10),
                              child: Text(
                                'Tipe Dokumen',
                                style:
                                    GoogleFonts.plusJakartaSans(fontSize: 17),
                              )),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            height: 50,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 236, 236, 236),
                                borderRadius: BorderRadius.circular(20)),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 10, bottom: 10),
                              child: Text(
                                'Asal',
                                style:
                                    GoogleFonts.plusJakartaSans(fontSize: 17),
                              )),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            height: 50,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 236, 236, 236),
                                borderRadius: BorderRadius.circular(20)),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 10, bottom: 10),
                              child: Text(
                                'Tujuan',
                                style:
                                    GoogleFonts.plusJakartaSans(fontSize: 17),
                              )),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            height: 50,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 236, 236, 236),
                                borderRadius: BorderRadius.circular(20)),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 10, bottom: 10),
                              child: Text(
                                'Status',
                                style:
                                    GoogleFonts.plusJakartaSans(fontSize: 17),
                              )),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            height: 50,
                            child: TextField(
                              controller: statusController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 236, 236, 236),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 236, 236, 236),
                                  ), //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 236, 236, 236),
                                  ), //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
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
                              child: Text(
                                'Petugas',
                                style:
                                    GoogleFonts.plusJakartaSans(fontSize: 17),
                              )),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            height: 50,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 236, 236, 236),
                                borderRadius: BorderRadius.circular(20)),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 10, bottom: 10),
                              child: Text(
                                'No.Mobil',
                                style:
                                    GoogleFonts.plusJakartaSans(fontSize: 17),
                              )),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            height: 50,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 236, 236, 236),
                                borderRadius: BorderRadius.circular(20)),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 10, bottom: 10),
                              child: Text(
                                'Catatan',
                                style:
                                    GoogleFonts.plusJakartaSans(fontSize: 17),
                              )),
                          Form(
                            key: _formKey,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 30),
                              height: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: TextFormField(
                                validator: RequiredValidator(
                                    errorText: ' Please Enter'),
                                controller: catatan,
                                cursorColor: Colors.black,
                                maxLines: 7,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  filled: true,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 30, right: 30, bottom: 30),
                            width: 500,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 210, 14, 0),
                                borderRadius: BorderRadius.circular(20)),
                            child: MaterialButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  popup();
                                  catatan.clear();
                                  noSjController.clear();
                                }
                              },
                              child: Text(
                                'Submit',
                                style: GoogleFonts.plusJakartaSans(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
          )
        ],
      ),
    ));
  }
}
