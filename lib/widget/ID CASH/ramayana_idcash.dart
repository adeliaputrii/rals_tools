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
                  return Ramayana();
                }), (route) => false);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            title: Text(
              'ID CASH',
              style: GoogleFonts.plusJakartaSans(
                  textStyle: TextStyle(
                      fontSize: 23,
                      color: Colors.white,
                      fontWeight: FontWeight.w500)),
            ),
            backgroundColor: baseColors.primaryColor,
            toolbarHeight: 70,
          ),
          body: Stack(fit: StackFit.loose, children: <Widget>[
            Container(
                // height: MediaQuery.of(context).size.height/1.14,
                decoration: BoxDecoration(
              color: baseColors.primaryColor,
            )),
            Container(
              width: 100000,
              height: 300,
              decoration: BoxDecoration(
                color: baseColors.primaryColor,
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
                                color: baseColors.primaryColor,
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
                                loginCubit.createLog(
                                    baseParam.logInfoIdcashPage,
                                    baseParam.logInfoIdcashHistory,
                                    apiUrl);
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
                                color: baseColors.primaryColor,
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
