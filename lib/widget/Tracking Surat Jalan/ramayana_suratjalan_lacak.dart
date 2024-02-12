part of 'import.dart';

class RamayanaSuratJalanLacak extends StatefulWidget {
  RamayanaSuratJalanLacak({super.key, this.noSJ});
  String? noSJ;

  @override
  State<RamayanaSuratJalanLacak> createState() => _RamayanaSuratJalanLacakState();
}

class _RamayanaSuratJalanLacakState extends State<RamayanaSuratJalanLacak> with SingleTickerProviderStateMixin {
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
  TextEditingController colyAvailableController = TextEditingController();

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
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
      if (barcodeScanRes == '-1') {
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
    remarkController.dispose();
    noSjController.dispose();
    noDocumentController.dispose();
    documentTypeController.dispose();
    noVehicleController.dispose();
    driverNameController.dispose();
    originController.dispose();
    destinationController.dispose();
    statusController.dispose();
    colyAvailableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        if (true) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
            return RamayanaSuratJalan();
          }));
          return true;
        }
      },
      child: BlocListener<SuratJalanCubit, SuratJalanState>(
          listener: (context, state) {
            if (state is ScanSJLoading) {
              stepperSJ.clear();
              setState(() {
                isLoading = true;
              });
            }

            if (state is SuratJalanSuccess) {
              loginCubit.createLog(baseParam.logInfoTrackSJPage, '${baseParam.logInfoScanSJSucc} No SJ ${barcodeSj}', apiUrl);
              setState(() {
                isLoading = false;
                _visible = true;
              });
              if (state.response.data.toString().isNotEmpty) {
                documentTypeController.text = state.response.data!.detailSj?.documentType ?? baseParam.dash;
                originController.text = state.response.data?.detailSj?.origin ?? baseParam.dash;
                destinationController.text = state.response.data?.detailSj?.destination ?? baseParam.dash;
                driverNameController.text = state.response.data?.detailSj?.driverName ?? baseParam.dash;
                noVehicleController.text = state.response.data?.detailSj?.noVehicle ?? baseParam.dash;
                noSjController.text = state.response.data?.detailSj?.noSj ?? baseParam.dash;
                noDocumentController.text = state.response.data?.detailSj?.noSj ?? baseParam.dash;
                statusController.text = state.response.data?.detailSj?.trackingStatus ?? baseParam.dash;
                colyAvailableController.text = state.response.data?.detailSj?.actualKoli?.toString() ?? '0';
              }
            }

            if (state is SuratJalanFailure) {
              setState(() {
                _visible = false;
                isLoading = false;
              });
              loginCubit.createLog(baseParam.logInfoTrackSJPage, '${baseParam.logInfoScanSJFail} No SJ ${noSjController..text}', apiUrl);
              popUp.showPopUpError(notFound, state.message);
            }
            if (state is TrackSJSuccess) {
              loginCubit.createLog(baseParam.logInfoTrackSJPage, '${baseParam.logInfoTrackSJSucc} No SJ ${barcodeSj}', apiUrl);

              int index = 0;
              final response = state.response.data;
              debugPrint(state.response.data!.first.remark);
              response!.forEach((element) {
                stepperSJ.add(StepperItemData(
                    id: "${index++}",
                    content: ({
                      'status': element.status,
                      'site': element.site,
                      'description': element.description != "null" ? element.description : "-",
                      'remark': element.remark,
                      'pic': element.pic,
                      'date': element.date,
                    })));
              });
            }

            if (state is TrackSJFailure) {
              loginCubit.createLog(
                  baseParam.logInfoTrackSJPage, '${baseParam.logInfoTrackSJFail} No SJ ${noSjController..text} ${state.message}', apiUrl);
            }
          },
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: baseColor.primaryColor,
                title: Text(
                  baseParam.sjTrackTitle,
                  style: GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
                ),
                elevation: 0,
              ),
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: Stack(
                children: [
                  Container(
                    color: Color.fromARGB(255, 210, 14, 0),
                    height: 220,
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                    decoration: BoxDecoration(color: Color.fromARGB(255, 254, 252, 252), borderRadius: BorderRadius.circular(25)),
                    height: 185,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(bottom: 10, top: 20, left: 30),
                            child: Text(
                              baseParam.sjNoSuratJalan,
                              style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black),
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
                                    validator: RequiredValidator(errorText: ' Please Enter'),
                                    controller: noSjController,
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
                            onPressed: () async {
                              keyboardUtils.dissmissKeyboard(context);
                              setState(() {
                                barcodeSj = noSjController.text;
                              });
                              trackBySuratJalan(barcodeSj);
                            },
                            child: Text(
                              'Cari',
                              style: GoogleFonts.plusJakartaSans(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: screenSize.height / 3.2),
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
                                      TextLabel(baseParam.sjStatus),
                                      TextFieldStatusSJ(statusController, statusController.text),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [TextLabel(baseParam.sjNoDokumen), TextFieldSJ(noDocumentController)],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [TextLabel(baseParam.sjTipeDokumen), TextFieldSJ(documentTypeController)],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [TextLabel(baseParam.sjAsal), TextFieldSJ(originController)],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [TextLabel(baseParam.sjTujuan), TextFieldSJ(destinationController)],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [TextLabel(baseParam.sjPetugas), TextFieldSJ(driverNameController)],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [TextLabel(baseParam.sjNoMobil), TextFieldSJ(noVehicleController)],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [TextLabel(baseParam.sjKoliDiterima), TextFieldSJ(colyAvailableController)],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextLabel(baseParam.sjCatatan),
                                      Form(
                                        key: sjKey,
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 30),
                                          height: 120,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                          child: TextFormField(
                                            readOnly: true,
                                            validator: RequiredValidator(errorText: ' Please Enter'),
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
                                    child: stepperSJ.isEmpty
                                        ? Center(child: Text('Data Kosong', style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Colors.black)))
                                        : stepperListView(stepperSJ)),
                              ),
                            ]),
                          ),
                  ),
                  // -------------------------------------------------------------------------------------------------------------------------------
                  Container(
                    margin: EdgeInsets.only(top: screenSize.height / 4, left: 20, right: 20, bottom: 30),
                    // color: Colors.blue,
                    // height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 45,
                          width: 180,
                          decoration: BoxDecoration(color: _containerColorSj, borderRadius: BorderRadius.circular(30)),
                          child: Center(
                              child: Text(
                            'Surat Jalan',
                            style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.white),
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
                              });
                            } else {
                              setState(() {
                                turns += 1 / 2;
                                _controller.animateTo(_controller.index - 1);
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
                          decoration: BoxDecoration(color: _containerColorLacak, borderRadius: BorderRadius.circular(30)),
                          child: Center(
                              child: Text(
                            'Lacak Lokasi',
                            style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.white),
                          )),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
