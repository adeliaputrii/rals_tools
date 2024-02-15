part of 'import.dart';

class RamayanaSuratJalanScan extends StatefulWidget {
  const RamayanaSuratJalanScan({super.key});

  @override
  State<RamayanaSuratJalanScan> createState() => _RamayanaSuratJalanScanState();
}

class _RamayanaSuratJalanScanState extends State<RamayanaSuratJalanScan> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeySearch = GlobalKey<FormState>();
  TextEditingController remarkController = TextEditingController();
  TextEditingController noSjController = TextEditingController();
  TextEditingController noDocumentController = TextEditingController();
  TextEditingController documentTypeController = TextEditingController();
  TextEditingController noVehicleController = TextEditingController();
  TextEditingController colyAvailableController = TextEditingController();
  TextEditingController colyMissingController = TextEditingController();
  TextEditingController driverNameController = TextEditingController();
  TextEditingController originController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController lspbController = TextEditingController();

  List<SuratJalanModel> sjModel = [];
  List<TextEditingController> _controller = [];
  List<SuratJalanKoliModel> colyList = [];

  List<String> noColyMissing = [];

  var noSj = "";
  var description = "";
  bool isLoading = false;
  bool _visible = false;
  bool buttonStoreline = false;
  bool buttonRegular = false;
  bool buttonSupplier = false;
  bool showMissingColy = false;
  bool _visibleBottom = false;
  late SuratJalanCubit sjCubit;
  late LoginCubit logCubit;
  late PopUpWidget popUp;
  KeyboardUtils keyboardUtils = KeyboardUtils();
  int indexSj = 0;
  int receivedColyResponse = 0;
  int receivedColy = 0;
  int lspb = 0;

  @override
  void initState() {
    super.initState();
    popUp = PopUpWidget(context);
    sjCubit = context.read<SuratJalanCubit>();
    logCubit = context.read<LoginCubit>();
    _visible = false;
  }

  @override
  void dispose() {
    super.dispose();
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
  }

  Future<void> scanBarcodeScan() async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.BARCODE);
      if (barcodeScanRes == '-1') {
        popUp.showPopUpError(notFound, 'Barcode tidak terdeteksi');
        logCubit.createLog(baseParam.logInfoScanSJPage, 'Barcode tidak terdeteksi', basePath.api_tracking_scan);
      } else {
        logCubit.createLog(baseParam.logInfoScanSJPage, '${baseParam.logInfoScanDesc}${barcodeScanRes}', basePath.api_tracking_scan);
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

  void navigateTrackSJ() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
      return RamayanaSuratJalanLacak(
        noSJ: noSj,
      );
    }));
  }

  void chooseMissingColy() async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SJMissingColy(listColy: colyList, receivedColy: receivedColy, receivedColyResponse: receivedColyResponse);
    }));
    if (result != null) {
      noColyMissing.clear();
      noColyMissing.addAll(result);

      String resultSelected = noColyMissing.map((e) => e.toString()).join(',');
      colyMissingController.text = resultSelected;
    }
  }

  bool checkValidation() {
    if (colyAvailableController.text.isEmpty) {
      popUp.showPopUpWarning('Harap mengisi kolom mandatory!', 'Ok');
      return false;
    } else {
      if (receivedColy < receivedColyResponse && colyMissingController.text.isEmpty) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.warning,
          text: 'Harap mengisi kolom mandatory!',
          confirmBtnText: 'Ya',
          cancelBtnText: 'Tidak',
          confirmBtnColor: Colors.green,
          onConfirmBtnTap: () {
            Navigator.pop(context);
          },
        );
        return false;
      }
    }

    return true;
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
            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.start,
      actionsPadding: EdgeInsets.only(bottom: 20),
    );
    showCupertinoModalPopup(context: context, builder: (context) => popup1);
  }

  Widget _buttonRegular() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Container(
            height: 100,
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                if (checkValidation()) {
                  postTracking(1);
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(baseColor.primaryColor),
                side: MaterialStateProperty.all(
                  BorderSide(
                    color: baseColor.primaryColor, // Set the border color to red
                    width: 2.0, // Set the border width
                  ),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              child: Text('Simpan', style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buttonSupplier() {
    return Container(
      height: 100,
      child: OutlinedButton(
        onPressed: () {
          if (checkValidation()) {
            postTracking(3);
          }
        },
        style: ButtonStyle(
          side: MaterialStateProperty.all(
            BorderSide(
              color: baseColor.primaryColor, // Set the border color to red
              width: 2.0, // Set the border width
            ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
        child: Text('Supplier', style: GoogleFonts.plusJakartaSans(fontSize: 18, color: baseColor.primaryColor)),
      ),
    );
  }

  Widget _buttonStoreline() {
    return Container(
      height: 100,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          if (checkValidation()) {
            postTracking(2);
          }
        },
        style: ButtonStyle(
          side: MaterialStateProperty.all(
            BorderSide(
              color: baseColor.primaryColor, // Set the border color to red
              width: 2.0, // Set the border width
            ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
        child: Text('Storeline', style: GoogleFonts.plusJakartaSans(fontSize: 18, color: baseColor.primaryColor)),
      ),
    );
  }

  Widget buttonLogic() {
    if (buttonSupplier || buttonStoreline && buttonRegular) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 100,
            width: 200,
            child: OutlinedButton(
              onPressed: () {
                if (checkValidation()) {
                  postTracking(1);
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(baseColor.primaryColor),
                side: MaterialStateProperty.all(
                  BorderSide(
                    color: baseColor.primaryColor, // Set the border color to red
                    width: 2.0, // Set the border width
                  ),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              child: Text('Simpan', style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.white)),
            ),
          ),
          Container(
            height: 100,
            width: 200,
            child: OutlinedButton(
              onPressed: () {
                if (checkValidation()) {
                  if (buttonStoreline) {
                    postTracking(2);
                  } else {
                    postTracking(3);
                  }
                }
              },
              style: ButtonStyle(
                side: MaterialStateProperty.all(
                  BorderSide(
                    color: baseColor.primaryColor, // Set the border color to red
                    width: 2.0, // Set the border width
                  ),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              child:
                  Text(buttonStoreline ? 'Storeline' : 'Supplier', style: GoogleFonts.plusJakartaSans(fontSize: 18, color: baseColor.primaryColor)),
            ),
          )
        ],
      );
    }

    if (buttonStoreline && !buttonSupplier && !buttonRegular) {
      return _buttonStoreline();
    }
    if (buttonSupplier && !buttonStoreline && !buttonRegular) {
      return _buttonSupplier();
    }
    return _buttonRegular();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        if (true) {
          Navigator.pop(context);
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: baseColor.primaryColor,
          title: Text(
            'Form Surat Jalan',
            style: GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
          ),
          elevation: 0,
        ),
        resizeToAvoidBottomInset: true,
        body: BlocListener<SuratJalanCubit, SuratJalanState>(
          listener: (context, state) {
            if (state is SuratJalanSuccess) {
              setState(() {
                isLoading = false;
                _visible = true;
              });
              if (state.response.data.toString().isNotEmpty) {
                colyList.clear();
                documentTypeController.text = state.response.data!.detailSj?.documentType ?? baseParam.dash;
                originController.text = state.response.data?.detailSj?.origin ?? baseParam.dash;
                destinationController.text = state.response.data?.detailSj?.destination ?? baseParam.dash;
                driverNameController.text = state.response.data?.detailSj?.driverName ?? baseParam.dash;
                noVehicleController.text = state.response.data?.detailSj?.noVehicle ?? baseParam.dash;
                noSjController.text = state.response.data?.detailSj?.noSj ?? baseParam.dash;
                noDocumentController.text = state.response.data?.detailSj?.noSj ?? baseParam.dash;
                statusController.text = state.response.data?.detailSj?.trackingStatus ?? baseParam.dash;
                receivedColyResponse = state.response.data?.detailSj?.actualKoli ?? 0;
                receivedColy = state.response.data?.detailSj?.actualKoli ?? 0;
                colyAvailableController..text = receivedColyResponse.toString();
                state.response.data?.detailSj?.listKoli?.forEach((element) {
                  final body = SuratJalanKoliModel(isChecked: false, nomor: element);
                  colyList.add(body);
                });

                setState(() {
                  buttonStoreline = state.response.data?.button?.storeline ?? false;
                  buttonRegular = state.response.data?.button?.regular ?? false;
                  buttonSupplier = state.response.data?.button?.receivedBySupplier ?? false;

                  if (buttonStoreline || buttonRegular || buttonSupplier) {
                    _visibleBottom = true;
                  } else {
                    _visibleBottom = false;
                  }
                });

                noSj = state.response.data?.detailSj?.noSj ?? '';
              }
            }
            if (state is SuratJalanLoading) {
              setState(() {
                isLoading = true;
                _visible = false;
              });
            }
            if (state is SuratJalanFailure) {
              setState(() {
                isLoading = false;
                _visible = false;
              });
              popUp.showPopUpError(notFound, state.message);
            }

            if (state is ScanSJSuccess) {
              setState(() {
                _visible = false;
              });
              popUp.showPopUpSuccess(trackSJSuccess, trackSJNavigate, navigateTrackSJ);
            }
            if (state is ScanSJFailure) {
              popUp.showPopUpError(failed, state.message);
            }
          },
          child: Stack(
            children: [
              Container(
                color: Color.fromARGB(255, 210, 14, 0),
              ),
              Container(
                margin: EdgeInsets.only(top: screenSize.height / 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                  color: Colors.white,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 30, right: 30),
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
                          baseParam.sjNoSuratJalan,
                          style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black),
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
                        onPressed: () {
                          keyboardUtils.dissmissKeyboard(context);
                          sjCubit.getScanTracking(noSjController.text.toString());
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
                margin: EdgeInsets.fromLTRB(30, screenSize.height / 3.5, 30, 0),
                // color: Colors.amber,
                child: isLoading
                    ? SpinKitThreeBounce(
                        color: Color.fromARGB(255, 210, 14, 0),
                        size: 50.0,
                      )
                    : AnimatedOpacity(
                        opacity: _visible ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 500),
                        child: ListView(shrinkWrap: true, children: [
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
                            children: [
                              Row(children: [
                                TextLabelMandatory(baseParam.sjKoliDiterima),
                                Container(
                                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    child: Text(
                                      'maks. ${receivedColyResponse}',
                                      style: GoogleFonts.plusJakartaSans(fontSize: 15, color: Color.fromARGB(255, 210, 14, 0)),
                                    )),
                              ]),
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                height: 50,
                                child: TextField(
                                  readOnly: false,
                                  keyboardType: TextInputType.number,
                                  controller: colyAvailableController,
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
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      receivedColy = int.parse(value);
                                      lspb = (receivedColy - receivedColyResponse).toInt();
                                      lspbController..text = lspb.toString();
                                      if (receivedColy < receivedColyResponse) {
                                        setState(() {
                                          showMissingColy = true;
                                        });
                                      } else {
                                        setState(() {
                                          showMissingColy = false;
                                        });
                                      }
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                          Visibility(
                            visible: showMissingColy,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextLabelMandatory(baseParam.sjKoliHilang),
                                    Container(
                                        margin: EdgeInsets.only(left: 10, bottom: 10),
                                        child: GestureDetector(
                                          onTap: () {
                                            chooseMissingColy();
                                          },
                                          child: Text(
                                            'Pilih',
                                            style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Colors.blue),
                                          ),
                                        )),
                                  ],
                                ),
                                TextField(
                                  controller: colyMissingController,
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
                                  readOnly: true,
                                  maxLines: 10,
                                  minLines: 1,
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: receivedColy != receivedColyResponse,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [TextLabel(baseParam.sjLspb), TextFieldSJ(lspbController)],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextLabel(baseParam.sjCatatan),
                                Form(
                                  key: _formKey,
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 30),
                                    height: 120,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                    child: TextFormField(
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
                          ),
                        ]),
                      ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Visibility(
            visible: _visible && _visibleBottom,
            child: Container(
                height: 56.0, // Adjust the height as needed
                color: Colors.transparent, // Set the background color as needed
                child: BlocBuilder<SuratJalanCubit, SuratJalanState>(builder: (context, state) {
                  if (state is ScanSJLoading) {
                    return SpinKitThreeBounce(
                      color: Color.fromARGB(255, 210, 14, 0),
                      size: 50.0,
                    );
                  }
                  if (state is SuratJalanSuccess) {
                    buttonLogic();
                  }
                  return buttonLogic();
                })),
          ),
        ),
      ),
    );
  }

  postTracking(int type) {
    final body =
        TrackingSJBody(noSj: noSjController.text, remarks: remarkController.text, rcv_koli: receivedColy.toString(), missingKoli: noColyMissing);
    CoolAlert.show(
      context: context,
      type: CoolAlertType.confirm,
      text: 'Submit status pelacakan?',
      confirmBtnText: 'Ya',
      cancelBtnText: 'Tidak',
      confirmBtnColor: Colors.green,
      onConfirmBtnTap: () {
        switch (type) {
          case 1:
            sjCubit.postTrackingSJ(body, 1);
            debugPrint("submit");
            break;
          case 2:
            sjCubit.postTrackingSJ(body, 2);
            debugPrint("buttonStoreline");
            break;
          case 3:
            sjCubit.postTrackingSJ(body, 3);
            debugPrint('buttonSupplier');
            break;
        }
        Navigator.pop(context);
      },
    );
  }
}

Widget TextLabel(String text) {
  return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Text(
        text,
        style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Colors.grey[500]),
      ));
}

Widget TextLabelMandatory(String text) {
  return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Text(
            text,
            style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Colors.grey[500]),
          ),
          Text(
            '*',
            style: GoogleFonts.plusJakartaSans(fontSize: 14, color: Colors.red),
          ),
        ],
      ));
}

Widget TextFieldInputSJ(TextEditingController controller, bool typeAlphabet) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    height: 50,
    child: TextField(
      readOnly: false,
      keyboardType: typeAlphabet ? TextInputType.text : TextInputType.number,
      controller: controller,
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
  );
}

Widget TextFieldStatusSJ(TextEditingController controller, String status) {
  return Container(
    margin: EdgeInsets.only(left: 10, bottom: 10),
    height: 50,
    child: TextField(
      readOnly: true,
      controller: controller,
      style: TextStyle(color: getStatusColor(status), fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        border: InputBorder.none, // <-- Set border to none
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0,
            color: Color.fromARGB(255, 236, 236, 236),
          ), //<-- SEE HERE
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    ),
  );
}

Color? getStatusColor(String text) {
  if (text == 'PROCESS') {
    return Colors.yellow[800];
  }
  if (text == 'RECEIVED') {
    return Colors.green[500];
  }
  if (text == 'GIT') {
    return Colors.blue[500];
  }
  if (text == 'CLOSED') {
    return Colors.red[500];
  }
  return Colors.grey[500];
}

Widget TextFieldSJ(TextEditingController controller) {
  return Container(
    height: 50,
    margin: EdgeInsets.only(bottom: 10),
    child: TextField(
      readOnly: true,
      expands: false,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
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
  );
}
