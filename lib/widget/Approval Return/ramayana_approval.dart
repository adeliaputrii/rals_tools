part of 'import.dart';

class RamayanaApprovalReturn extends StatefulWidget {
  const RamayanaApprovalReturn({super.key});

  @override
  State<RamayanaApprovalReturn> createState() => _RamayanaApprovalReturnState();
}

class _RamayanaApprovalReturnState extends State<RamayanaApprovalReturn> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool? tanda;
  UserData userData = UserData();
  DateTime selectedDate = DateTime.now();
  String? _setDate;
  DateTime currentTime = DateTime.now();
  String formattedDate = "";
  String formattedDateUp = '';
  bool check1 = false;
  String oke = '';
  bool _visible = false;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String _udid = 'Unknown';
  var dio = Dio();
  List<Widget> bodyElements = [];
  int num = 0;
  List selectedData = [];
  List selectedData2 = [];
  var inputDate;
  var pos = '';
  var idKasir = '';
  var namaUser = '';
  var nominalReturn = '';
  late memberResponse.ApprovalReturnResponse responseData;
  late ApprovalReturnCubit cubit;
  final apiUrl = '${tipeurl}${basePath.api_membercard_customer}';
  var selected;
  final List<String> data = [
    'Fasihon',
    'Bazar',
  ];

  // fetchDataApproval({
  //   required String tanggal,
  //   required String tipe,

  //   //disini
  // }) async {
  //   print('tipe123xxx');
  //   print(tipe);
  //   print(tanggal);
  //   print('tipe123');

  //   ApprovalReturnModel.approvalreturn.clear();
  //   final responseku = await http
  //       .post(Uri.parse('${tipeurl}v1/returnvoid/tbl_my_transaksi_rtn'), body: {
  //     'tanggal': tanggal,
  //     'tipe': tipe,
  //     'store_code': '${userData.getUserToko()}',
  //   });

  //   var data = jsonDecode(responseku.body);

  //   if (data['status'] == 200) {
  //     print("API Success oooo");
  //     print(data);
  //     int count = data['data'].length;
  //     final Map<String, ApprovalReturnModel> profileMap = new Map();
  //     for (int i = 0; i < count; i++) {
  //       ApprovalReturnModel.approvalreturn
  //           .add(ApprovalReturnModel.fromjson(data['data'][i]));
  //     }
  //     ApprovalReturnModel.approvalreturn.forEach((element) {
  //       profileMap[element.no_trx] = element;
  //       ApprovalReturnModel.approvalreturn = profileMap.values.toList();
  //       print(ApprovalReturnModel.approvalreturn);
  //     });
  //     print('check length ${ApprovalReturnModel.approvalreturn.length}');

  //     print(data['data'].toString());

  //     if (ApprovalReturnModel.approvalreturn.length == 0) {
  //       AlertDialog popup1 = AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(20),
  //         ),

  //         // shadowColor: Colors.black,
  //         titlePadding: EdgeInsets.all(0),
  //         title: Container(
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(20),
  //                 topRight: Radius.circular(20),
  //               ),
  //             ),
  //             height: 170,
  //             width: 2000,
  //             child: Image.asset(
  //               'assets/omaigat.png',
  //             )),
  //         content: Container(
  //           margin: EdgeInsets.only(bottom: 10),
  //           height: 30,
  //           child: Center(
  //             child: Text(
  //               'NO DATA',
  //               style: TextStyle(
  //                   color: Colors.black,
  //                   fontSize: 15,
  //                   fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //         ),
  //         actionsAlignment: MainAxisAlignment.start,
  //         actionsPadding: EdgeInsets.only(bottom: 20),
  //       );
  //       showCupertinoModalPopup(context: context, builder: (context) => popup1);
  //     }
  //   } else {
  //     print('NO DATA');
  //   }

  //   setState(() {});
  // }

  approvalPressed() async {
      final body = ApprovalReturnBody(
        tipe: selected,
        tanggal: _dateController.text,
        store_code: '${userData.getUserToko()}'
          );
      cubit.getDataMember(idUser: body);
      print('pressed');
    }

  

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
              primarySwatch: Colors.grey,
              splashColor: Colors.white,
              textTheme: TextTheme(
                subtitle1: TextStyle(color: Colors.white),
                button: TextStyle(color: Colors.white),
              ),
              hintColor: Colors.white,
              colorScheme: ColorScheme.light(
                  primary: Color.fromARGB(255, 255, 17, 17),
                  onSecondary: Colors.yellow,
                  onPrimary: Colors.white,
                  surface: Colors.white,
                  onSurface: Colors.black,
                  secondary: Colors.red),
              dialogBackgroundColor: Colors.white,
            ),
            child: child ?? Text(""),
          );
        },
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));

    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
          formattedDateUp = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
  }

  @override
  void initState() {
    super.initState();
    _dateController.text = formattedDate;
    responseData = ApprovalReturnResponse();
    cubit = context.read<ApprovalReturnCubit>();
    // formattedDate = DateFormat.yMMMEd().format(currentTime);
    // fetchDataApproval(tanggal: _dateController.text, tipe: '');
    initPlatformState();
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
    return BlocListener<ApprovalReturnCubit, ApprovalReturnState>(
        listener: (context, state) {
          if (state is ApprovalReturnSuccess) {
            print('test print SUCCESS');
            responseData = state.response;
            setState(() {
              pos = state.response.data?.first.nocp.toString() ?? "0";
              idKasir = state.response.data?.first.idKasir.toString() ?? '-';
              namaUser = state.response.data?.first.namaKasir.toString() ?? '-';
              nominalReturn = state.response.data?.first.amaount.toString() ?? '-';
            });
            // loginCubit.createLog(baseParam.logInfoApprovalReturnPage,
            //     baseParam.logInfoApprovalReturnSucc, apiUrl);
          }
          if (state is ApprovalReturnFailure) {
            print('test print');
            print('state.message : ${state.message}');
          }
        },
      child: Scaffold(
        appBar: AppBar(
          //  leading: IconButton(
      
          //     onPressed: () {
          //       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
          //         return DefaultBottomBarController(child: RamayanaApprovalSubmenu());
          //       }), (route) => false);
          //       setState(() {
          //         bodyElements.clear();
          //         num = 0;
          //       });
          //     },
          //     icon: Icon(Icons.arrow_back),
      
          //   ),
          title: Text(
            'Approval Return',
            style: TextStyle(
                fontSize: 23,
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color.fromARGB(255, 255, 14, 14),
          elevation: 0,
          toolbarHeight: 80,
        ),
        body: ListView(
          children: [
            Stack(
              children: [
                Container(
                  color: Color.fromARGB(255, 255, 14, 14),
                  height: 70,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              (BoxShadow(
                                color: Color.fromARGB(255, 182, 182, 182),
                                blurRadius: 6,
                                offset: Offset(2, 5), // Shadow position
                              ))
                            ]),
                        height: 155,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 30),
                                      width: 100,
                                      // color: Colors.green,
                                      child: Text(
                                        'Tanggal',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Container(
                                      width: 20,
                                      // color: Colors.green,
                                      child: Text(
                                        ':',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Container(
                                      width: 150,
                                      // color: Colors.green,
                                      child: InkWell(
                                        onTap: () {
                                          _selectDate(context);
                                        },
                                        child: Container(
                                          width: 8,
                                          height: 20,
                                          margin: EdgeInsets.only(top: 15),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                                hintText: '${DateTime.now()}'),
                                            style: TextStyle(fontSize: 18),
                                            enabled: false,
                                            keyboardType: TextInputType.text,
                                            controller: _dateController,
                                            onSaved: (String? val) {
                                              _setDate = val;
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 255, 17, 17),
                                      borderRadius: BorderRadius.circular(20)),
                                  width: 100,
                                  child: Center(
                                      child: Text(
                                    '${userData.getUserToko()}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
            //                               Checkbox( //only check box
            //   value: check1, //unchecked
            //   onChanged: (bool? value){
            //       //value returned when checkbox is clicked
            //       setState(() {
            //           check1 = value;
            //       });
            //   }
            // ),
                                      ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 30),
                                  width: 100,
                                  // color: Colors.green,
                                  child: Text(
                                    'Toko',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Container(
                                  width: 20,
                                  // color: Colors.green,
                                  child: Text(
                                    ':',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Container(
                                  width: 150,
                                  // color: Colors.green,
                                  child: DropdownButton(
                                      value: selected,
                                      hint: Text(
                                        'Select Toko',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 175, 175, 175),
                                          fontSize: 18,
                                        ),
                                      ),
                                      onChanged: (value) {
                                        print(value);
                                        setState(() {
                                          selected = value;
                                        });
                                      },
                                      items: data
                                          .map(
                                            (e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(
                                                e,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          )
                                          .toList()),
                                )
                              ],
                            ),
                          //  BlocListener<ApprovalReturnCubit, ApprovalReturnState>(
                          //     listener: (context, state)  {
                          //       if(state is ApprovalReturnSuccess ){
                          //         debugPrint('state approval'+state.response.toString());
                          //       }
                          //     },child: Text('Test'),),
                            Container(
                                margin: EdgeInsets.fromLTRB(150, 0, 150, 0),
                                child: MaterialButton(
                                    padding: EdgeInsets.symmetric(horizontal: 50),
                                    height: 30,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                      'Search',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    color: Color.fromARGB(255, 255, 17, 17),
                                    onPressed: () async {
                                      approvalPressed();
                                      // fetchDataApproval(
                                      //     tanggal: _dateController.text,
                                      //     tipe: selected);
                                      
                                      setState(() {
                                        // visible();
                                        // _visible = true;
                                        selected == 'Fasihon' || selected == 'Bazar'
                                            ? _visible = true
                                            : _visible = false;
                                        print(_dateController.text);
                                        print(selected);
                                      });
                                    }))
                          ],
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                          width: 10000,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                (BoxShadow(
                                  color: Color.fromARGB(255, 182, 182, 182),
                                  blurRadius: 6,
                                  offset: Offset(2, 5), // Shadow position
                                ))
                              ]),
                          height: 600,
                          child: AnimatedOpacity(
                            opacity: _visible ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 500),
                            child: Container(
                              height: 600,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child:
                                BlocBuilder<ApprovalReturnCubit, ApprovalReturnState>(
                                  builder: (context, state){
                                    if (state is ApprovalReturnLoading) {
                                      print('loading');
                                    return SpinKitThreeBounce(
                                      color: Color.fromARGB(255, 230, 0, 0),
                                      size: 50.0,
                                    );
                                  }
                                    if (state is ApprovalReturnSuccess){
                                      print('success');
                                      return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: state.response.data!.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          return
                                
                                  DataTable(
                                      showCheckboxColumn: true,
                                      sortAscending: true,
                                      columnSpacing: 40.0,
                                      columns: [
                                        DataColumn(
                                            label: Text('',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700))),
                                        DataColumn(
                                            label: Text('POS',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700))),
                                        DataColumn(
                                            label: Text('ID USER',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700))),
                                        DataColumn(
                                            label: Text('NAMA USER',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700))),
                                        DataColumn(
                                            label: Text('NOMINAL RETURN',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700))),
                                      ],
                                      rows: ApprovalReturnModel.approvalreturn
                                          .map((e) => 
                                          DataRow(
                                                cells: [
                                                  DataCell(Container(
                                                      width: 20,
                                                      child: Checkbox(
                                                        value: e.isSelected,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            e.isSelected = value!;
                                                          });
                                                          if (e.isSelected == value) {
                                                            tanda = true;
                                                          }
                                                        },
                                                      ))),
                                                  DataCell(Container(
                                                      width: 50,
                                                      child: Text('$pos}'))),
                                                  DataCell(Container(
                                                      child: Text('${idKasir}'))),
                                                  DataCell(Container(
                                                      child: Text('${namaUser}}'))),
                                                  DataCell(Container(
                                                      child: Text('${nominalReturn}'))),
                                                ],
                                              )
                                              )
                                          .toList());
                                          }
                                        );
                                    }
                                  return Container();
                                  })
                                ),
                              ),
                            ),),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: MaterialButton(
                              padding: EdgeInsets.symmetric(horizontal: 120),
                              height: 45,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                'Menyetujui',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              color: Color.fromARGB(255, 255, 17, 17),
                              onPressed: () async {
                                await popupSucces();
                              }))
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  popupSucces() async {
    if (tanda == true) {
      print('setuju');
      APIApprovalReturnService api = APIApprovalReturnService();
      List<ApprovalReturnModel> modelyangsudahdiapproval = ApprovalReturnModel
          .approvalreturn
          .where((tiapitem) => tiapitem.isSelected)
          .toList();

      await api.ApprovalReturn(
          // status: '1',
          approve_return: modelyangsudahdiapproval);

      // fetchDataApproval(tanggal: _dateController.text, tipe: selected);
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
              'Data Berhasil di Approve',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        actionsAlignment: MainAxisAlignment.start,
        actionsPadding: EdgeInsets.only(bottom: 20),
      );
      showCupertinoModalPopup(context: context, builder: (context) => popup1);
      AndroidDeviceInfo info = await deviceInfo.androidInfo;
      var formData = FormData.fromMap({
        'progname': 'RALS_TOOLS ',
        'versi': '2.12v.2',
        'date_run': '${DateTime.now()}',
        'info1': 'Approve Data - Menu Approval Return',
        ' info2': '${imei} ',
        'userid': '${userData.getUsernameID()}',
        ' toko': '${userData.getUserToko()}',
        ' devicename': '${info.device}',
        'TOKEN': 'R4M4Y4N4'
      });

      var response =
          await dio.post('${tipeurl}v1/activity/createmylog', data: formData);
      print('berhasil $_udid');
    } else {
      print('tidak setuju');
      // fetchDataApproval(tanggal: _dateController.text, tipe: selected);
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
              'Tidak ada data yang harus disetujui',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        actionsAlignment: MainAxisAlignment.start,
        actionsPadding: EdgeInsets.only(bottom: 20),
      );
      showCupertinoModalPopup(context: context, builder: (context) => popup1);
    }
  }
}
