part of 'import.dart';

class RamayanaSuratJalanLacak extends StatefulWidget {
  RamayanaSuratJalanLacak({super.key, this.noSJ});
  String? noSJ;

  @override
  State<RamayanaSuratJalanLacak> createState() =>
      _RamayanaSuratJalanLacakState();
}

class _RamayanaSuratJalanLacakState extends State<RamayanaSuratJalanLacak>
    with SingleTickerProviderStateMixin {
  GlobalKey<FormState> sjKey = GlobalKey<FormState>();
  GlobalKey<FormState> sjSearchKey = GlobalKey<FormState>();
  TextEditingController noSjController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController noDocumentController = TextEditingController();
  TextEditingController documentTypeController = TextEditingController();
  TextEditingController noVehicleController = TextEditingController();
  TextEditingController driverNameController = TextEditingController();
  TextEditingController originController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  late TabController _controller;
  late SuratJalanCubit sjCubit;
  late LoginCubit loginCubit;

  double turns = 0.0;
  var barcodeSj = "";
  bool _flip = false;
  bool isLoading = false;
  bool _visible = false;
  Color _containerColorSj = Color.fromARGB(255, 210, 14, 0);
  Color _containerColorLacak = Color.fromARGB(255, 201, 201, 201);
  List<StepperItemData> stepperSJ = [];
  late PopUpWidget popUp;
  KeyboardUtils keyboardUtils = KeyboardUtils();
  final apiUrl = '${tipeurl}${basePath.api_tracking_scan}';

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
        noSjController..text = barcodeScanRes;
        barcodeSj = barcodeScanRes;
        trackBySuratJalan(barcodeScanRes);
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
      if (!mounted) return;
      setState(() {
        noSjController..text = barcodeScanRes;
      });
    }
  }

  trackBySuratJalan(String noSJ) {
    sjCubit.getScanTracking(noSJ);
    sjCubit.trackSJ(noSJ);
  }

  @override
  void initState() {
    super.initState();
    sjCubit = context.read<SuratJalanCubit>();
    loginCubit = context.read<LoginCubit>();
    popUp = PopUpWidget(context);
    if (widget.noSJ != null) {
      barcodeSj = widget.noSJ ?? "unknown";
      noSjController..text = widget.noSJ ?? "unknown";
      trackBySuratJalan(widget.noSJ!);
    }
    _controller = TabController(length: 2, vsync: this)
      ..addListener(() {
        if (_controller.index == 0) {
          print("Tab 0 is selected");
          setState(() {
            turns += 1 / 2;
            _containerColorSj = Color.fromARGB(255, 210, 14, 0);
            _containerColorLacak = Color.fromARGB(255, 201, 201, 201);
          });
          // Do your specific action here
        } else {
          setState(() {
            turns += 1 / 2;
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
    return BlocListener<SuratJalanCubit, SuratJalanState>(
        listener: (context, state) {
          if (state is ScanSJLoading) {
            stepperSJ.clear();
            setState(() {
              isLoading = true;
            });
          }

          if (state is SuratJalanSuccess) {
            loginCubit.createLog(baseParam.logInfoTrackSJPage,
                '${baseParam.logInfoScanSJSucc} No SJ ${barcodeSj}', apiUrl);
            setState(() {
              isLoading = false;
              _visible = true;
            });
            if (state.response.data.toString().isNotEmpty) {
              documentTypeController.text =
                  state.response.data!.detailSj?.documentType ?? baseParam.dash;
              originController.text =
                  state.response.data?.detailSj?.origin ?? baseParam.dash;
              destinationController.text =
                  state.response.data?.detailSj?.destination ?? baseParam.dash;
              driverNameController.text =
                  state.response.data?.detailSj?.driverName ?? baseParam.dash;
              noVehicleController.text =
                  state.response.data?.detailSj?.noVehicle ?? baseParam.dash;
              noSjController.text =
                  state.response.data?.detailSj?.noSj ?? baseParam.dash;
              noDocumentController.text =
                  state.response.data?.detailSj?.noSj ?? baseParam.dash;
              statusController.text =
                  state.response.data?.detailSj?.trackingStatus ??
                      baseParam.dash;
            }
          }

          if (state is SuratJalanFailure) {
            setState(() {
              _visible = false;
              isLoading = false;
            });
            loginCubit.createLog(
                baseParam.logInfoTrackSJPage,
                '${baseParam.logInfoScanSJFail} No SJ ${noSjController..text}',
                apiUrl);
            popUp.showPopUpError(notFound, state.message);
          }
          if (state is TrackSJSuccess) {
            // setState(() {
            //   isLoading = false;
            //   _visible = true;
            // });
            loginCubit.createLog(baseParam.logInfoTrackSJPage,
                '${baseParam.logInfoTrackSJSucc} No SJ ${barcodeSj}', apiUrl);

            int index = 0;
            final response = state.response.data;
            debugPrint(state.response.data!.first.remark);
            response!.forEach((element) {
              stepperSJ.add(StepperItemData(
                  id: "${index++}",
                  content: ({
                    'status': element.status,
                    'site': element.site,
                    'description': element.description != "null"
                        ? element.description
                        : "-",
                    'remark': element.remark,
                    'pic': element.pic,
                    'date': element.date,
                  })));
            });
          }

          if (state is TrackSJFailure) {
            loginCubit.createLog(
                baseParam.logInfoTrackSJPage,
                '${baseParam.logInfoTrackSJFail} No SJ ${noSjController..text} ${state.message}',
                apiUrl);
          }
        },
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: Stack(
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
                  child: Text(
                    'Lacak Surat Jalan',
                    style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
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
                            offset: Offset(2, 4))
                      ]),
                  height: 185,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin:
                              EdgeInsets.only(bottom: 10, top: 20, left: 30),
                          child: Text(
                            'No.Surat Jalan',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 18, color: Colors.black),
                          )),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: 5,
                          left: 20,
                        ),
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
                              key: sjSearchKey,
                              child: Container(
                                margin: EdgeInsets.only(left: 20, bottom: 10),
                                width: 300,
                                // color: Colors.blue,
                                child: TextFormField(
                                  validator: RequiredValidator(
                                      errorText: ' Please Enter'),
                                  controller: noSjController,
                                  style: GoogleFonts.plusJakartaSans(
                                      color: Colors.black, fontSize: 18),
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
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
                            keyboardUtils.dissmissKeyboard(context);
                            setState(() {
                              barcodeSj = noSjController.text;
                            });
                            trackBySuratJalan(barcodeSj);
                            // if (sjKey.currentState!.validate()) {
                            //   setState(() {
                            //     isLoading = true;
                            //     _visible = true;
                            //   });
                            //   await Future.delayed(const Duration(seconds: 3));

                            //   setState(() {
                            //     isLoading = false;
                            //   });
                            // }
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
                  margin: EdgeInsets.only(top: 390),
                  child: isLoading
                      ? SpinKitThreeBounce(
                          color: Color.fromARGB(255, 210, 14, 0),
                          size: 50.0,
                        )
                      : AnimatedOpacity(
                          opacity: _visible ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 500),
                          child: TabBarView(controller: _controller, children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
                              child: ListView(children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 10, bottom: 10),
                                        child: Text(
                                          'No.Dokumen',
                                          style: GoogleFonts.plusJakartaSans(
                                              fontSize: 17),
                                        )),
                                    TextFieldSJ(noDocumentController)
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 10, bottom: 10),
                                        child: Text(
                                          'Tipe Dokumen',
                                          style: GoogleFonts.plusJakartaSans(
                                              fontSize: 17),
                                        )),
                                    TextFieldSJ(documentTypeController)
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 10, bottom: 10),
                                        child: Text(
                                          'Asal',
                                          style: GoogleFonts.plusJakartaSans(
                                              fontSize: 17),
                                        )),
                                    TextFieldSJ(originController)
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 10, bottom: 10),
                                        child: Text(
                                          'Tujuan',
                                          style: GoogleFonts.plusJakartaSans(
                                              fontSize: 17),
                                        )),
                                    TextFieldSJ(destinationController)
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 10, bottom: 10),
                                        child: Text(
                                          'Status',
                                          style: GoogleFonts.plusJakartaSans(
                                              fontSize: 17),
                                        )),
                                    TextFieldSJ(statusController)
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 10, bottom: 10),
                                        child: Text(
                                          'Petugas',
                                          style: GoogleFonts.plusJakartaSans(
                                              fontSize: 17),
                                        )),
                                    TextFieldSJ(driverNameController)
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 10, bottom: 10),
                                        child: Text(
                                          'No.Mobil',
                                          style: GoogleFonts.plusJakartaSans(
                                              fontSize: 17),
                                        )),
                                    TextFieldSJ(noVehicleController)
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 10, bottom: 10),
                                        child: Text(
                                          'Catatan',
                                          style: GoogleFonts.plusJakartaSans(
                                              fontSize: 17),
                                        )),
                                    Form(
                                      key: sjKey,
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 30),
                                        height: 120,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: TextFormField(
                                          readOnly: true,
                                          validator: RequiredValidator(
                                              errorText: ' Please Enter'),
                                          controller: remarkController,
                                          cursorColor: Colors.black,
                                          maxLines: 7,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            filled: true,
                                          ),
                                        ),
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
                                  stepperData: stepperSJ,
                                  stepAvatar: (_, data) {
                                    final stepData = data as StepperItemData;
                                    return PreferredSize(
                                      preferredSize: const Size.fromRadius(20),
                                      child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              'assets/sj_lacak_lacakpaket.png')),
                                    );
                                  },
                                  stepContentWidget: (_, data) {
                                    final stepData = data as StepperItemData;
                                    return Container(
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              179, 241, 241, 241),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.all(
                                        10,
                                      ),
                                      child: ListTile(
                                        contentPadding: const EdgeInsets.all(7),
                                        title: Container(
                                          margin: EdgeInsets.only(top: 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Status',
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 195, 0, 0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Center(
                                                    child: Text(
                                                      stepData.content[
                                                              'status'] ??
                                                          '',
                                                      style: GoogleFonts
                                                          .plusJakartaSans(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        subtitle: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Expanded(
                                                  child: Icon(
                                                    IconlyLight.calendar,
                                                    color: Colors.red,
                                                    size: 25,
                                                  ),
                                                ),
                                                Container(
                                                  width: 90,
                                                  child: Text(
                                                    'Tanggal',
                                                    style: GoogleFonts
                                                        .plusJakartaSans(
                                                            fontSize: 17,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    87,
                                                                    87,
                                                                    87)),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 7,
                                                  child: Text(
                                                    ':' +
                                                            stepData.content[
                                                                'date'] ??
                                                        '',
                                                    style: GoogleFonts
                                                        .plusJakartaSans(
                                                            fontSize: 17,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    87,
                                                                    87,
                                                                    87)),
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
                                                  child: Icon(
                                                    IconlyLight.location,
                                                    color: Colors.red,
                                                    size: 25,
                                                  ),
                                                ),
                                                Container(
                                                  width: 90,
                                                  child: Text(
                                                    'Lokasi',
                                                    style: GoogleFonts
                                                        .plusJakartaSans(
                                                            fontSize: 17,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    87,
                                                                    87,
                                                                    87)),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 7,
                                                  child: Text(
                                                    ':' +
                                                            stepData.content[
                                                                'site'] ??
                                                        '',
                                                    style: GoogleFonts
                                                        .plusJakartaSans(
                                                            fontSize: 17,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    87,
                                                                    87,
                                                                    87)),
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
                                                  child: Icon(
                                                    IconlyLight.paper,
                                                    color: Colors.red,
                                                    size: 25,
                                                  ),
                                                ),
                                                Container(
                                                  width: 90,
                                                  child: Text(
                                                    'Deskripsi',
                                                    style: GoogleFonts
                                                        .plusJakartaSans(
                                                            fontSize: 17,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    87,
                                                                    87,
                                                                    87)),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 7,
                                                  child: Text(
                                                    ':' +
                                                            stepData.content[
                                                                'description'] ??
                                                        '',
                                                    style: GoogleFonts
                                                        .plusJakartaSans(
                                                            fontSize: 17,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    87,
                                                                    87,
                                                                    87)),
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
                                                  child: Icon(
                                                    IconlyLight.document,
                                                    color: Colors.red,
                                                    size: 25,
                                                  ),
                                                ),
                                                Container(
                                                  width: 90,
                                                  child: Text(
                                                    'Note',
                                                    style: GoogleFonts
                                                        .plusJakartaSans(
                                                            fontSize: 17,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    87,
                                                                    87,
                                                                    87)),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 7,
                                                  child: Text(
                                                    ':' +
                                                            stepData.content[
                                                                'remark'] ??
                                                        '',
                                                    style: GoogleFonts
                                                        .plusJakartaSans(
                                                            fontSize: 17,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    87,
                                                                    87,
                                                                    87)),
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
                                                  child: Icon(
                                                    IconlyLight.profile,
                                                    color: Colors.red,
                                                    size: 25,
                                                  ),
                                                ),
                                                Container(
                                                  width: 90,
                                                  child: Text(
                                                    'Petugas',
                                                    style: GoogleFonts
                                                        .plusJakartaSans(
                                                            fontSize: 17,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    87,
                                                                    87,
                                                                    87)),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 7,
                                                  child: Text(
                                                    ':' +
                                                            stepData.content[
                                                                'pic'] ??
                                                        '',
                                                    style: GoogleFonts
                                                        .plusJakartaSans(
                                                            fontSize: 17,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    87,
                                                                    87,
                                                                    87)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
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
                  margin: EdgeInsets.only(
                      top: 345, left: 20, right: 20, bottom: 30),
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
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                            child: Text(
                          'Surat Jalan',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 18, color: Colors.white),
                        )),
                      ),
                      MaterialButton(
                        // color: Colors.green,
                        minWidth: 5,
                        onPressed: () {
                          if (_controller.index == 0) {
                            print(_controller.index);
                            setState(() {
                              turns += 1 / 2;
                              _controller.animateTo(_controller.index + 1);
                              print(_controller.index);
                            });
                          } else {
                            print(_controller.index);
                            setState(() {
                              turns += 1 / 2;
                              _controller.animateTo(_controller.index - 1);
                              print(_controller.index);
                            });
                          }
                        },
                        child: AnimatedRotation(
                          turns: turns,
                          duration: Duration(milliseconds: 400),
                          child: Icon(
                            Icons.swap_horiz_rounded,
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
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                            child: Text(
                          'Lacak Lokasi',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 18, color: Colors.white),
                        )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
