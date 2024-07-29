part of 'import.dart';

final List<String> imgList = [
  'https://ramayana.co.id/images/WhatsApp%20Image%202022-04-12%20at%2012.07.34%20(1).jpeg',
  'https://ramayana.co.id/images/WhatsApp%20Image%202022-04-12%20at%2012.07.34.jpeg',
  'https://ramayana.co.id/images/WhatsApp%20Image%202022-04-12%20at%2012.07.33.jpeg',
];

class Ramayana extends StatefulWidget {
  const Ramayana({super.key});

  @override
  State<Ramayana> createState() => _RamayanaState();
}

class _RamayanaState extends State<Ramayana> with WidgetsBindingObserver {
  String _lastMessage = "";
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  List data = [];
  List jumlahNews = [];
  int _current = 0;
  bool? _isConnected;
  final CarouselController _controller = CarouselController();
  List deskripsi = [];
  List datetime = [];
  DbHelper db = DbHelper();
  DbHelperVoidOffline db2 = DbHelperVoidOffline();
  DbHelperLoginOffline db3 = DbHelperLoginOffline();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  Timer? timer;
  List akses = ["${userData.getUserAkses()}"];
  String? _timeString;
  String _udid = 'Unknown';
  var dio = Dio();
  bool _enabled = true;
  int _status = 0;
  List<DateTime> _events = [];
  List data3Menu = [];
  List task3 = [];
  String? token;
  int? unread_task;
  int? total_task;
  var fcmToken;
  bool news = false;
  bool mylisttask = false;
  bool task = false;
  int? jumlahTask;
  bool isMounted = true;
  late HomeCubit homeCubit;
  bool namaUser = false;
  late LoginCubit loginCubit;
  late IDCashCubit cubit;
  late SharedPreferences pref;
  var member = '';
  final urlApi = '${tipeurl}${basePath.api_login}';

  String? urlPhoto;
  String? header;
  String? newsUrl;

  List<Map<String, dynamic>> loginOffline = [];
  List<Map<String, dynamic>> voidOffline = [];
  List<Map<String, dynamic>> logOffline = [];

  @override
  void initState() {
    loginCubit = context.read<LoginCubit>();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    homeCubit = context.read<HomeCubit>();
    cubit = context.read<IDCashCubit>();
    refreshPage();
  }

  @override
  void dispose() {
    isMounted = false;
    super.dispose();
  }
  

  Future<void> refreshWidget() async {
    homeCubit.getTaskUser(token!);
    _getAllActivity();
    _unsecureScreen();
     _checkInternetConnection();
  }

  refreshPage() async {
    token = await SharedPref.getToken();
    homeCubit.getNewsList(token!);
    homeCubit.getTaskUser(token!);
    fetchDataCustomer();
    _getAllActivity();
    _unsecureScreen();
     _checkInternetConnection();
  }

  fetchDataCustomer() async {
    final body = DataMemberCardBody(idUser: userData.getUsername7());
    cubit.getDataMember(token!, body);
    print('OKE');
  }

  _unsecureScreen() async {
    await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE); // Mengaktifkan kembali tangkapan layar
  }

  fetchDataJumlahTask() async {
    HomeTaskTotal.hometasktotal.clear();
    final responseku = await http.get(Uri.parse('${base_url_dev}/api/v1/activity/task/count-unread'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    var data = jsonDecode(responseku.body);
    if (data['status'] == 200) {
      Map<String, dynamic> count = data['data'];
      count.forEach((key, value) {
        if (key == 'unread_task') {
          unread_task = value;
        } else if (key == 'total_task') {
          total_task = value;
        }
      });
      print(data['data'].toString());
    } else {
      print('NO DATA');
    }
  }

  read_task() async {
    final responseku = await http.post(Uri.parse('${tipeurl}v1/activity/task/read-all-task'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var data = jsonDecode(responseku.body);
    if (data['status'] == 200) {
      print(data);
    } else {
      print(data['status']);
    }

    setState(() {});
  }

  _checkInternetConnection() async {
    try {
      final response = await InternetAddress.lookup('www.kindacode.com');
      if (response.isNotEmpty) {
        setState(() {
          _isConnected = true;
        });
      }
    } on Exception catch (err) {
      setState(() {
        _isConnected = false;
      });
      if (kDebugMode) {
        print(err);
      }
    }
  }

  Future<void> _getAllActivity() async {
    //list menampung data dari database
    var list = await db.getAllFormat();
    var listVoidOffline = await db2.getAllFormatVoidOffline();
    var listLoginOffline = await db3.getAllFormat(); //

    if (isMounted) {
      setState(() {
        //hapus data pada listKontak
        LogOffline.listActivity.clear();
        VoidOffline.voidOffline.clear();
        LoginOffline.listActivity.clear();
      });
      if (list != null) {
        final String columnId = 'id_act';
        final String columnIdGenerate = 'deskripsi';
        final String columnDate = 'datetime';
        // Iterate through the result and print attributes
        for (var activityy in list) {
          var id = activityy[columnId];
          var deskripsi = activityy[columnIdGenerate];
          var datetime = activityy[columnDate];
          loginCubit.createLogVoidOffline(logInfoVoidOfflinePage, deskripsi, urlApi, datetime);
          await db.deleteActivityy(id);
        }
      }
      if (listVoidOffline != null) {
        final String columnId = 'id_act';
        final String columnIdGenerate = 'idGenerate';
        final String columnDate = 'date';
        // Iterate through the result and print attributes
        for (var activityy in listVoidOffline) {
          var id = activityy[columnId];
          var idGenerate = activityy[columnIdGenerate];
          var date = activityy[columnDate];
          loginCubit.createLogVoidOffline(logInfoVoidOfflinePage, idGenerate, urlApi, date);
          await db2.deleteVoidOffline(id);
        }
      }
      if (listLoginOffline != null) {
        final String columnId = 'id_act';
        final String columnDeskripsi = 'deskripsi';
        final String columnDatetime = 'datetime';
        // Iterate through the result and print attributes
        for (var activity in listLoginOffline) {
          var id = activity[columnId];
          var deskripsi = activity[columnDeskripsi];
          var datetime = activity[columnDatetime];
          loginCubit.createLogVoidOffline(logLoginOfflinePage, deskripsi, urlApi, datetime);
          await db3.deleteActivityy(id);
        }
        db3.deleteAll();
      }
    }
  }

  Future<void> dapetinData() async {
    pref = await SharedPreferences.getInstance();
    UserData userData = UserData();
    await userData.getPref();
    String userId = userData.getUsernameID();
  }

  @override
  void didPushNext() {
    ScreenBrightness().resetScreenBrightness();
  }

  @override
  void didPop() {
    ScreenBrightness().resetScreenBrightness();
  }

  static UserData userData = UserData();

  Future<void> deleteToko() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    AndroidDeviceInfo info = await deviceInfo.androidInfo;
    pref.remove('toko');
    pref.remove('project');
    pref.remove('barcode');
    pref.remove('hakAkses');
    HakAkses.hakaksesSubmenuComcek.clear();
    MyactivityModel.addSelect.clear();
    MyactivityModelTask.addselectTask.clear();
  }

  imei() async {
    AndroidDeviceInfo info = await deviceInfo.androidInfo;
    var code = "${userData.getUsername7()}+${info.id}+${info.device}";
    var ascAdel = AsciiEncoder().convert(code);
    var str = ascAdel.join("");
    String message = '';
    for (int code in ascAdel) {
      message += String.fromCharCode(code);
    }
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

  logoutPressed() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    SharedPref.clearLastLogin();
    pref.remove('waktuLogin');
    pref.remove('token');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
      return RamayanaLogin();
    }));
  }

  void showMenuBottomSheet(String menu) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16))),
      backgroundColor: baseColors.primaryColor,
      isScrollControlled: true,
      useSafeArea: true,
      isDismissible: true,
      enableDrag: true,
      showDragHandle: true,
      builder: (_) {
        if (menu == baseParam.menuGroupPersonal) {
          return PersonalMenuWidget();
        }
        if (menu == baseParam.menuGroupTools) {
          return ToolsMenuWidget();
        }
        if (menu == baseParam.menuGroupReport) {
          return ReportMenuWidget();
        }
        if (menu == baseParam.menuAll) {
          return AllMenuWidget();
        }
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isConnected == false) {
      print('not connected');
    } else {
      print('connected');
      //  _getAllActivity();
    }

    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return BlocListener<IDCashCubit, IDCashState>(
        listener: (context, state) {
          if (state is IDCashSuccess) {
            setState(() {
              member = state.response.data!.first.nokartu.toString();
              pref.setString('noMember', '${member}');
            });
          }
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).canvasColor,
          extendBody: true,
          appBar: AppBar(
            backgroundColor: baseColors.primaryColor,
            elevation: 0,
            toolbarHeight: 1,
          ),
          body: LiquidPullToRefresh(
            color: baseColors.primaryColor,
            onRefresh: refreshWidget,
            showChildOpacityTransition: false,
            child: ListView(
              children: [
                InkWell(
                  onTap: () async {
                    await _checkInternetConnection();
                  },
                  child: Container(
                    color: Color.fromARGB(255, 235, 235, 235),
                    child: Column(
                      children: [
                        Stack(
                          fit: StackFit.loose,
                          children: <Widget>[
                            Container(
                              color: Colors.blue,
                            ),
                            ClipPath(
                              clipper: BottomClipper(),
                              child: Container(
                                margin: EdgeInsets.only(top: 0),
                                height: 300,
                                color: baseColors.primaryColor
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 0, left: 20),
                                    child: Text(
                                      'Selamat Datang',
                                      style: GoogleFonts.plusJakartaSans(
                                        textStyle: TextStyle(
                                          fontSize: 27, 
                                          fontWeight: FontWeight.w600, 
                                          color: Colors.white
                                        )
                                      ),
                                    ),
                                  ),
                                Container(
                                  margin: EdgeInsets.only(top: 10, right: 20),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
                                        return Profilee();
                                      }));
                                    },
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 30,
                                          child: Icon(
                                            IconlyBold.profile,
                                            color: Colors.red,
                                            size: 40,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text('Lihat Profil', style: GoogleFonts.mukta(
                                          textStyle: TextStyle(
                                            fontSize: 18, 
                                            color: Colors.white)
                                          )
                                        )
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            namaUser
                            ? Container(
                              margin: EdgeInsets.only(top: 75, left: 20, right: 120),
                              child: Text(
                                'Halo ${userData.getFullname()}',
                                style: GoogleFonts.mukta(
                                  textStyle: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  overflow: TextOverflow.ellipsis,
                                  )),
                                ))
                            : Container(
                              margin: EdgeInsets.only(top: 75, left: 20),
                              child: AnimatedTextKit(
                                totalRepeatCount: 2,
                                onFinished: () {
                                  setState(() {
                                    namaUser = true;
                                  });
                                },
                                animatedTexts: [
                                  FadeAnimatedText(
                                    'Halo ${userData.getFullname()}',
                                    textStyle: GoogleFonts.mukta(textStyle: TextStyle(fontSize: 20, color: Colors.white)),
                                  ),
                                ],
                              ),
                             ),
                            Container(
                              margin: EdgeInsets.only(top: 130, left: 20, right: 20),
                              height: 190,
                              width: 100000,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 7.0, // soften the shadow
                                    spreadRadius: 1.0, //extend the shadow
                                    offset: Offset(
                                      1.0, // Move to right 5  horizontally
                                      2.0, // Move to bottom 5 Vertically
                                    ),
                                  )
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Rtools Menu',
                                          style: GoogleFonts.plusJakartaSans(
                                            textStyle: TextStyle(
                                              fontSize: 20, 
                                              color: Color.fromARGB(255, 71, 70, 70)
                                            )
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [Colors.red, Color.fromARGB(255, 103, 94, 94)],
                                              begin: FractionalOffset(0.0, 0.0),
                                              end: FractionalOffset(1.5, 0.0),
                                              stops: [0.0, 1.0],
                                              tileMode: TileMode.clamp),
                                            borderRadius: BorderRadius.circular(90)),
                                            margin: EdgeInsets.only(right: 10),
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all<Color>(baseColors.primaryColor)),
                                                onPressed: () async {
                                                  showMenuBottomSheet(baseParam.menuAll);
                                                },
                                                child: Text(
                                                  'Lihat Semua',
                                                  style: GoogleFonts.plusJakartaSans(
                                                    fontSize: 15, 
                                                    color: Colors.white
                                                  ),
                                                )
                                              )
                                          )
                                        ],
                                      ),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                      menuIconHome(baseAsset.personalMenuLogo, baseParam.menuGroupPersonal,
                                        function: () => showMenuBottomSheet(baseParam.menuGroupPersonal)),
                                      menuIconHome(baseAsset.toolsMenuLogo, baseParam.menuGroupTools,
                                        function: () => showMenuBottomSheet(baseParam.menuGroupTools)),
                                      menuIconHome(baseAsset.reportMenuLogo, baseParam.menuGroupReport,
                                        function: () => AppNavigator.navigateToReportSalesList(context)),
                                      ]),
                                    ),
                                    // ),
                                  ],
                                ),
                              ),
                            Container(
                              margin: EdgeInsets.only(top: 330),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 50,
                                          child: Container(
                                            margin: EdgeInsets.only(left: 20, right: 20, top: 0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Informasi Update Ramayana',
                                                  style: GoogleFonts.plusJakartaSans(
                                                    textStyle: TextStyle(
                                                      fontSize: 20, 
                                                      color: Colors.black, 
                                                      fontWeight: FontWeight.w500
                                                    )
                                                  ),
                                                ),
                                                Container(
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [Colors.red, Color.fromARGB(255, 103, 94, 94)],
                                                      begin: FractionalOffset(0.0, 0.0),
                                                      end: FractionalOffset(1.5, 0.0),
                                                      stops: [0.0, 1.0],
                                                      tileMode: TileMode.clamp),
                                                    borderRadius: BorderRadius.circular(90)),
                                                      margin: EdgeInsets.only(right: 10),
                                                      child: ElevatedButton(
                                                        style: ButtonStyle(
                                                          backgroundColor: MaterialStateProperty.all<Color>(baseColors.primaryColor)),
                                                        onPressed: () async {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) => RamayanaInformasi(),
                                                            )
                                                          );
                                                        },
                                                        child: Text(
                                                        'Lihat Semua',
                                                        style: GoogleFonts.plusJakartaSans(fontSize: 15, color: Colors.white),
                                                    )))
                                                  ],
                                                ),
                                              ),
                                            ),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                          child:
                                            InkWell(
                                              onTap: () {
                                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                                                  return NewsDetail(newsUrl: newsUrl ?? '', fromHome: true);
                                                }), (route) => false);
                                               },
                                              child: Container(
                                                width: 400,
                                                margin: EdgeInsets.only(bottom: 10, right: 20),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.white,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(10),
                                                        child: 
                                                        urlPhoto == null 
                                                        ?
                                                        Container()
                                                        :
                                                        Image.network('${urlPhoto ?? ''}', fit: BoxFit.cover)
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.fromLTRB(10, 10, 0, 15),
                                                      child: Text('${header ?? ''}',
                                                        style: GoogleFonts.plusJakartaSans(
                                                        fontSize: 17, 
                                                        fontWeight: FontWeight.w600, 
                                                        color: Colors.black),
                                                      ),
                                                     ),
                                                    ],
                                                  ),
                                                 ),
                                              )
                                            ),
                                          ],
                                        )
                                      ),
                                  Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: mylisttask
                                    ? Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 0, left: 20, right: 20),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Tugas Saya',
                                                    style: GoogleFonts.plusJakartaSans(
                                                    textStyle:TextStyle(
                                                      fontSize: 22, 
                                                      color: Colors.black, 
                                                      fontWeight: FontWeight.w500
                                                    )
                                                  ), ),
                                                  Text(
                                                  ' (${total_task == null ? '' : total_task})',
                                                    style: GoogleFonts.plusJakartaSans(
                                                      textStyle: TextStyle(
                                                        fontSize: 22,
                                                        color: Color.fromARGB(255, 255, 0, 0),
                                                        fontWeight: FontWeight.w500
                                                      )
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              unread_task == 0 || unread_task == null
                                              ? Container(
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                  colors: [Colors.red, Color.fromARGB(255, 103, 94, 94)],
                                                  begin: FractionalOffset(0.0, 0.0),
                                                  end: FractionalOffset(1.5, 0.0),
                                                  stops: [0.0, 1.0],
                                                  tileMode: TileMode.clamp),
                                                  borderRadius: BorderRadius.circular(90)),
                                                    margin: EdgeInsets.only(right: 10),
                                                    child: ElevatedButton(
                                                      style: ButtonStyle(
                                                        backgroundColor: MaterialStateProperty.all<Color>(baseColors.primaryColor)),
                                                        onPressed: () async {
                                                          await read_task();
                                                          Navigator.push(context,
                                                            MaterialPageRoute(
                                                            builder: (context) => RamayanaMyListTask(),
                                                          )
                                                        );
                                                      },
                                                      child: Text(
                                                      'Lihat Semua',
                                                       style: GoogleFonts.plusJakartaSans(fontSize: 15, color: Colors.white),
                                                      )
                                                ))
                                              : badge.Badge(
                                                  child: Container(
                                                  height: 38,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                    colors: [Colors.red, Color.fromARGB(255, 103, 94, 94)],
                                                      begin: FractionalOffset(0.0, 0.0),
                                                      end: FractionalOffset(1.5, 0.0),
                                                      stops: [0.0, 1.0],
                                                      tileMode: TileMode.clamp),
                                                    borderRadius: BorderRadius.circular(90)),
                                                  margin: EdgeInsets.only(right: 10),
                                                  child: ElevatedButton(
                                                    onPressed: () async {
                                                      await read_task();
                                                        Navigator.push(context,
                                                        MaterialPageRoute(
                                                        builder: (context) => RamayanaMyListTask(),
                                                      ));
                                                     },
                                                    child: Text('Lihat Semua',
                                                      style: GoogleFonts.plusJakartaSans(
                                                        fontSize: 15, 
                                                        color: Colors.white),
                                                   ))),
                                                badgeContent: SizedBox(
                                                  width: 18,
                                                  height: 20, //badge size
                                                  child: Center(
                                                    child: Text("${unread_task == null ? '' : unread_task}",
                                                    style: TextStyle(
                                                    color: Colors.white, //badge font color
                                                    fontSize: 20 //badge font size
                                                  )),
                                                 )),
                                                badgeColor: Color.fromARGB(255, 255, 67, 67), )
                                              ],
                                              ),
                                            ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10,left: 20,right: 20, ),
                                          child: BlocListener<HomeCubit, HomeState>(
                                            listener: (context, state) {
                                              if(state is HomeNewsSuccess) {
                                                setState(() {
                                                  urlPhoto = state.response.data?.first.urlPhoto;
                                                  header = state.response.data?.first.beritaHdr;
                                                  newsUrl = state.response.data?.first.newsUrl;
                                                  }
                                                );
                                              }
                                            },
                                            child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
                                              if (state is HomeLoading) {
                                                return SpinKitThreeBounce(
                                                  color: Color.fromARGB(255, 230, 0, 0),
                                                  size: 50.0,
                                                );
                                              }
                                              if (state is HomeSuccess) {
                                                return Container(
                                                  child: ListView.builder(
                                                    primary: false,
                                                    shrinkWrap: true,
                                                    itemCount: 3,
                                                    itemBuilder: (BuildContext context, int index) {
                                                      return InkWell(
                                                      onTap: () {
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                          return RamayanaMyActivity(update: false, response: state.response.data![index]);
                                                        })
                                                        );
                                                      },
                                                      child: Container(
                                                        height: 90,
                                                        margin: EdgeInsets.only(bottom: 10),
                                                          decoration: BoxDecoration(boxShadow: <BoxShadow>[
                                                            BoxShadow(
                                                              color: Color.fromARGB(255, 197, 197, 197),
                                                              blurRadius: 1,
                                                              spreadRadius: 1,
                                                              offset: Offset(2, 2))
                                                            ], 
                                                          color: Colors.white, 
                                                          borderRadius: BorderRadius.circular(10)
                                                          ),
                                                        child: ListTile(
                                                          leading: CircleAvatar(
                                                          backgroundColor: Color.fromARGB(255, 210, 14, 0),
                                                          radius: 30,
                                                          backgroundImage: AssetImage('assets/todolist.png')),
                                                          subtitle: Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                margin: EdgeInsets.only(top: 3),
                                                                child: Text(
                                                                  '${state.response.data?[index].taskDesc}',
                                                                    style: GoogleFonts.plusJakartaSans(
                                                                      fontSize: 18, color: Colors.black, 
                                                                      fontWeight: FontWeight.w500
                                                                    ),
                                                                    overflow: TextOverflow.ellipsis,
                                                                  ),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 80,
                                                                    child: Text('Status',
                                                                    style: GoogleFonts.plusJakartaSans(
                                                                      fontSize: 15, color: Colors.grey)),
                                                                  ),
                                                                  Text('${state.response.data?[index].taskStatus}',
                                                                    style:GoogleFonts.plusJakartaSans(
                                                                      fontSize: 15, 
                                                                      color: Colors.grey
                                                                    )
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 80,
                                                                    child: Text('Project ID',
                                                                    style: GoogleFonts.plusJakartaSans(
                                                                    fontSize: 15, 
                                                                    color: Colors.grey)),
                                                                  ),
                                                                  Text(': ${state.response.data?[index].projectId}',
                                                                    style:GoogleFonts.plusJakartaSans(
                                                                      fontSize: 15, 
                                                                      color: Colors.grey
                                                                    )
                                                                  ),
                                                                ],
                                                              ),
                                                           ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                 ),
                                                );
                                              }
                                          return Container();
                                         }),
                                       )),
                                      ],
                                     )
                                    : Container()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
      );
    });
  }
}

Widget menuIconHome(String asset, String title, {required VoidCallback function}) {
  return GestureDetector(
    onTap: function,
    child: Column(children: [
      CircleAvatar(
        backgroundColor: Colors.white,
        radius: 30,
        child: Image.asset(asset, height: baseSize.iconMenuHeight, width: baseSize.iconMenuWidth),
      ),
      const SizedBox(height: 8),
      Text('${title}',
          maxLines: 2,
          textAlign: TextAlign.center,
          style:
              GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500, textStyle: TextStyle(fontSize: 15, color: Color.fromARGB(255, 71, 70, 70)))),
    ]),
  );
}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - size.width / 4, size.height, size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
class FadeInImageWidget extends StatefulWidget {
  final String imageUrl;

  FadeInImageWidget({required this.imageUrl});

  @override
  _FadeInImageWidgetState createState() => _FadeInImageWidgetState();
}

class _FadeInImageWidgetState extends State<FadeInImageWidget> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      // color: Colors.amber,
      child: FadeTransition(
        opacity: _animation,
        child: Image.asset(widget.imageUrl),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
