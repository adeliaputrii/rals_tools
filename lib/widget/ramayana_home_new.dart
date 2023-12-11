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
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  List data = [];
  List jumlahNews = [];
  int _current = 0;
  bool? _isConnected;
  final CarouselController _controller = CarouselController();
  List deskripsi = [];
  List datetime = [];
  DbHelper db = DbHelper();
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
  var token = '';
  int? unread_task;
  int? total_task;
  var fcmToken;
  bool news = false;
  bool mylisttask = false;
  bool task = false;
  int? jumlahTask;
  bool isMounted = true;
  late HomeCubit homeCubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    UserData userData = UserData();
    homeCubit = context.read<HomeCubit>();
    initPlatformState();
    didPop();
    _checkInternetConnection();
    _getAllActivity();
    didPushNext(); //ulang lagi dell sorry license okay
    ApprovalReturnMenu.approvalmenu.clear();
    ApprovalReturnMenu.idcashmenu.clear();
    ApprovalIdcash.approvalidcash.clear();
    ModelToko.menutoko.clear();
    deleteToko();
    imei();
    dapetinData();
    homeCubit.getTaskUser();
    Future.delayed(const Duration(seconds: 1), () async {
      await fetchDataJumlahTask();
      await fetchDataListUser();
      print('delayed execution');
    });
    fetchDataJumlahTask();
    _unsecureScreen();
    fetchBerita();
  }

  @override
  void dispose() {
    isMounted = false;
    super.dispose();
  }

  _unsecureScreen() async {
    await FlutterWindowManager.clearFlags(FlutterWindowManager
        .FLAG_SECURE); // Mengaktifkan kembali tangkapan layar
  }

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ))
      .toList();

  _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserData userData = UserData();

    var accToken = userData.getUserToken();
    print('load token ${accToken}');
    if (isMounted) {
      setState(() {
        token = (prefs.getString('user_token_str') ?? '');
      });
    }

    return token;
  }

  fetchDataListUser() async {
    _loadToken();
    TaskHome.taskhome.clear();
    final responseku = await http
        .get(Uri.parse('${tipeurl}v1/activity/task/get-task'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    var data = jsonDecode(responseku.body);

    if (data["status"] == 200) {
      print("API Success oooo");
      print(data);
      int count = data['data'].length;
      if (count > 3) {
        for (int i = 0; i < 3; i++) {
          TaskHome.taskhome.add(TaskHome.fromjson(data['data'][i]));
          print('true');
        }
      } else {
        for (int i = 0; i < count; i++) {
          TaskHome.taskhome.add(TaskHome.fromjson(data['data'][i]));
          print('false');
        }
      }

      final Map<String, TaskHome> profileMap = new Map();
      TaskHome.taskhome.forEach((element) {
        profileMap[element.task_id] = element;

        TaskHome.taskhome = profileMap.values.toList();
      });
      print('check length ${TaskHome.taskhome.length}');
      print(data['data'].toString());
    } else {
      print(data['status']);
      print('NO DATA');
    }
  }

  fetchBerita() async {
    News.news.clear();
    final responseku =
        await http.get(Uri.parse('${tipeurl}v1/news/get'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    var data = jsonDecode(responseku.body);

    if (data['status'] == 200) {
      print("API Success oooo");
      print(data);
      int count = data['data'].length;

      for (int i = 0; i < count; i++) {
        News.news.add(News.fromjson(data['data'][i]));
      }
      if (News.news.length > 2) {
        News.news3 = News.news.sublist(0, 3);
      } else {
        News.news3 = News.news.sublist(0, News.news.length);
      }
      final Map<String, News> profileMap = new Map();
      News.news.forEach((element) {
        profileMap[element.berita_hdr] = element;

        News.news = profileMap.values.toList();
      });
      print('check length ${News.news.length}');
      print(data['data'].toString());
    } else {
      print(data['status']);
      print('NO DATA');
    }
  }

  fetchDataJumlahTask() async {
    _loadToken();
    HomeTaskTotal.hometasktotal.clear();
    final responseku = await http
        .get(Uri.parse('${tipeurl}v1/activity/task/count-unread'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    var data = jsonDecode(responseku.body);

    if (data['status'] == 200) {
      print("API Success oooo");
      print(data);
      Map<String, dynamic> count = data['data'];
      count.forEach((key, value) {
        if (key == 'unread_task') {
          unread_task = value;
        } else if (key == 'total_task') {
          total_task = value;
        }
      });

      print('count : $count');
      print(count.keys);
      print(count.values);
      print(data['data'].toString());
    } else {
      print('NO DATA');
    }
  }

  read_task() async {
    _loadToken();
    final responseku = await http
        .post(Uri.parse('${tipeurl}v1/activity/task/read-all-task'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var data = jsonDecode(responseku.body);
    if (data['status'] == 200) {
      print(data['status']);
      print("API Success oooo");
      print(data);
    } else {
      print(data['status']);
      print('NO DATA');
    }

    setState(() {});
  }

  _checkInternetConnection() async {
    try {
      final response = await InternetAddress.lookup('www.kindacode.com');
      if (response.isNotEmpty) {
        setState(() {
          _isConnected = true;
          print(_isConnected);
        });
      }
    } on Exception catch (err) {
      setState(() {
        _isConnected = false;
        print(_isConnected);
      });
      if (kDebugMode) {
        print(err);
      }
    }
    print(_isConnected);
  }

  Future<void> _getAllActivity() async {
    //list menampung data dari database
    var list = await db.getAllFormat();

    if (isMounted) {
      setState(() {
        //hapus data pada listKontak
        LogOffline.listActivity.clear();

        //lakukan perulangan pada variabel list
        list!.forEach((activityy) {
          //masukan data ke listKontak
          LogOffline.listActivity.add(LogOffline.fromMap(activityy));
          print(LogOffline.listActivity);
        });
      });
    }
    //ada perubahanan state
  }

  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    _selectedIndex = index;
    if (_selectedIndex == 0) {
      sweatAlert();
    } else if (_selectedIndex == 2) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return Profilee();
      }));
    }
  }

  Future<void> dapetinData() async {
    UserData userData = UserData();
    await userData.getPref();
    String userId = userData.getUsernameID();
    print(userId);
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
    print('info.serialNumber : ${info.id}');
    pref.remove('toko');
    pref.remove('project');
    pref.remove('barcode');
    pref.remove('hakAkses');
    HakAkses.hakaksesSubmenuComcek.clear();
    MyactivityModel.addSelect.clear();
    print(MyactivityModel.addSelect);
    MyactivityModelTask.addselectTask.clear();
    print(MyactivityModelTask.addselectTask);
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
    print('encode : ${message}');
    print(str);
    print('asqi : ${ascAdel}');
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
    pref.remove('username');
    pref.remove('waktuLogin');
    pref.remove('token');
    pref.remove('serialImei');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
      return RamayanaLogin();
    }));
  }

  sweatAlert() {
    var alertStyle = AlertStyle(
      titlePadding: EdgeInsets.only(top: 0),
      animationType: AnimationType.fromRight,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: GoogleFonts.plusJakartaSans(
        fontSize: 19,
        color: Colors.black,
      ),
      descTextAlign: TextAlign.center,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: GoogleFonts.plusJakartaSans(
          fontSize: 23, color: Colors.red, fontWeight: FontWeight.w500),
      alertAlignment: Alignment.center,
    );
    Alert(
      style: alertStyle,
      context: context,
      image: FadeInImageWidget(imageUrl: "assets/logout.png"),
      title: 'Log Out',
      desc: "Are you sure you want to log out?",
      buttons: [
        DialogButton(
          radius: BorderRadius.circular(20),
          color: Colors.green,
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              _selectedIndex = 1;
            });
          },
          child: Text(
            "Cancel",
            style:
                GoogleFonts.plusJakartaSans(fontSize: 15, color: Colors.white),
          ),
        ),
        DialogButton(
          radius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 210, 14, 0),
          onPressed: () async {
            AndroidDeviceInfo info = await deviceInfo.androidInfo;
            var formData = FormData.fromMap({
              'progname': 'RALS_TOOLS ',
              'versi': '${versi}',
              'date_run': '${DateTime.now()}',
              'info1': 'Logout Aplikasi RALS',
              ' info2':
                  '${imei} ', //ini disini yang imei ya del? iya pak. ini lari nya kemana ya del isi nya? -reza sebentar pak, saya ijin ke belakang

              'userid': '${userData.getUsernameID()}',
              ' toko': '${userData.getUserToko()}',
              ' devicename': '${info.device}',
              'TOKEN': 'R4M4Y4N4'
            });

            var response = await dio.post('${tipeurl}v1/activity/createmylog',
                data: formData);
            print('berhasil $_udid');
            Navigator.pop(context);
            logoutPressed();
          },
          child: Text(
            "Log Out",
            style:
                GoogleFonts.plusJakartaSans(fontSize: 15, color: Colors.white),
          ),
        ),
      ],
    ).show();
    return;
  }

  alertMenu() {
    var alertStyle = AlertStyle(
      titlePadding: EdgeInsets.only(top: 0),
      animationType: AnimationType.fromRight,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: GoogleFonts.plusJakartaSans(
        fontSize: 19,
        color: Colors.black,
      ),
      descTextAlign: TextAlign.center,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: GoogleFonts.plusJakartaSans(
          fontSize: 23, color: Colors.red, fontWeight: FontWeight.w500),
      alertAlignment: Alignment.center,
    );
    Alert(
      style: alertStyle,
      context: context,
      buttons: [
        DialogButton(
          color: Color.fromARGB(255, 210, 14, 0),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancel",
            style:
                GoogleFonts.plusJakartaSans(fontSize: 17, color: Colors.white),
          ),
        ),
      ],
      content: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Text(
                'My Activity Menu',
                style: GoogleFonts.plusJakartaSans(
                    textStyle: TextStyle(
                        fontSize: 20, color: Color.fromARGB(255, 71, 70, 70))),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Wrap(
                spacing: 15.0,
                runSpacing: 15.0,
                alignment: WrapAlignment.spaceAround,
                runAlignment: WrapAlignment.spaceBetween,
                //adel ini gausah di masukin ke model bisa gaa? langsung aja dia pake api nya nembak langsung
                children: data.map((e) {
                  // ${e.nsadssaame_menu}
                  print(e);

                  getIcon() {
                    var icon = '${e}';
                    if (icon == 'mastervoid.void') {
                      return Visibility(
                        child: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 207, 11, 11),
                          radius: 30,
                          backgroundImage: AssetImage(
                            'assets/void.png',
                          ),
                        ),
                        visible: true,
                      );
                    } else if (icon == "masteridcash.idcash") {
                      return Visibility(
                        child: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 207, 11, 11),
                          radius: 30,
                          backgroundImage: AssetImage(
                            'assets/ic_idcash.png',
                          ),
                        ),
                        visible: true,
                      );
                    } else if (icon == "approvalreturn.approvalreturn") {
                      return Visibility(
                        child: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 207, 11, 11),
                          radius: 30,
                          backgroundImage: AssetImage(
                            'assets/approval.png',
                          ),
                        ),
                        visible: true,
                      );
                    } else if (icon == "cekprice.cekprice") {
                      return Visibility(
                        child: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 207, 11, 11),
                          radius: 30,
                          backgroundImage: AssetImage(
                            'assets/cekharga.png',
                          ),
                        ),
                        visible: true,
                      );
                    } else if (icon == "tukarpoin.tukarpoin") {
                      return Visibility(
                        child: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 207, 11, 11),
                          radius: 30,
                          backgroundImage: AssetImage(
                            'assets/tukarpoin.png',
                          ),
                        ),
                        visible: true,
                      );
                    } else if (icon == "myactivity.activity") {
                      return Visibility(
                        child: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 207, 11, 11),
                          radius: 30,
                          backgroundImage: AssetImage(
                            'assets/myactivity.png',
                          ),
                        ),
                        visible: true,
                      );
                    } else if (icon == "suratjalan.trackingsj") {
                      return Visibility(
                        child: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 207, 11, 11),
                          radius: 30,
                          backgroundImage: AssetImage(
                            'assets/sjalan.png',
                          ),
                        ),
                        visible: true,
                      );
                    } else if (icon == "comchek.approvedcomchek") {
                      return Visibility(
                        child: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 207, 11, 11),
                          radius: 30,
                          backgroundImage: AssetImage(
                            'assets/comcek.png',
                          ),
                        ),
                        visible: true,
                      );
                    } else {
                      Visibility(
                        child: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 207, 11, 11),
                          radius: 30,
                          backgroundImage: AssetImage(
                            'assets/cekharga.png',
                          ),
                        ),
                        visible: true,
                      );
                    }
                  }

                  getName() {
                    var icon = '${e}';
                    if (icon == 'mastervoid.void') {
                      return 'Void';
                    } else if (icon == "masteridcash.idcash") {
                      return 'Id Cash';
                    } else if (icon == "cekprice.cekprice") {
                      return 'Cek Harga';
                    } else if (icon == "approvalreturn.approvalreturn") {
                      return 'Approval Return';
                    } else if (icon == "tukarpoin.tukarpoin") {
                      return 'Tukar Poin';
                    } else if (icon == "myactivity.activity") {
                      return 'My Activity';
                    } else if (icon == "suratjalan.trackingsj") {
                      return 'Tracking SJ';
                    } else if (icon == "comchek.approvedcomchek") {
                      return 'Com. Checking';
                    } else {
                      print(e);
                      print('no menu');
                    }
                  }

                  return Column(children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.black,
                          elevation: 0,
                        ),
                        child: getIcon(),
                        onPressed: () async {
                          await _checkInternetConnection();
                          print('haiiioooo');
                          if (e == 'mastervoid.void') {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return RamayanaVoid();
                            }));
                          } else if (e == 'masteridcash.idcash') {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return RamayanaIDCash();
                            }));
                          } else if (e == 'approvalreturn.approvalreturn') {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return RamayanaApprovalReturn();
                            }));
                          } else if (e == 'cekprice.cekprice') {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return RamayanaCariToko();
                            }));
                          } else if (e == 'tukarpoin.tukarpoin') {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return RamayanaTukarPoin();
                            }));
                          } else if (e == 'myactivity.activity') {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return RamayanaMyActivity();
                            }));
                          } else if (e == 'suratjalan.trackingsj') {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return RamayanaSuratJalan();
                            }));
                          } else if (e == 'comchek.approvedcomchek') {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return RamayanaCompetitorCek();
                            }));
                            print(HakAkses.hakaksesSubmenuComcek);

                            // } else if(e == 'idcash.ramayanariwayattransaksi'){
                            // Navigator.push(context, MaterialPageRoute(builder: (context){
                            //   return Anakan(); }));
                            //   SharedPreferences pref = await SharedPreferences.getInstance();
                            //   var hakAkses = pref.setString('hakAkses', '${e}');
                            //   print('hak akses : ${e}}');
                            //   print('hak akses : ${hakAkses}');
                          } else {
                            print('e');
                          }
                          if (_isConnected == true) {
                            print('is connect');
                            AndroidDeviceInfo info =
                                await deviceInfo.androidInfo;
                            var formData = FormData.fromMap({
                              'progname': 'RALS_TOOLS ',
                              'versi': '${versi}',
                              'date_run': '${DateTime.now()}',
                              'info1': '${getName()} ',
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
                          } else if (_isConnected == false) {
                            String format =
                                DateFormat.Hms().format(DateTime.now());
                            print('not connect');
                            db.saveActivityy(LogOffline(
                              deskripsi: '${getName()} ',
                              datetime: '${DateTime.now()}',
                            ));
                          }
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${getName()}',
                      style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w500,
                          textStyle: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 71, 70, 70))),
                    )
                  ]);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    ).show();
    return;
  }

  @override
  Widget build(BuildContext context) {
    if (_isConnected == false) {
      // print('not connected');
      LogOffline.listActivity.forEach((element) async {
        // print('${element.datetime}');
      });
    } else {
      LogOffline.listActivity.forEach((element) async {
        AndroidDeviceInfo info = await deviceInfo.androidInfo;
        var formData = FormData.fromMap({
          'progname': 'RALS_TOOLS ',
          'versi': '${versi}',
          'date_run': '${element.datetime}',
          'info1': '${element.deskripsi}',
          ' info2': '${imei} ',
          'userid': '${userData.getUsernameID()}',
          ' toko': '${userData.getUserToko()}',
          ' devicename': '${info.device}',
          'TOKEN': 'R4M4Y4N4'
        });
        var response =
            await dio.post('${tipeurl}v1/activity/createmylog', data: formData);
        // print('berhasil $_udid');
        // print('success');
        // print(formData);
        // print('delete');
        await db.deleteActivityy(element.id_act!);
      });
    }
    var listmneu = '${userData.getListMenu()}';
    List split = listmneu.split('|');
    double c_width = MediaQuery.of(context).size.width * 0.8;
    data = [];
    for (var element in split) {
      if (element == 'masteridcash.idcash') {
        data.add(element);
      }
      if (element == 'mastervoid.void') {
        data.add(element);
        //  } if (element == 'approvalreturn.approvalreturn') {
        // data.add(element);
        // } if (element == 'cekprice.cekprice') {
        //   data.add(element);
      }
      if (element == 'tukarpoin.tukarpoin') {
        data.add(element);
      }
      if (element == 'myactivity.activity') {
        data.add(element);
      }
      if (element == 'suratjalan.trackingsj') {
        data.add(element);
      }
      if (element == 'comchek.approvedcomchek') {
        data.add(element);
        HakAkses.hakaksesSubmenuComcek.add(element);
      }
      if (element == 'comchek.historycomchek') {
        HakAkses.hakaksesSubmenuComcek.add(element);
      }
      if (element == 'homepage.news') {
        setState(() {
          news = true;
        });
      }
      if (element == 'homepage.mylisttask') {
        setState(() {
          mylisttask = true;
        });
      }
    }
    if (data.length < 5) {
      data3Menu = data;
    } else {
      data3Menu = data.sublist(0, 4);
    }

    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            selectedIconTheme: IconThemeData(color: Colors.white, size: 35),
            selectedItemColor: Colors.white,
            unselectedIconTheme: IconThemeData(
                color: Color.fromARGB(255, 216, 216, 216), size: 25),
            unselectedItemColor: Color.fromARGB(255, 216, 216, 216),
            selectedLabelStyle: GoogleFonts.plusJakartaSans(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
            unselectedLabelStyle:
                GoogleFonts.plusJakartaSans(fontSize: 11, color: Colors.grey),
            currentIndex: _selectedIndex, //New
            onTap: _onItemTapped,
            backgroundColor: Color.fromARGB(255, 210, 14, 0),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(IconlyBold.logout),
                label: 'LOG OUT',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconlyBold.home),
                label: 'HOME',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconlyBold.profile),
                label: 'PROFILE',
              ),
            ],
          ),
          backgroundColor: Theme.of(context).canvasColor,
          extendBody: true,
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 210, 14, 0),
            elevation: 0,
            toolbarHeight: 1,
          ),
          body: ListView(
            children: [
              InkWell(
                onTap: () async {
                  await _checkInternetConnection();
                },
                child: Container(
                  color: Color.fromARGB(255, 245, 245, 245),
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
                              color: Color.fromARGB(255, 210, 14, 0),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 0, left: 20),
                                child: Text(
                                  'Welcome',
                                  style: GoogleFonts.plusJakartaSans(
                                      textStyle: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white)),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, right: 20),
                                child: CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 210, 14, 0),
                                  radius: 40,
                                  backgroundImage: AssetImage(
                                    'assets/profil.jpeg',
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 70, left: 20),
                            child: AnimatedTextKit(
                              isRepeatingAnimation: true,
                              repeatForever: true,
                              //       animatedTexts: [
                              //         WavyAnimatedText('Halo ${userData.getFullname()}',
                              //  speed: Duration(milliseconds: 100),
                              //  textStyle: GoogleFonts.mukta(
                              //    textStyle: TextStyle(
                              //      fontSize: 20,
                              //      color: Colors.white)
                              //  ),
                              //  ),

                              //       ]

                              animatedTexts: [
                                FadeAnimatedText(
                                  'Halo ${userData.getFullname()}',
                                  textStyle: GoogleFonts.mukta(
                                      textStyle: TextStyle(
                                          fontSize: 20, color: Colors.white)),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(top: 130, left: 20, right: 20),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'My Activity Menu',
                                        style: GoogleFonts.plusJakartaSans(
                                            textStyle: TextStyle(
                                                fontSize: 20,
                                                color: Color.fromARGB(
                                                    255, 71, 70, 70))),
                                      ),
                                      data.length > 4
                                          ? Container(
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        Colors.red,
                                                        Color.fromARGB(
                                                            255, 103, 94, 94)
                                                      ],
                                                      begin: FractionalOffset(
                                                          0.0, 0.0),
                                                      end: FractionalOffset(
                                                          1.5, 0.0),
                                                      stops: [0.0, 1.0],
                                                      tileMode: TileMode.clamp),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          90)),
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    foregroundColor:
                                                        Colors.black,
                                                    elevation: 0,
                                                  ),
                                                  onPressed: () async {
                                                    alertMenu();
                                                  },
                                                  child: Text(
                                                    'More >>>',
                                                    style: GoogleFonts
                                                        .plusJakartaSans(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.white),
                                                  )))
                                          : Container()
                                    ],
                                  ),
                                ),

                                // ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                                  child: Wrap(
                                    // spacing: 0.5,
                                    // runSpacing: 1.0,
                                    alignment: WrapAlignment.spaceBetween,
                                    runAlignment: WrapAlignment.spaceBetween,
                                    //adel ini gausah di masukin ke model bisa gaa? langsung aja dia pake api nya nembak langsung
                                    children: data3Menu.map((e) {
                                      // ${e.nsadssaame_menu}
                                      print(e);

                                      getIcon() {
                                        var icon = '${e}';
                                        if (icon == 'mastervoid.void') {
                                          return Visibility(
                                            child: CircleAvatar(
                                              backgroundColor: Color.fromARGB(
                                                  255, 207, 11, 11),
                                              radius: 30,
                                              backgroundImage: AssetImage(
                                                'assets/void.png',
                                              ),
                                            ),
                                            visible: true,
                                          );
                                        } else if (icon ==
                                            "masteridcash.idcash") {
                                          return Visibility(
                                            child: CircleAvatar(
                                              backgroundColor: Color.fromARGB(
                                                  255, 207, 11, 11),
                                              radius: 30,
                                              backgroundImage: AssetImage(
                                                'assets/ic_idcash.png',
                                              ),
                                            ),
                                            visible: true,
                                          );
                                        } else if (icon ==
                                            "approvalreturn.approvalreturn") {
                                          return Visibility(
                                            child: CircleAvatar(
                                              backgroundColor: Color.fromARGB(
                                                  255, 207, 11, 11),
                                              radius: 30,
                                              backgroundImage: AssetImage(
                                                'assets/approval.png',
                                              ),
                                            ),
                                            visible: true,
                                          );
                                        } else if (icon ==
                                            "cekprice.cekprice") {
                                          return Visibility(
                                            child: CircleAvatar(
                                              backgroundColor: Color.fromARGB(
                                                  255, 207, 11, 11),
                                              radius: 30,
                                              backgroundImage: AssetImage(
                                                'assets/cekharga.png',
                                              ),
                                            ),
                                            visible: true,
                                          );
                                        } else if (icon ==
                                            "tukarpoin.tukarpoin") {
                                          return Visibility(
                                            child: CircleAvatar(
                                              backgroundColor: Color.fromARGB(
                                                  255, 207, 11, 11),
                                              radius: 30,
                                              backgroundImage: AssetImage(
                                                'assets/tukarpoin.png',
                                              ),
                                            ),
                                            visible: true,
                                          );
                                        } else if (icon ==
                                            "myactivity.activity") {
                                          return Visibility(
                                            child: CircleAvatar(
                                              backgroundColor: Color.fromARGB(
                                                  255, 207, 11, 11),
                                              radius: 30,
                                              backgroundImage: AssetImage(
                                                'assets/myactivity.png',
                                              ),
                                            ),
                                            visible: true,
                                          );
                                        } else if (icon ==
                                            "suratjalan.trackingsj") {
                                          return Visibility(
                                            child: CircleAvatar(
                                              backgroundColor: Color.fromARGB(
                                                  255, 207, 11, 11),
                                              radius: 30,
                                              backgroundImage: AssetImage(
                                                'assets/sjalan.png',
                                              ),
                                            ),
                                            visible: true,
                                          );
                                        } else if (icon ==
                                            "comchek.approvedcomchek") {
                                          return Visibility(
                                            child: CircleAvatar(
                                              backgroundColor: Color.fromARGB(
                                                  255, 207, 11, 11),
                                              radius: 30,
                                              backgroundImage: AssetImage(
                                                'assets/comcek.png',
                                              ),
                                            ),
                                            visible: true,
                                          );
                                        } else {
                                          Visibility(
                                            child: CircleAvatar(
                                              backgroundColor: Color.fromARGB(
                                                  255, 207, 11, 11),
                                              radius: 30,
                                              backgroundImage: AssetImage(
                                                'assets/cekharga.png',
                                              ),
                                            ),
                                            visible: true,
                                          );
                                        }
                                      }

                                      getName() {
                                        var icon = '${e}';
                                        if (icon == 'mastervoid.void') {
                                          return 'Void';
                                        } else if (icon ==
                                            "masteridcash.idcash") {
                                          return 'Id Cash';
                                        } else if (icon ==
                                            "cekprice.cekprice") {
                                          return 'Cek Harga';
                                        } else if (icon ==
                                            "approvalreturn.approvalreturn") {
                                          return 'Approval Return';
                                        } else if (icon ==
                                            "tukarpoin.tukarpoin") {
                                          return 'Tukar Poin';
                                        } else if (icon ==
                                            "myactivity.activity") {
                                          return 'My Activity';
                                        } else if (icon ==
                                            "suratjalan_trackingsj") {
                                          return 'Tracking SJ';
                                        } else if (icon ==
                                            "comchek.approvedcomchek") {
                                          return 'Com. Checking';
                                        } else {
                                          print(e);
                                          print('no menu');
                                        }
                                      }

                                      return Column(children: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.transparent,
                                              foregroundColor: Colors.black,
                                              elevation: 0,
                                            ),
                                            child: getIcon(),
                                            onPressed: () async {
                                              await _checkInternetConnection();
                                              print('haiiioooo');
                                              if (e == 'mastervoid.void') {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return RamayanaVoid();
                                                }));
                                              } else if (e ==
                                                  'masteridcash.idcash') {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return RamayanaIDCash();
                                                }));
                                              } else if (e ==
                                                  'approvalreturn.approvalreturn') {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return RamayanaApprovalReturn();
                                                }));
                                              } else if (e ==
                                                  'cekprice.cekprice') {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return RamayanaCariToko();
                                                }));
                                              } else if (e ==
                                                  'tukarpoin.tukarpoin') {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return RamayanaTukarPoin();
                                                }));
                                              } else if (e ==
                                                  'myactivity.activity') {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return RamayanaMyActivity();
                                                }));
                                              } else if (e ==
                                                  'suratjalan_trackingsj') {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return RamayanaSuratJalan();
                                                }));
                                              } else if (e ==
                                                  'comchek.approvedcomchek') {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return RamayanaCompetitorCek();
                                                }));
                                                print(HakAkses
                                                    .hakaksesSubmenuComcek);

                                                // } else if(e == 'idcash.ramayanariwayattransaksi'){
                                                // Navigator.push(context, MaterialPageRoute(builder: (context){
                                                //   return Anakan(); }));
                                                //   SharedPreferences pref = await SharedPreferences.getInstance();
                                                //   var hakAkses = pref.setString('hakAkses', '${e}');
                                                //   print('hak akses : ${e}}');
                                                //   print('hak akses : ${hakAkses}');
                                              } else {
                                                print('e');
                                              }
                                              if (_isConnected == true) {
                                                print('is connect');
                                                AndroidDeviceInfo info =
                                                    await deviceInfo
                                                        .androidInfo;
                                                var formData =
                                                    FormData.fromMap({
                                                  'progname': 'RALS_TOOLS ',
                                                  'versi': '${versi}',
                                                  'date_run':
                                                      '${DateTime.now()}',
                                                  'info1': '${getName()} ',
                                                  ' info2': '${imei} ',
                                                  'userid':
                                                      '${userData.getUsernameID()}',
                                                  ' toko':
                                                      '${userData.getUserToko()}',
                                                  ' devicename':
                                                      '${info.device}',
                                                  'TOKEN': 'R4M4Y4N4'
                                                });

                                                var response = await dio.post(
                                                    '${tipeurl}v1/activity/createmylog',
                                                    data: formData);

                                                print('berhasil $_udid');
                                              } else if (_isConnected ==
                                                  false) {
                                                String format = DateFormat.Hms()
                                                    .format(DateTime.now());
                                                print('not connect');
                                                db.saveActivityy(LogOffline(
                                                  deskripsi: '${getName()} ',
                                                  datetime: '${DateTime.now()}',
                                                ));
                                              }
                                            }),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '${getName()}',
                                          style: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.w500,
                                              textStyle: TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromARGB(
                                                      255, 71, 70, 70))),
                                        )
                                      ]);
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 330),
                            child: Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: news
                                        ? Column(
                                            children: [
                                              Container(
                                                height: 50,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 20,
                                                      right: 20,
                                                      top: 0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Informasi Update Ramayana',
                                                        style: GoogleFonts.plusJakartaSans(
                                                            textStyle: TextStyle(
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ),
                                                      Container(
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                              gradient: LinearGradient(
                                                                  colors: [
                                                                    Colors.red,
                                                                    Color
                                                                        .fromARGB(
                                                                            255,
                                                                            103,
                                                                            94,
                                                                            94)
                                                                  ],
                                                                  begin: FractionalOffset(
                                                                      0.0, 0.0),
                                                                  end: FractionalOffset(
                                                                      1.5, 0.0),
                                                                  stops: [
                                                                    0.0,
                                                                    1.0
                                                                  ],
                                                                  tileMode: TileMode
                                                                      .clamp),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          90)),
                                                          margin: EdgeInsets.only(
                                                              right: 10),
                                                          child: ElevatedButton(
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                foregroundColor:
                                                                    Colors
                                                                        .black,
                                                                elevation: 0,
                                                              ),
                                                              onPressed: () async {
                                                                Navigator.pushAndRemoveUntil(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                RamayanaInformasi()),
                                                                    (route) =>
                                                                        false);
                                                              },
                                                              child: Text(
                                                                'View All',
                                                                style: GoogleFonts
                                                                    .plusJakartaSans(
                                                                        fontSize:
                                                                            15,
                                                                        color: Colors
                                                                            .white),
                                                              )))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    20, 0, 20, 0),
                                                child: Column(
                                                  children: [
                                                    SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(
                                                        children:
                                                            News.news3.map((e) {
                                                          var stringHtml =
                                                              '${e.berita_dtl}';
                                                          return InkWell(
                                                            onTap: () {
                                                              News.newsDetail
                                                                  .clear();
                                                              setState(() {
                                                                News.newsDetail
                                                                    .add(e);
                                                                print(News
                                                                    .newsDetail);
                                                              });
                                                              Navigator.pushAndRemoveUntil(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) {
                                                                return NewsDetail();
                                                              }),
                                                                  (route) =>
                                                                      false);
                                                              print(
                                                                  'navigator');
                                                            },
                                                            child: Container(
                                                              width: 400,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          10,
                                                                      right:
                                                                          20),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: Colors
                                                                    .white,
                                                              ),

                                                              // height: 165,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    // height: 150
                                                                    child: ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10),
                                                                        child: Image.network(
                                                                            '${e.url_photo}',
                                                                            fit:
                                                                                BoxFit.cover)),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .fromLTRB(
                                                                            10,
                                                                            10,
                                                                            0,
                                                                            15),
                                                                    child: Text(
                                                                        '${e.berita_hdr}',
                                                                        style: GoogleFonts.plusJakartaSans(
                                                                            fontSize:
                                                                                17,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            color: Colors.black)),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children:
                                                          News.news3.map((e) {
                                                        return GestureDetector(
                                                          onTap: () =>
                                                              _controller
                                                                  .animateToPage(
                                                                      1),
                                                          child: Container(
                                                            width: 12.0,
                                                            height: 10.0,
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        15.0,
                                                                    horizontal:
                                                                        4.0),
                                                            decoration:
                                                                BoxDecoration(
                                                                    // color: Colors.green,
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: (Theme.of(context).brightness == Brightness.dark
                                                                            ? Colors
                                                                                .white
                                                                            : Colors
                                                                                .black)
                                                                        .withOpacity(_current ==
                                                                                e
                                                                            ? 0.9
                                                                            : 0.4)),
                                                          ),
                                                        );
                                                      }).toList(),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container()),
                                Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: mylisttask
                                        ? Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 0,
                                                    left: 20,
                                                    right: 20),
                                                // color: Colors.green,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'My List Task',
                                                          style: GoogleFonts.plusJakartaSans(
                                                              textStyle: TextStyle(
                                                                  fontSize: 22,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                        ),
                                                        Text(
                                                          ' (${total_task == null ? '' : total_task})',
                                                          style: GoogleFonts.plusJakartaSans(
                                                              textStyle: TextStyle(
                                                                  fontSize: 22,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          0,
                                                                          0),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                        ),
                                                      ],
                                                    ),
                                                    unread_task == 0 ||
                                                            unread_task == null
                                                        ? Container(
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                gradient: LinearGradient(
                                                                    colors: [
                                                                      Colors
                                                                          .red,
                                                                      Color.fromARGB(
                                                                          255,
                                                                          103,
                                                                          94,
                                                                          94)
                                                                    ],
                                                                    begin:
                                                                        FractionalOffset(
                                                                            0.0,
                                                                            0.0),
                                                                    end: FractionalOffset(
                                                                        1.5, 0.0),
                                                                    stops: [
                                                                      0.0,
                                                                      1.0
                                                                    ],
                                                                    tileMode:
                                                                        TileMode
                                                                            .clamp),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            90)),
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 10),
                                                            child: ElevatedButton(
                                                                style: ElevatedButton.styleFrom(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  foregroundColor:
                                                                      Colors
                                                                          .black,
                                                                  elevation: 0,
                                                                ),
                                                                onPressed: () async {
                                                                  await read_task();
                                                                  print(
                                                                      'read data');
                                                                  Navigator.pushAndRemoveUntil(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                RamayanaMyListTask(),
                                                                      ),
                                                                      (Route<dynamic> route) => false);
                                                                },
                                                                child: Text(
                                                                  'View All',
                                                                  style: GoogleFonts.plusJakartaSans(
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .white),
                                                                )))
                                                        : badge.Badge(
                                                            child: Container(
                                                                height: 38,
                                                                decoration: BoxDecoration(
                                                                    gradient: LinearGradient(
                                                                        colors: [
                                                                          Colors
                                                                              .red,
                                                                          Color.fromARGB(
                                                                              255,
                                                                              103,
                                                                              94,
                                                                              94)
                                                                        ],
                                                                        begin: FractionalOffset(
                                                                            0.0,
                                                                            0.0),
                                                                        end: FractionalOffset(
                                                                            1.5,
                                                                            0.0),
                                                                        stops: [
                                                                          0.0,
                                                                          1.0
                                                                        ],
                                                                        tileMode:
                                                                            TileMode
                                                                                .clamp),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            90)),
                                                                margin:
                                                                    EdgeInsets.only(
                                                                        right:
                                                                            10),
                                                                child: ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      foregroundColor:
                                                                          Colors
                                                                              .black,
                                                                      elevation:
                                                                          0,
                                                                    ),
                                                                    onPressed: () async {
                                                                      await read_task();
                                                                      Navigator.pushAndRemoveUntil(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                RamayanaMyListTask(),
                                                                          ),
                                                                          (Route<dynamic> route) => false);
                                                                    },
                                                                    child: Text(
                                                                      'View All',
                                                                      style: GoogleFonts.plusJakartaSans(
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              Colors.white),
                                                                    ))),
                                                            badgeContent:
                                                                SizedBox(
                                                                    width: 18,
                                                                    height:
                                                                        20, //badge size
                                                                    child:
                                                                        Center(
                                                                      //aligh badge content to center
                                                                      child: Text(
                                                                          "${unread_task == null ? '' : unread_task}",
                                                                          style: TextStyle(
                                                                              color: Colors.white, //badge font color
                                                                              fontSize: 20 //badge font size
                                                                              )),
                                                                    )),
                                                            badgeColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    67,
                                                                    67), //badge background color
                                                          )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                    top: 10,
                                                    left: 20,
                                                    right: 20,
                                                  ),
                                                  child: Column(
                                                      children: TaskHome
                                                          .taskhome
                                                          .map((e) {
                                                    print('${e.project_id}');
                                                    return Container(
                                                      height: 90,
                                                      margin: EdgeInsets.only(
                                                          bottom: 10),
                                                      decoration: BoxDecoration(
                                                          boxShadow: <BoxShadow>[
                                                            BoxShadow(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        197,
                                                                        197,
                                                                        197),
                                                                blurRadius: 1,
                                                                spreadRadius: 1,
                                                                offset: Offset(
                                                                    2, 2))
                                                          ],
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: ListTile(
                                                        leading: CircleAvatar(
                                                            backgroundColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    210,
                                                                    14,
                                                                    0),
                                                            radius: 30,
                                                            backgroundImage:
                                                                AssetImage(
                                                                    'assets/todolist.png')),
                                                        // title: Text('${e.task_desc}', style: GoogleFonts.plusJakartaSans(
                                                        //   fontSize: 18, color: Colors.black
                                                        // ),),
                                                        subtitle: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(top: 3),
                                                              child: Text(
                                                                '${e.task_desc}',
                                                                style: GoogleFonts.plusJakartaSans(
                                                                    fontSize:
                                                                        18,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  width: 80,
                                                                  child: Text(
                                                                      'Status',
                                                                      style: GoogleFonts.plusJakartaSans(
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              Colors.grey)),
                                                                ),
                                                                Text(
                                                                    ': ${e.task_status}',
                                                                    style: GoogleFonts.plusJakartaSans(
                                                                        fontSize:
                                                                            15,
                                                                        color: Colors
                                                                            .grey)),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  width: 80,
                                                                  child: Text(
                                                                      'Project ID',
                                                                      style: GoogleFonts.plusJakartaSans(
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              Colors.grey)),
                                                                ),
                                                                Text(
                                                                    ': ${e.project_id}',
                                                                    style: GoogleFonts.plusJakartaSans(
                                                                        fontSize:
                                                                            15,
                                                                        color: Colors
                                                                            .grey)),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }).toList())),
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
          ));
    });
  }
}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - size.width / 4, size.height, size.width,
        size.height - 100);
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

class _FadeInImageWidgetState extends State<FadeInImageWidget>
    with TickerProviderStateMixin {
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
      height: 250,
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
