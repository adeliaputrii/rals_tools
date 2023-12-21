part of 'import.dart';

class RamayanaIDCash extends StatefulWidget {
  const RamayanaIDCash({super.key});

  @override
  State<RamayanaIDCash> createState() => _RamayanaIDCashState();
}

class _RamayanaIDCashState extends State<RamayanaIDCash> {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String _udid = 'Unknown';
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneControler = TextEditingController();

  var balance = "-";
  var name = "-";
  var email = "-";
  var phone = "-";
  UserData userData = UserData();
  var dio = Dio();
  late IDCashCubit cubit;
  late LoginCubit loginCubit;
  late memberResponse.DataMemberCardResponse responseData;
  final apiUrl = '${tipeurl}${basePath.api_membercard_customer}';

  @override
  void didPushNext() {
    ScreenBrightness().resetScreenBrightness();
  }

  @override
  void didPop() {
    ScreenBrightness().resetScreenBrightness();
  }

  fetchDataCustomer({required String id_user}) async {
    print('${userData.getUsername7()}');
    print(tipeurl);
    final body = DataMemberCardBody(idUser: '${userData.getUsername7()}');
    cubit.getDataMember(body);
    // ApprovalIdcashCustomer.approvalidcashcust.clear();
    // final responseku = await http.post(
    //     Uri.parse('${tipeurl}v1/membercards/tbl_customer'),
    //     body: {'id_user': '${userData.getUsername7()}'});

    // var data = jsonDecode(responseku.body);

    // if (data['status'] == 200) {
    //   print("API Success oooo");
    //   print(data);
    //   int count = data['data'].length;
    //   final Map<String, ApprovalIdcashCustomer> profileMap = new Map();
    //   final Map<String, LogOffline> profileMap1 = new Map();
    //   for (int i = 0; i < count; i++) {
    //     ApprovalIdcashCustomer.approvalidcashcust
    //         .add(ApprovalIdcashCustomer.fromjson(data['data'][i]));
    //   }
    //   LogOffline.listActivity.forEach((element) {
    //     print('yaa11');
    //     print('${element.datetime}');
    //   });
    //   ApprovalIdcashCustomer.approvalidcashcust.forEach((element) {
    //     profileMap[element.nokartu] = element;

    //     ApprovalIdcashCustomer.approvalidcashcust = profileMap.values.toList();
    //     print('yaa');
    //     print(profileMap);
    //     print(ApprovalIdcashCustomer.approvalidcashcust);
    //   });
    //   print('check length ${ApprovalIdcashCustomer.approvalidcashcust.length}');
    //   print(data['data'].toString());
    // } else {
    //   print('NO DATA');
    // }

    // setState(() {});
  }

  @override
  void initState() {
    super.initState();
    responseData = DataMemberCardResponse();
    loginCubit = context.read<LoginCubit>();
    cubit = context.read<IDCashCubit>();
    initPlatformState();
    didPushNext();
    didPop();
    fetchDataCustomer(id_user: '0${userData.getUsername7()}');
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
    String string = ApprovalReturnMenu.idcashmenu.toString();
    print('string ${string}');
    List splitted = string.split(",");
    return BlocListener<IDCashCubit, IDCashState>(
        listener: (context, state) {
          if (state is IDCashSuccess) {
            responseData = state.response;
            setState(() {
              balance = state.response.data?.first.saldo.toString() ?? "0";
              name = state.response.data?.first.nama.toString() ?? '-';
              email = state.response.data?.first.email.toString() ?? '-';
              phone = state.response.data?.first.nohp.toString() ?? '-';
            });
            loginCubit.createLog(baseParam.logInfoIdcashPage,
                baseParam.logInfoIdcashSucc, apiUrl);
          }
          if (state is IDCashFailure) {
            loginCubit.createLog(baseParam.logInfoIdcashPage,
                '${baseParam.logInfoIdcashFail}${state.message}', apiUrl);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                ApprovalIdcash.approvalidcash.clear();
                print(ApprovalIdcash.approvalidcash);
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                  return DefaultBottomBarController(child: Ramayana());
                }), (route) => false);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            title: Text(
              'ID CASH',
              style: GoogleFonts.plusJakartaSans(
                  textStyle: TextStyle(
                      fontSize: 23,
                      color: Colors.white,
                      fontWeight: FontWeight.w500)),
            ),
            backgroundColor: Color.fromARGB(255, 210, 14, 0),
            elevation: 5,
            toolbarHeight: 90,
          ),
          body: Stack(fit: StackFit.loose, children: <Widget>[
            Container(
                // height: MediaQuery.of(context).size.height/1.14,
                decoration: BoxDecoration(
              color: Color.fromARGB(255, 210, 14, 0),
            )),
            Container(
              width: 100000,
              height: 300,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 210, 14, 0),
                // borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 1,
                  ),

                  Column(
                    children: [
                      Text(
                        'Saldo',
                        style: GoogleFonts.plusJakartaSans(
                          textStyle:
                              TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      Text('${int.tryParse(balance)?.toIdr() ?? "-"}',
                          style: GoogleFonts.plusJakartaSans(
                              textStyle: TextStyle(
                                  fontSize: 40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500)))
                    ],
                  ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: splitted.map((map) {
                  //       getNameMenu() {
                  //         var menu = '${map}';
                  //         print(map);
                  //         if (menu == "[ nokartu"){
                  //           return 'No.Kartu ID CASH';
                  //         }  else if (menu == "[ nokartu]]") {
                  //           return 'No.Kartu ID CASH';
                  //         } else if (menu == " transaksi]") {
                  //           return 'Riwayat Transaksi';
                  //         } else if (menu == " transaksi]]") {
                  //           return 'Riwayat Transaksi';
                  //         } else if (menu == "[ transaksi]]") {
                  //           return 'Riwayat Transaksi';
                  //         }  else {
                  //           return map;
                  //         }
                  //       }

                  //       getIconMenu() {
                  //         var menu = '${map}';
                  //         if (menu == "[ nokartu"){
                  //           return Icon(Icons.payment_outlined,
                  //               size: 35,
                  //               color: Color.fromARGB(255, 210, 14, 0),
                  //               );
                  //         } else if (menu == "[ nokartu]]") {
                  //         return Icon(Icons.payment_outlined,
                  //                size: 35,
                  //               color: Color.fromARGB(255, 210, 14, 0),
                  //               );
                  //         } else if (menu == " transaksi]") {
                  //         return Icon(Icons.bar_chart,
                  //                size: 35,
                  //               color: Color.fromARGB(255, 210, 14, 0),
                  //               );
                  //         } else if (menu == " transaksi]]") {
                  //         return Icon(Icons.bar_chart,
                  //                size: 35,
                  //               color: Color.fromARGB(255, 210, 14, 0),
                  //               );
                  //         } else if (menu == "[ transaksi]]") {
                  //         return Icon(Icons.bar_chart,
                  //                size: 35,
                  //               color: Color.fromARGB(255, 210, 14, 0),
                  //               );
                  //         } else {
                  //            Icon(Icons.menu,
                  //               size: 35,
                  //               color: Colors.white,
                  //               );
                  //         }
                  //       }
                  //       return
                  //     Column(

                  //       children: ApprovalIdcashCustomer.approvalidcashcust.map((e) {
                  //             return
                  //         Column(
                  //           children: [
                  //             MaterialButton(
                  //                       minWidth:  MediaQuery.of(context).size.width/7,
                  //                       height:  MediaQuery.of(context).size.height/15,
                  //                       shape: RoundedRectangleBorder(
                  //                       borderRadius: BorderRadius.circular(50)
                  //                       ),
                  //                       color: Colors.white,
                  //                       onPressed: () {
                  //                         Navigator.push(context, MaterialPageRoute(builder: (context){
                  //                            var nameControllerAkses = '${map}';
                  //                            if (nameControllerAkses == "[ nokartu") {
                  //                             return RamayanaPin();
                  //                            } else if (nameControllerAkses == '[ nokartu]]') {
                  //                              return RamayanaPin();
                  //                            } else if (nameControllerAkses == ' transaksi]') {
                  //                              ApprovalIdcash.approvalidcash.add(e.nokartu);
                  //                              print(ApprovalIdcash.approvalidcash);
                  //                             return RamayanaRiwayatIDCash();
                  //                            } else if (nameControllerAkses == ' transaksi]]') {
                  //                              ApprovalIdcash.approvalidcash.add(e.nokartu);
                  //                              print(ApprovalIdcash.approvalidcash);
                  //                             return RamayanaRiwayatIDCash();
                  //                            } else if (nameControllerAkses == '[ transaksi]]') {
                  //                              ApprovalIdcash.approvalidcash.add(e.nokartu);
                  //                              print(ApprovalIdcash.approvalidcash);
                  //                             return RamayanaRiwayatIDCash();
                  //                            } else {
                  //                            return RamayanaIDCash();
                  //                            }

                  //                       }));
                  //                       },
                  //                      child:  getIconMenu()

                  //                       ),
                  //                        SizedBox(
                  //                     height: 10,
                  //                   ),
                  //           Text('${getNameMenu()}', style: TextStyle(color: Colors.white, fontSize: 16, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500),),
                  //           ],
                  //         );

                  //       },).toList(),
                  //     );
                  //     }).toList()
                  // )
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          MaterialButton(
                              minWidth: MediaQuery.of(context).size.width / 7,
                              height: MediaQuery.of(context).size.height / 15,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return RamayanaIdcashNewPin(
                                    dataMember: responseData.data!.first,
                                  );
                                }));
                              },
                              child: Icon(
                                Icons.payment_outlined,
                                size: 35,
                                color: Color.fromARGB(255, 210, 14, 0),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text('No. Kartu ID CASH',
                              style: GoogleFonts.plusJakartaSans(
                                  textStyle: TextStyle(
                                      fontSize: 17, color: Colors.white))),
                        ],
                      ),
                      Column(
                        children: [
                          MaterialButton(
                              minWidth: MediaQuery.of(context).size.width / 7,
                              height: MediaQuery.of(context).size.height / 15,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              color: Colors.white,
                              onPressed: () async {
                                AndroidDeviceInfo info =
                                    await deviceInfo.androidInfo;
                                var formData = FormData.fromMap({
                                  'progname': 'RALS_TOOLS ',
                                  'versi': '${versi}',
                                  'date_run': '${DateTime.now()}',
                                  'info1': 'Riwayat ID CASH',
                                  ' info2': '${imei} ',
                                  'userid': '${userData.getUsernameID()}',
                                  ' toko': '${userData.getUserToko()}',
                                  ' devicename': '${info.device}',
                                  'TOKEN': 'R4M4Y4N4'
                                });
                                var response = await dio.post(
                                    '${tipeurl}v1/activity/createmylog',
                                    data: formData);
                                print('berhasil $_udid');
                                // ApprovalIdcash.approvalidcash.add(e.nokartu);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return RamayanaRiwayatIDCash(
                                      noMember: responseData
                                          .data!.first!.nokartu
                                          .toString());
                                }));
                              },
                              child: Icon(
                                Icons.bar_chart,
                                size: 35,
                                color: Color.fromARGB(255, 210, 14, 0),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Riwayat Transaksi',
                              style: GoogleFonts.plusJakartaSans(
                                  textStyle: TextStyle(
                                      fontSize: 17, color: Colors.white))),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
                // height: MediaQuery.of(context).size.height/1.81,
                margin: EdgeInsets.fromLTRB(5, 320, 5, 0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: ListView(children: [
                  Column(
                    children: [
                      Container(
                        height: 90,
                        width: 100000,
                        margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 228, 228, 228),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black54,
                                blurRadius: 3,
                                offset: Offset(2, 4))
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 20, top: 10),
                                child: Text(
                                  'Nama',
                                  style: GoogleFonts.plusJakartaSans(
                                      textStyle: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500)),
                                )),
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: TextFormField(
                                style: GoogleFonts.plusJakartaSans(
                                    textStyle: TextStyle(
                                        fontSize: 17, color: Colors.black)),
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 228, 228, 228)),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Color.fromARGB(
                                              255, 228, 228, 228)),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Color.fromARGB(
                                              255, 228, 228, 228)),
                                    )),
                                controller: nameController..text = name,
                                readOnly: true,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 90,
                        width: 100000,
                        margin: EdgeInsets.fromLTRB(20, 25, 20, 0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 228, 228, 228),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black54,
                                blurRadius: 3,
                                offset: Offset(2, 4))
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 20, top: 10),
                                child: Text(
                                  'Email',
                                  style: GoogleFonts.plusJakartaSans(
                                      textStyle: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500)),
                                )),
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: TextFormField(
                                style: GoogleFonts.plusJakartaSans(
                                    textStyle: TextStyle(
                                        fontSize: 17, color: Colors.black)),
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 228, 228, 228)),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Color.fromARGB(
                                              255, 228, 228, 228)),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Color.fromARGB(
                                              255, 228, 228, 228)),
                                    )),
                                controller: emailController..text = email,
                                readOnly: true,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 90,
                        width: 100000,
                        margin: EdgeInsets.fromLTRB(20, 25, 20, 0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 228, 228, 228),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black54,
                                blurRadius: 3,
                                offset: Offset(2, 4))
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 20, top: 10),
                                child: Text(
                                  'No. HP',
                                  style: GoogleFonts.plusJakartaSans(
                                      textStyle: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500)),
                                )),
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: TextFormField(
                                style: GoogleFonts.plusJakartaSans(
                                    textStyle: TextStyle(
                                        fontSize: 17, color: Colors.black)),
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 228, 228, 228)),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Color.fromARGB(
                                              255, 228, 228, 228)),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Color.fromARGB(
                                              255, 228, 228, 228)),
                                    )),
                                controller: phoneControler..text = phone,
                                readOnly: true,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ]))
          ]),
        ));
  }
}
