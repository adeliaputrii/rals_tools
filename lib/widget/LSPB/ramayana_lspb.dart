part of 'import.dart';

class RamayanaLspb extends StatefulWidget {
  const RamayanaLspb({super.key});

  @override
  State<RamayanaLspb> createState() => _RamayanaLspbState();
}

class _RamayanaLspbState extends State<RamayanaLspb> {
  TextEditingController _controllerNoDoc = TextEditingController();
  TextEditingController _controllerErorQty = TextEditingController();
  late PopUpWidget popUpWidget;
  late LspbCubit lspbCubit;
  late LoginCubit loginCubit;
  final urlApi = '${tipeurl}${basePath.api_get_type_doc}';
  String? token;
  UserData userData = UserData();

  bool typeDoc = false;
  // String filtered = 'All';
  String? typeDocument;
  String? _chosenValue = 'All';

  Future<void> scanBarcodeScan(
    TextEditingController controller,
  ) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      if (barcodeScanRes == '-1') {
        popUpWidget.showPopUpError(notFound, 'Barcode tidak terdeteksi');
      } else {
        controller.text = barcodeScanRes;
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
      if (!mounted) return;
      setState(() {
        controller.text = barcodeScanRes;
      });
    }
  }

  

bool isLetter(String character) {
  return RegExp(r'[A-Za-z]').hasMatch(character);
} 

String store() {
  String storeCode = userData.getUserToko();
  if (storeCode.startsWith('R') && storeCode[1] != '0' && !isLetter(storeCode[1]) && storeCode.length < 4) {
    return storeCode.replaceFirst('R', 'R0');
  }
  if (storeCode.startsWith('R') && storeCode.length == 3) {
    return storeCode.replaceFirst('R', 'R0');
  }
  return storeCode;
}

  getView() async {
    token = await SharedPref.getToken();
    lspbCubit.getViewResquest(token ?? '',  _controllerNoDoc.text, userData.getUsername7(), store(),);
  }

  getTypeDocument() async {
    token = await SharedPref.getToken();
    lspbCubit.getTypeDoc(token ?? '', _controllerNoDoc.text, userData.getUsername7());
  }

  Future<void> refreshWidget() async {
   getView();
  }

  submitPressed() async {
    final requestBody = LspbFormBody(
      scan_dokumen: _controllerNoDoc.text,
      user: userData.getUsername7(),
      store: store(),
      error_qty: _controllerErorQty.text);
    token = await SharedPref.getToken();
    lspbCubit.postFormLspb(token ?? '', requestBody);
  }

  @override
  void initState() {
    super.initState();
    popUpWidget = PopUpWidget(context);
    lspbCubit = context.read<LspbCubit>();
    loginCubit = context.read<LoginCubit>();
    getView();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: baseColor.primaryColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Ramayana(),
                  ),
                  (Route<dynamic> route) => false);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            )),
        centerTitle: true,
        title: Text(
          'Request LSPB',
          style: GoogleFonts.plusJakartaSans(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),
        ),
      ),
      body: LiquidPullToRefresh(
        color: baseColor.primaryColor,
        onRefresh: refreshWidget,
        showChildOpacityTransition: false,
        child: ListView(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: baseColor.primaryColor),
                      height: typeDoc ? screenHeight / 5.5 : screenHeight / 9,
                      child: BlocListener<LspbCubit, LspbState>(
                        listener: (context, state) {
                          if (state is LspbGetTypeSuccess) {
                            if (state.response.data!.dataGoldDn!.isEmpty) {
                              popUpWidget.showPopUpError(
                                  'Failed', 'No Document not found');
                              getView();
                              
                            } else {
                              getView();
                              setState(() {
                                typeDoc = true;
                                typeDocument =
                                    state.response.data!.dataGoldDn!.first.tipe;
                              });
                              loginCubit.createLog(baseParam.logLspPage, baseParam.logGetTypeSucc, urlApi);
                            }
                          }
                          if (state is LspbSuccess) {
                            loginCubit.createLog(baseParam.logLspPage, '${baseParam.logInputLspb}${_controllerNoDoc.text}', urlApi);
                            getView();
                            popUpWidget.showPopupSucces(
                                'Success', '${state.response.message}');
                            setState(() {
                              getView();
                              typeDoc = false;
                              typeDocument = null;
                              _controllerNoDoc.clear();
                              _controllerErorQty.clear();
                            });
                          }
                          if (state is LspbFailure) {
                            popUpWidget.showPopUpError('Failed', '${state.message}');
                            getView();
                            loginCubit.createLog(baseParam.logLspPage, state.message, urlApi);
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 55,
                                  margin: EdgeInsets.only(
                                    top: 10,
                                    left: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  width: screenWidth / 1.3,
                                  child: TextFormField(
                                    controller: _controllerNoDoc,
                                    style: GoogleFonts.plusJakartaSans(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      hintText: 'Scan or Write No. Document here',
                                      hintStyle: GoogleFonts.plusJakartaSans(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          scanBarcodeScan(_controllerNoDoc);
                                        },
                                        icon: Icon(
                                          Icons.qr_code_outlined,
                                          color: baseColor.primaryColor,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                        borderSide: BorderSide(
                                            color: Colors.white70, width: 1.5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                        borderSide: BorderSide(
                                            color: Colors.white70, width: 1.5),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                        borderSide: BorderSide(
                                            color: Colors.white70, width: 1.5),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                        borderSide: BorderSide(
                                            color: Colors.white70, width: 1.5),
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    MaterialButton(
                                      padding: EdgeInsets.only(top: 10, right: 20),
                                      minWidth: 10,
                                      onPressed: () async {
                                        setState(() {
                                          typeDoc = false;
                                          _controllerErorQty.clear();
                                        });
                                        if (_controllerNoDoc.text.isEmpty) {
                                          popUpWidget.showPopUpError(
                                              'Please Enter', 'No Document is Empty');
                                        } else {
                                          getTypeDocument();
                                        }
                                      },
                                      child: CircleAvatar(
                                        radius: 27,
                                        child: Icon(
                                          IconlyLight.search,
                                          color: baseColor.primaryColor,
                                          size: 28,
                                        ),
                                        backgroundColor: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Search',
                                      style: GoogleFonts.plusJakartaSans(
                                          fontSize: 15, color: Colors.white),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            typeDoc
                                ? Container(
                                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: screenWidth / 2.8,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: TextFormField(
                                              readOnly: true,
                                              style: GoogleFonts.plusJakartaSans(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                              decoration: InputDecoration(
                                                hintText: typeDocument,
                                                hintStyle:
                                                    GoogleFonts.plusJakartaSans(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500),
                                                prefixIcon: Icon(
                                                  IconlyLight.paper,
                                                  color: baseColor.primaryColor,
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20.0),
                                                  borderSide: BorderSide(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  borderSide: BorderSide(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  borderSide: BorderSide(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  borderSide: BorderSide(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          Container(
                                            width: screenWidth / 2.9,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.white),
                                            child: TextFormField(
                                              controller: _controllerErorQty,
                                              style: GoogleFonts.plusJakartaSans(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                              decoration: InputDecoration(
                                                hintText: 'Selisih SKU',
                                                hintStyle:
                                                    GoogleFonts.plusJakartaSans(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                ),
                                                prefixIcon: Icon(IconlyLight.chart,
                                                    color: baseColor.primaryColor),
                                                enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  borderSide: BorderSide(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  borderSide: BorderSide(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  borderSide: BorderSide(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  borderSide: BorderSide(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 10, right: 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                MaterialButton(
                                                  minWidth: 10,
                                                  onPressed: () async {
                                                    FocusScope.of(context).unfocus();
                                                    submitPressed();
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 25,
                                                    child: Icon(
                                                      Icons.add,
                                                      color: baseColor.primaryColor,
                                                      size: 30,
                                                    ),
                                                    backgroundColor: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  'Submit',
                                                  style: GoogleFonts.plusJakartaSans(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]))
                                : SizedBox()
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'List Request LSPB',
                            style: GoogleFonts.plusJakartaSans(
                              color: baseColor.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                IconlyLight.timeCircle,
                                color: Color.fromARGB(255, 224, 117, 110),
                              ),
                              SizedBox(width: 5),
                              Text(
                                '60 hari',
                                style: GoogleFonts.plusJakartaSans(
                                  color: const Color.fromARGB(255, 110, 107, 107),
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20, bottom: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text('Filter By Type Doc',
                                      style: GoogleFonts.plusJakartaSans(
                                        color: baseColor.primaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Container(
                                    height: 35,
                                    width: 120,
                                     margin: EdgeInsets.only(bottom: 10, right: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Color.fromARGB(230, 255, 230, 230),
                                      ),
                                      child: Center(
                                        child: DropdownButton<String>(
                                          value: _chosenValue,
                                          style: GoogleFonts.plusJakartaSans(
                                            color: baseColor.primaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                          iconEnabledColor:baseColor.primaryColor,
                                          items: <String>[
                                            'All',
                                            'DN',
                                            'TR',
                                            'SP',
                                            'RAT',
                                          ].map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value,style: GoogleFonts.plusJakartaSans(
                                            color: baseColor.primaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),),
                                            );
                                          }).toList(),
                                          onChanged: (String? value) {
                                            setState(() {
                                              _chosenValue = value!;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 1,
                                  width: screenWidth / 1.1,
                                  color: baseColor.primaryColor,
                                ),
                              ],
                            ),
                          ),
                          BlocBuilder<LspbCubit, LspbState>(
                            builder: (context, state) {
                              if (state is LspbLoading) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 200),
                                  child: Center(
                                    child: AppWidget().LoadingWidget(),
                                  ),
                                );
                              }
                              if (state is LspbViewSuccess) {
                              if (state.response.data!.isEmpty) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 200),
                                  child: Center(child: Text('No Data Available',
                                  style: GoogleFonts.plusJakartaSans(
                                    color: baseColor.primaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                                  )),
                                );
                              } else {
                              final filteredList = _chosenValue != 'All'
                              ? state.response.data!.where((item) => item.typeDoc!.contains(_chosenValue!)).toList()
                              : state.response.data!;
                              if (filteredList.length == 0) {
                              return Padding(
                                  padding: const EdgeInsets.only(top: 200),
                                  child: Center(child: Text('No Data Available',
                                  style: GoogleFonts.plusJakartaSans(
                                    color: baseColor.primaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                                  )),
                              );
                              } else {
                              return ListView.builder(
                                primary: false,
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 
                                  _chosenValue == 'All'
                                  ?
                                  state.response.data?.length
                                  :
                                  state.response.data!
                                  .where((item) => item.typeDoc!.contains(_chosenValue!) )
                                  .length,
                                itemBuilder: (context, index) {
                                  final item = filteredList[index];
                                  
                                  return 
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 20, 10),
                                    decoration: BoxDecoration(
                                    color: Color.fromARGB(230, 231, 231, 231),
                                    borderRadius: BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(8),
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: getImageForType('${item.status}')
                                            )
                                          )
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10, left: 5),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    'No Doc : ${item.noDoc}',
                                                    style: GoogleFonts.plusJakartaSans(
                                                        color: baseColor.primaryColor,
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    width: 50,
                                                  ),
                                                  item.lspbNo == null
                                                  ?
                                                  SizedBox.shrink()
                                                  :
                                                   Text(
                                                    'No LSPB : ${item.lspbNo}',
                                                    style: GoogleFonts.plusJakartaSans(
                                                        color: baseColor.primaryColor,
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w600),
                                                                                                   ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 8),
                                                child: Row(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          IconlyLight.paper,
                                                          color: baseColor.primaryColor,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          '${item.typeDoc}',
                                                          style:
                                                              GoogleFonts.plusJakartaSans(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          IconlyLight.chart,
                                                          color: baseColor.primaryColor,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          '${item.jmlSku}',
                                                          style:
                                                              GoogleFonts.plusJakartaSans(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          IconlyLight.calendar,
                                                          color: baseColor.primaryColor,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          '${item.dateInsert}',
                                                          style:
                                                              GoogleFonts.plusJakartaSans(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                            ),
                                            item.tglRcv == null
                                            ?
                                            SizedBox.shrink() 
                                            :
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8, bottom: 5),
                                              child: Row(
                                                  children: [
                                                    Icon(
                                                      IconlyLight.calendar,
                                                      color: baseColor.primaryColor,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                  Text(
                                                    'Date RCV : ${item.tglRcv}',
                                                    style: GoogleFonts.plusJakartaSans(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),  
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }
                              );
                              }
                            }
                            }
                            return Container();
                          }
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  ImageProvider<Object> getImageForType(String type)  {
    print('type :${type}');
    switch (type) {
    case 'git':
      return AssetImage('assets/lspb_git.png');
    case 'rcv':
      return AssetImage('assets/lspb_rcv.png');
    case 'expired':
      return AssetImage('assets/lspb_exp.png');
    default:
      return AssetImage('assets/lspb_default.png'); // Gambar default jika type tidak sesuai
  }
}
}

