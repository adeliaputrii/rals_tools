part of 'import.dart';

class RamayanaSo extends StatefulWidget {
  RamayanaSo({
    required this.location,
    required this.pos,
    required this.date,
    required this.posLocation,
    this.id,
    this.message,
    this.text
  });
  String? location;
  String? pos;
  String? date;
  String posLocation;
  int? id;
  bool? message;
  String? text;
  @override
  State<RamayanaSo> createState() => _RamayanaSoState();
}

class _RamayanaSoState extends State<RamayanaSo> {

  TextEditingController _controllerLocation = TextEditingController();
  TextEditingController _controllerSku = TextEditingController();
  TextEditingController _controllerJumlah = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final focus = FocusNode();
  final focus1 = FocusNode();

  late StockOpnameCubit soCubit;
  String? token;
  UserData userData = UserData();
  DbHelperStockOpname db = DbHelperStockOpname();
  DbSoSaveData dbSave = DbSoSaveData();
  DbSoGetData dbGet = DbSoGetData();
  DbSoGetData db1 = DbSoGetData();
  List<Map<String, dynamic>>? data = [];
  List<Data> dataItemsBody = [];
  List<Data> dataItems = [];
  List<ItemData> dataItemsLokal = [];
  List? listGet;
  // bool loading = false;

  String _location = '';
  bool canWrite = false;

  late PopUpWidget popUpWidget;

  popUpLocation() async {
    final result = await showCupertinoModalPopup(context: context, builder: (context) => SoPopup());
      setState(() {
      if (result != null) {
      setState(() {
        widget.posLocation = result['posLocation'];
        widget.pos = result['pos'];
        widget.date = result['date'];
        widget.location = result['location'];
        widget.id = result['id'];
        widget.message = result['message'];
        print(widget.date);
        print(widget.posLocation);
        print(widget.location);
        print(widget.pos);
        print(widget.id);
        print(widget.message);
        
      });
    }
      });
  }
  Future<void> scanBarcodeScan(
    TextEditingController controller,
    FocusNode focuss
  ) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.BARCODE);
      if (barcodeScanRes == '-1') {
        popUpWidget.showPopUpError(notFound, 'Barcode tidak terdeteksi');
      } else {
        controller.text = barcodeScanRes;
        FocusScope.of(context).requestFocus(focuss);
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
      if (!mounted) return;
      setState(() {
        controller.text = barcodeScanRes;
        FocusScope.of(context).requestFocus(focuss);
      });
    }
  }

  submitPressed() async {
    final requestBody = StockOpnameSubmitBody(
      quenic: '${parameter()}',
      data: [
      StockOpnameBody(
        pos: widget.pos,
        lokasi: widget.location,
        tanggal: widget.date,
        data: dataItems
      )
    ]);
    await dbGet.delete(widget.id ?? 1);
    print('body : $requestBody');
    final SharedPreferences pref = await SharedPreferences.getInstance();
    token = await SharedPref.getToken();
    soCubit.postResult(token ?? '', requestBody);
    
   
  }

 saveLokal() async {
   await dbSave.save(SoSaveDataModel(
    pos: '${widget.pos}',
    location: '${widget.location}',
    tanggal: '${widget.date}',
    data: dataItemsLokal,
  ));
  await dbGet.delete(widget.id!);
}

  Future<void> _getAllActivity() async {
    
    final SharedPreferences pref = await SharedPreferences.getInstance();
    token = await SharedPref.getToken();
    parameter();
    final body = StockOpnameGetBody(
      quenic: '${parameter()}'
    );
    soCubit.getPosLocation(
      token ?? '', body
    );

     if(widget.text != null) {
      popUpWidget.showPopupSucces('${widget.text}');
     setState(() {
       widget.text = null;
     });
     if (widget.message == true ){
      setState(() {
        dbSave.deleteAll();
        widget.message = false;
      });
     }
    } else {
      print(widget.message);
    }
    
    var list = await db.getAllFormat();
    listGet = await dbGet.getAllFormat();
    if (listGet != null ){
      for (var activity in listGet!) {
        if (activity['location'] == widget.location) {
        widget.id = activity['id'];
        }
        print('widget.id :${widget.id}');
      }
    }
    if (list != null) {
      final String columnId = 'id';
      final String columnIdGenerate = 'sku';
      final String columnDate = 'quantity';
      for (var activityy in list) {
        if(activityy[columnIdGenerate]!= null) {
          // _controllerLocation.text = '${widget.pos}${widget.location}';
        } 
      }
    }
   
  }

  Future getDatabase() async {
    try {
      _getAllActivity();
      return await db.getAllFormat();
    } catch (e) {
      print('Error fetching data: $e');
      return;
    }
  }

   Future <void>internetCheck() async {
    try {
    final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          submitPressed();
        });
      } 
    } catch (e) {
      setState((){
        saveLokal();
      dbGet.delete(widget.id!);
      _controllerLocation.clear();
      widget.posLocation = '';
      db.deleteAll();
      popUpWidget.showPopupSucces('Data Telah Disimpan secara Lokal', );
      
      });

    }
    print('CONTEROLLER : ${_controllerLocation.text}');
   }

   parameter() {
    Map<String, String> storeInfo = 
    {
      "username7": '${userData.getUsername7()}',
      "toko": '${userData.getUserToko()}'
    };
    print(storeInfo);
    String jsonString = jsonEncode(storeInfo);
     // Mengonversi string menjadi bytes
    Uint8List bytes = utf8.encode(jsonString);

      // Meng-encode bytes menjadi string Base64
      String base64String = base64Encode(bytes);
      print("Encoded: $base64String");
      return base64String;
   }

  
  @override
  void initState() {
    super.initState();
    popUpWidget = PopUpWidget(context);
    soCubit = context.read<StockOpnameCubit>();
    
    _getAllActivity();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: baseColor.primaryColor,
        leading: IconButton(
          onPressed: (){
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
              builder: (context) =>
              Ramayana(),
              ),
              (Route<dynamic> route) => false);
              }, 
          icon: Icon(Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          )
        ),
        centerTitle: true,
        title: Text('Stock Opname',
        style: GoogleFonts.plusJakartaSans(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w500
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  height: screenHeight/3.8,
                  margin: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(70)
                  ),
                  color: baseColor.primaryColor,
                  ),
                  child: Column(
                    children: [
                      Image.asset('assets/soanimasi.png'),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: screenHeight/3.8
                  ),
                  height: 100,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                  ),
                  color: baseColor.primaryColor,
                  ),
                ),
                Container(
                  width: screenWidth,
                  margin: EdgeInsets.only(
                    top: screenHeight/3.8
                  ),
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                  topRight: Radius.circular(70)
                  ),
                  color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Form Stock Opname',
                         style: GoogleFonts.plusJakartaSans(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                         ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20,bottom: 10),
                          child: Text('No. Pos Location',
                          style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black
                         ),
                          ),
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                          ),
                          minWidth: screenWidth,
                          height: 50,
                          color: Color.fromARGB(255, 223, 222, 222),
                          onPressed: () async{
                            final body = StockOpnameGetBody(
                            quenic: '${parameter()}'
                          );
                            soCubit.getPosLocation(
                              token ?? '', body
                              );
                            popUpLocation();
                            await _getAllActivity();
                          },
                          child: 
                          widget.posLocation == ''
                          ?
                          Text('Search Location',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: baseColor.primaryColor
                            ),
                          )
                          :
                          Text('${widget.posLocation}',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: baseColor.primaryColor
                            ),
                          ),
                          ),
                        widget.posLocation != ''
                        ?
                        Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.always,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20,bottom: 10),
                                child: Text('Input/Scan Pos Location',
                                style: GoogleFonts.plusJakartaSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black
                               ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 243, 241, 241),
                                borderRadius: BorderRadius.circular(15)
                                ),
                                child: TextFormField(
                                  controller: _controllerLocation,
                                  validator: (value) {
                                    if (value != '${widget.pos}${widget.location}') {
                                      return 'Location Number not match';
                                    }
                                  },
                                  onFieldSubmitted: (v){
                                    FocusScope.of(context).requestFocus(focus);
                                    if (_controllerLocation.text != '${widget.pos}${widget.location}') {
                                      setState(() {
                                        canWrite = true;
                                       });
                                    } else {
                                      canWrite = false;
                                    }
                                  },
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black
                                  ),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.location_pin,
                                    color: baseColor.primaryColor,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        scanBarcodeScan(_controllerLocation, focus);
                                      },
                                      icon: Icon(Icons.qr_code,
                                      color: baseColor.primaryColor,
                                      ),
                                      ),
                                    hintText: 'Scan or Write here',
                                    hintStyle: GoogleFonts.plusJakartaSans(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 1.5,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                        color: Colors.black, 
                                        width: 1.5,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                      color: baseColor.primaryColor, 
                                      width: 1.5,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                      color: baseColor.primaryColor, 
                                      width: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                                      child: Text('No. SKU',
                                      style: GoogleFonts.plusJakartaSans(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black
                                      ),),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 243, 241, 241),
                                      borderRadius: BorderRadius.circular(15)
                                      ),
                                      width: screenWidth/2,
                                      child: TextFormField(
                                        onTap: () {
                                          if (_controllerLocation.text != '${widget.pos}${widget.location}') {
                                            setState(() {
                                            popUpWidget.showPopUpError('Please Enter', 'Location Number not match');
                                            canWrite = true;
                                            });
                                          } else {
                                            canWrite = false;
                                          }
                                        },
                                        controller: _controllerSku,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        readOnly: canWrite,
                                        textInputAction: TextInputAction.next,
                                        focusNode: focus,
                                        onFieldSubmitted: (v){
                                          FocusScope.of(context).requestFocus(focus1);
                                        },
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black
                                        ),
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.local_offer,
                                          color: baseColor.primaryColor,
                                          ),
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              scanBarcodeScan(_controllerSku, focus1);
                                            },
                                            icon: Icon(Icons.qr_code,
                                            color: baseColor.primaryColor,
                                            ),
                                            ),
                                          hintText: 'Scan or Write here',
                                          hintStyle: GoogleFonts.plusJakartaSans(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15.0),
                                            borderSide: BorderSide(
                                              color: Colors.black, 
                                              width: 1.5,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15.0),
                                            borderSide: BorderSide(
                                              color: Colors.black, 
                                              width: 1.5, 
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15.0),
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 1.5, 
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                    padding: const EdgeInsets.only(top:17,bottom: 3),
                                      child: Text('Quantity',
                                      style: GoogleFonts.plusJakartaSans(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black
                                      )),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color: const Color.fromARGB(255, 243, 241, 241),
                                          ),
                                          width: screenWidth/4,
                                          child: TextFormField(
                                            onTap: () {
                                              if (_controllerLocation.text != '${widget.pos}${widget.location}') {
                                                setState(() {
                                                popUpWidget.showPopUpError('Please Enter', 'Location Number not match');
                                                canWrite = true;
                                                });
                                              } else {
                                                canWrite = false;
                                              }
                                            },
                                            controller: _controllerJumlah,
                                            keyboardType: TextInputType.number,
                                            readOnly: canWrite,
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter.digitsOnly
                                            ],
                                            textInputAction: TextInputAction.done,
                                            focusNode: focus1,
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black
                                            ),
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.shopping_cart,
                                              color: baseColor.primaryColor,
                                              ),
                                              hintText: '.....',
                                              hintStyle: GoogleFonts.plusJakartaSans(
                                                color: Colors.black,
                                                fontSize: 15,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(15.0),
                                                borderSide: BorderSide(
                                                  color: Colors.black, 
                                                  width: 1.5, 
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(15.0),
                                                borderSide: BorderSide(
                                                  color: Colors.black, // Set the border color
                                                  width: 1.5, // Set the border width
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                        children: [
                                          MaterialButton(
                                            minWidth: 10,
                                            onPressed: ()async{
                                              if(_controllerSku.text.isEmpty || _controllerJumlah.text.isEmpty) {
                                                popUpWidget.showPopUpError('Please Enter', 'Enter SKU & Quantity');
                                              } else {
                                              // _location = _controllerLocation.text;
                                              setState(() {
                                                location: '${widget.pos}${widget.location}';
                                                db.save(StockOpnameModel(
                                                sku: _controllerSku.text,
                                                qty: _controllerJumlah.text
                                              ));
                                              
                                              _controllerSku.clear();
                                              _controllerJumlah.clear();
                                              });
                                            }
                                            },
                                            child: CircleAvatar(
                                              child: Icon(Icons.add,
                                              color: Colors.white,),
                                              backgroundColor: baseColor.primaryColor,
                                            ),
                                          ),
                                          Text('Add SKU')
                                        ],
                                      )
                                      ],
                                    ),
                                  ],
                                  ),
                                ],
                              ),
                              Padding(
                              padding: const EdgeInsets.only(top: 20, bottom: 10),
                              child: Text('Summary',
                                 style: GoogleFonts.plusJakartaSans(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                                 ),
                                ),
                                ),
                              Container(
                              margin: EdgeInsets.only(bottom: 30),
                              width: screenWidth,
                              height: 
                              screenHeight/2,
                              decoration: BoxDecoration(
                              color: baseColor.grey,
                              borderRadius: BorderRadius.circular(20)
                              ),
                              child: 
                              FutureBuilder<dynamic>(
                              future: getDatabase(),
                              builder: (context, snapshot) {
                                data = snapshot.data;
                                if (data != null) {
                                  dataItems = data!.map((item) {
                                  return Data(
                                    sku: item['sku'],
                                    qty: item['quantity']
                                  );
                                }).toList();
                                dataItemsLokal = data!.map((item) {
                                  return ItemData(
                                    sku: item['sku'],
                                    qty: item['quantity']
                                  );
                                }).toList();
                                }
                                 if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  print('Error!!: ${snapshot.error}');
                                  return Center(child: Text('${snapshot.error}'));
                                } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                                  return Center(child: Text('No data available'));
                                } else {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                                        child: Text('Location ${widget.posLocation}',
                                        style: GoogleFonts.plusJakartaSans(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black
                                        ),
                                        ),
                                      ),
                                      Flexible(child: 
                                      ListView.builder(
                                        itemCount: data?.length,
                                        itemBuilder: (context, index) {
                                        return Container(
                                        width: screenWidth,
                                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.white
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                                  child: Text('${data?[index]['sku']}',
                                                  style: GoogleFonts.plusJakartaSans(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
                                                  child: Text('Jumlah ${data?[index]['quantity']}',
                                                  style: GoogleFonts.plusJakartaSans(
                                                    fontSize: 15,
                                                    color: Colors.black
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            IconButton(
                                              onPressed: (){
                                                setState(() {
                                                db.delete(data?[index]['id']);
                                                });
                                              }, 
                                              icon: Icon(Icons.close))
                                            ],
                                          ),
                                        );
                                        },)
                                      )
                                    ],
                                  );
                                 } 
                                 return Container();
                                }
                              ),
                              ),
                              MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                              ),
                              minWidth: screenWidth,
                              color: baseColor.primaryColor,
                              onPressed: () {
                                setState(() {
                                db.deleteAll();
                                });
                                popUpWidget.showPopupSuccess();
                              },
                              child: Text('CLEAR',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                                ),
                              ),
                              ),
                              BlocBuilder<StockOpnameCubit, StockOpnameState>(
                                builder: (context, state) {
                                  if (state is StockOpnameSubmitLoading) {
                                    return  AppWidget().LoadingWidget();
                                  }
                                  if (state is StockOpnameSubmitSuccess) {
                                      WidgetsBinding.instance.addPostFrameCallback((_) {
                                    print('message :${state.response.message}');
                                       popUpWidget.showPopupSucces(
                                      '${state.response.message}', );
                                        setState(() {
                                          widget.posLocation = '';
                                          db.deleteAll();
                                          _controllerLocation.clear();
                                          dbGet.deleteAll();
                                        });
                                    });
                                  }
                                  if (state is StockOpnameSubmitFailure) {
                                    WidgetsBinding.instance.addPostFrameCallback((_) {
                                       popUpWidget.showPopUpError(
                                      'Failed', '${state.message}'
                                    );
                                    });
                                  }
                                  return 
                                  MaterialButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                      ),
                                      minWidth: screenWidth,
                                      color: baseColor.primaryColor,
                                      onPressed: () async{
                                        
                                        setState(() {
                                          internetCheck();
                                          
                                        });
                                    },
                                      
                                      child: Text('SUBMIT',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                        ),
                                      ),
                                      );
                                }
                              )
                              
                            ],
                          ),
                        )
                        :
                        Container()
                      ],
                    ),
                  ),
                ),
              ],),
          ],
        ),
      ),
    );
  }
}
