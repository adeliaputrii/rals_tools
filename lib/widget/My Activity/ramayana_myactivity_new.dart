part of 'import.dart';

class RamayanaMyActivity extends StatefulWidget {
  RamayanaMyActivity({
    super.key, 
    this.response, 
    this.projectId, 
    this.projectDesc, 
    this.taskId,
    this.taskDesc,
    this.status
    });

  final GetTaskResponse.Data? response;
  final String? projectId;
  final String? projectDesc;
  final String? taskId;
  final String? taskDesc;
  final String? status;

  @override
  State<RamayanaMyActivity> createState() => _RamayanaMyActivityState();
}

class _RamayanaMyActivityState extends State<RamayanaMyActivity> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  TextEditingController date = TextEditingController();
  TextEditingController timeStart = TextEditingController();
  TextEditingController timeEnd = TextEditingController();
  TextEditingController project = TextEditingController();
  TextEditingController task = TextEditingController();
  TextEditingController desc = TextEditingController();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  UserData userData = UserData();
  bool _loadingPath = false;
  bool _loadingSpinkit = false;
  var apiTask = 'P202300001';
  bool up = false;
  bool sendDataApi = false;
  String _udid = 'Unknown';
  var dokumen = '';
  var infoTask = '';
  bool uploadEdit = false;
  bool iniApiEdit = false;
  bool iniApiSave = false;
  bool edit = false;
  String? _fileName;
  List<PlatformFile>? _paths;
  // final File fileForFirebase = File(_path.path);
  String? _directoryPath;
  var selected = 'Reguler';
  late int idEdit;
  File? file;
  int intJoinStart = 0;
  String? nameFile;
  var token = '';
  String paths = '';
  String dokumenEdit = '';
  var projectId = '';
  var taskId = '';
  var taskId2 = '';
  var taskId3 = '';
  List<String> result = [];
  List<String> resultEdit = [];
  List<String> resultProject = [];
  var selectedTask = 'My Task';
  String? _extension;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTimeStart = TimeOfDay.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String? _setDate;
  Dio dio = Dio();

  String formattedDate = DateFormat('d MMMM yyyy').format(DateTime.now());
  String dateInput = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  String formattedTime = DateFormat('HH:mm').format(DateTime.now());
  final urlApi = '${tipeurl}${basePath.api_login}';
  late MyActivityCubit cubit;
  late LoginCubit loginCubit;

  DateTime dateTimeSelected = DateTime.now();
  DateTime dateTimeSelectedEnd = DateTime.now();

  void _openTimePickerSheet(BuildContext context) async {
    final result = await TimePicker.show<DateTime?>(
      context: context,
      sheet: TimePickerSheet(
        initialDateTime: dateTimeSelected,
        minuteInterval: 1,
        twoDigit: true,
        sheetTitle: 'Pilih Waktu',
        minuteTitle: 'Menit',
        hourTitle: 'Jam',
        saveButtonText: 'Simpan',
        saveButtonColor : baseColors.primaryColor,
        sheetCloseIconColor : baseColors.primaryColor,
        sheetTitleStyle : GoogleFonts.plusJakartaSans(fontSize: 23, color: Colors.black),
        hourTitleStyle : GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black),
        minuteTitleStyle : GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black),
        wheelNumberItemStyle :  GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black),
        wheelNumberSelectedStyle : GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black),
      ),
    );
    if (result != null) {
      setState(() {
        dateTimeSelected = result;
      });
    }
  }

  void _openTimePickerSheetEnd(BuildContext context) async {
    final resultEnd = await TimePicker.show<DateTime?>(
      context: context,
      sheet: TimePickerSheet(
        initialDateTime: dateTimeSelectedEnd,
        minuteInterval: 1,
        twoDigit: true,
        sheetTitle: 'Pilih Waktu',
        minuteTitle: 'Menit',
        hourTitle: 'Jam',
        saveButtonText: 'Simpan',
        saveButtonColor : baseColors.primaryColor,
        sheetCloseIconColor : baseColors.primaryColor,
        sheetTitleStyle : GoogleFonts.plusJakartaSans(fontSize: 23, color: Colors.black),
        hourTitleStyle : GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black),
        minuteTitleStyle : GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black),
        wheelNumberItemStyle :  GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black),
        wheelNumberSelectedStyle : GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black),
      ),
    );

    if (resultEnd != null) {
      setState(() {
        dateTimeSelectedEnd = resultEnd;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    cubit = context.read<MyActivityCubit>();
    loginCubit = context.read<LoginCubit>();
    iniApiEdit;
    _loadingSpinkit;
  }

  void setData(GetTaskResponse.Data? response) {
    if (response != null) {
      cubit.getProject();
      cubit.getTaskById(widget.response!.projectId!);
      date.text = response.dateCreate.toString();
      // desc.text = response.taskDesc.toString();
      // timeStart.text = response.taskStart.toString();
      // timeEnd.text = response.taskClose.toString();
    }
  }

  void _loadData() async {
    setState(() {
      _loadingSpinkit = true;
    });
    try {
      popupEdit();
      await Future.delayed(const Duration(seconds: 3));
      MyactivityModelTask.myactivitytask.clear();
      result.clear();
      fetchEdit(user_create: '${userData.getUsername7()}');
      fetchProject();
      result.clear();
      MyactivityModelTask.addselectTask.clear();
      resultEdit.clear();
      MyactivityModelTask.addselectTaskEdit.clear();
      _loadingPath = false;
      print(edit);
      print('iniApiEdit : ${iniApiEdit}');
      iniApiEdit = false;
      fetchProject();
      fetchTask(apiProject: '${apiTask}');
      print('HasilTask : ${result}');
      print('HasilTask2 : ${MyactivityModelTask.addselectTask}');
      // popupEdit();
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingSpinkit = false;
      print('delay');
    });
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

  _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserData userData = UserData();
    print('token ${prefs.getString('token')}');
    setState(() {
      token = userData.getUserToken();
    });
    return token;
  }

  //---------------------------------------------------POP UP----------------------------------------------------------
  popUpTaskStatus() {
    AlertDialog popup = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      // shadowColor: Colors.black,
      titlePadding: EdgeInsets.only(top: 20),
      title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          // height: 370,
          width: 500,
          child: Image.asset(
            'assets/statusTask.png',
            height: 200,
          )),
      content: Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 200,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text('PIlih Status Tugas',
                style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500
                ),
                ),
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18)),
              minWidth: 350,
              height: 40,
              color: Colors.blue,
              onPressed: (){
                getStatusTask('Open');
              },
              child: Text('Open',
              style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.white
              ),
              )),
              MaterialButton(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18)),
              minWidth: 350,
              height: 40,
              color: Colors.green,
              onPressed: (){
               getStatusTask('Progress');
              },
              child: Text('Progress',
              style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.white
              ),
              )),
              MaterialButton(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18)),
              minWidth: 350,
              height: 40,
              color: Colors.cyan,
              onPressed: (){
                getStatusTask('Verification');
              },
              child: Text('Verification',
              style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.white
              ),
              ))
          ],
        )
      ),
      actionsAlignment: MainAxisAlignment.start,
      actionsPadding: EdgeInsets.only(bottom: 20),
    );
    showCupertinoModalPopup(context: context, builder: (context) => popup);
  }
  popUpSuccess() {
    AlertDialog popupSucc = AlertDialog(
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
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.start,
      actionsPadding: EdgeInsets.only(bottom: 20),
    );
    showCupertinoModalPopup(context: context, builder: (context) => popupSucc);
  }

  popupFormat() {
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
            'Format Harus .jpg/.jpeg/.png/.docx/.xlsx/.pdf',
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.start,
      actionsPadding: EdgeInsets.only(bottom: 20),
    );
    showCupertinoModalPopup(context: context, builder: (context) => popup1);
  }

  popupEdit() {
    AlertDialog popup1 = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      // shadowColor: Colors.black,
      titlePadding: EdgeInsets.all(0),
      title: Container(
        decoration: BoxDecoration(
          // color: Colors.green,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        height: 600,
        width: 2000,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20,),
              height: 220,
              child: FadeInImageWidget(imageUrl: 'assets/edit.png',)
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text('Pilih Tugas',
                      style: GoogleFonts.plusJakartaSans(fontSize: 20, color: Color.fromARGB(255, 135, 11, 2))
                      ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<MyActivityCubit, MyActivityState>(builder: (context, state) {
            if (state is MyActivityLoading) {
              return SpinKitThreeBounce(
                color: Color.fromARGB(255, 230, 0, 0),
                size: 50.0,
              );
            }
            if (state is MyActivityEditSuccess) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.response.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.fromLTRB(20, 2, 20, 10),
                    height: 70, 
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white, 
                    ),
                    child: ListTile(
                      leading: Image.asset('assets/tasklist.png',
                      height: 50,
                      ),
                      title: Text('${state.response.data?[index].myactivityDesc}',
                      style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Colors.black
                    ),
                      overflow: TextOverflow.ellipsis,
                    ),
                      subtitle: Text('${state.response.data?[index].timeStart}s/d${state.response.data?[index].timeEnd}',
                      style: GoogleFonts.plusJakartaSans(fontSize: 15, color: Colors.grey)
                      ),
                    ),
                  );
                }
              );
              }
            return Container();
          }),
            )
          ],
        ),
      ),

      actionsAlignment: MainAxisAlignment.start,
      actionsPadding: EdgeInsets.only(bottom: 20),
    );
    showCupertinoModalPopup(context: context, builder: (context) => popup1);
  }

  //------------------------------------------------------------------------------------------------------

  //---------------------------------------------API------------------------------------------------------

  fetchProject() async {
    resultProject.clear();
    _loadToken();
    print('ini token1111 : $token');
    MyactivityModel.myactivitymodel.clear();
    // cubit.getProject();
    // cubit.getTaskById(apiTask);
    final responseku = await http
        .get(Uri.parse('${tipeurl}v1/activity/list-project'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print('ini token2222 : $token');
    final responseku2 = await http
        .get(Uri.parse('${tipeurl}v1/activity/list-project'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var data = jsonDecode(responseku2.body);
    print('respone : ${responseku2}');
    print('data : ${data}');
    if (data['status'] == 200) {
      print("API Success");
      print(data);
      int count = data['data'].length;
      final Map<String, MyactivityModel> profileMap = new Map();
      for (int i = 0; i < count; i++) {
        MyactivityModel.myactivitymodel
            .add(MyactivityModel.fromjson(data['data'][i]));
        MyactivityModel.myactivitymodel.forEach((element) {
          MyactivityModel.addSelect.add('${element.project_desc}');
          print(MyactivityModel.addSelect);
          resultProject =
              LinkedHashSet<String>.from(MyactivityModel.addSelect).toList();
        });
        debugPrint('result Project' + resultProject.toString());
        if (iniApiSave == true) {
          selected = 'Reguler';
        }
      }

      print('check length ${MyactivityModel.myactivitymodel.length}');
      print(data['data'].toString());
      if (data['status'] != 200) {
        print('data[status] ${data['status']}');
      }
    } else {
      print('NO DATA');
      print('data[status] ${data['status']}');
    }
    if (mounted) {
      setState(() {});
    }
  }

  fetchTask({required String apiProject}) async {
    result.clear;
    _loadToken();
    MyactivityModelTask.myactivitytask.clear();
    MyactivityModelTask.addselectTaskEdit.clear;
    MyactivityModelTask.addselectTask.clear();
    print('coba disini');
    final responseku = await http.get(
      Uri.parse('${tipeurl}v1/activity/list-task?project_id=${apiTask}'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print('ini token : $token');
    final responseku2 = await http.get(
      Uri.parse('${tipeurl}v1/activity/list-task?project_id=${apiTask}'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    var data = jsonDecode(responseku2.body);
    print('respone : ${responseku2}');
    print('data : ${data}');
    if (data['status'] == 200) {
      print("API Success");
      print(data);
      int count = data['data'].length;
      for (int i = 0; i < count; i++) {
        MyactivityModelTask.myactivitytask
            .add(MyactivityModelTask.fromjson(data['data'][i]));
        MyactivityModelTask.myactivitytask.forEach((element) {
          if (iniApiEdit == true) {
            MyactivityModelTask.addselectTaskEdit.add('${element.task_desc}');
            print('MyactivityModelTask.addselectTask');
            print(MyactivityModelTask.addselectTask);

            resultEdit = LinkedHashSet<String>.from(
                    MyactivityModelTask.addselectTaskEdit)
                .toList();
            if (taskId2 == element.task_id) {
              taskId3 = element.task_desc;
              selectedTask = '${taskId3}';
            }
            print('resulttttttttttt : ${taskId2}');
            print('resulttttttttttt : ${taskId3}');
          } else {
            MyactivityModelTask.addselectTask.add('${element.task_desc}');
            print('MyactivityModelTask.addselectTask');
            print(MyactivityModelTask.addselectTask);
            result =
                LinkedHashSet<String>.from(MyactivityModelTask.addselectTask)
                    .toList();
            print('result : ${result}');
            selectedTask = '${result.elementAt(0)}';
          }
        });
      }
      print('check length ${MyactivityModelTask.myactivitytask.length}');
      print(data['data'].toString());
    } else {
      print('NO DATA');
    }
    if (mounted) {
      setState(() {});
    }
  }

  fetchEdit({required String user_create}) async {
    MyactivityEditModel.myactivityedit.clear();
    final responseku = await http.post(
        Uri.parse('${tipeurl}v1/activity/clock_daily_activity'),
        body: {'user_create': '${user_create}'});

    var data = jsonDecode(responseku.body);

    if (data['status'] == 200) {
      print("API Success");
      print(data);
      int count = data['data'].length;
      final Map<String, MyactivityEditModel> profileMap = new Map();
      for (int i = 0; i < count; i++) {
        MyactivityEditModel.myactivityedit
            .add(MyactivityEditModel.fromjson(data['data'][i]));
      }
      MyactivityEditModel.myactivityedit.forEach((element) {
        profileMap[element.myactivity_desc] = element;
        MyactivityEditModel.myactivityedit = profileMap.values.toList();
        print(MyactivityEditModel.myactivityedit);
      });
      print('check length ${MyactivityEditModel.myactivityedit.length}');
      print(data['data'].toString());
    } else {
      print('NO DATA');
    }
  }

  //----------------------------------------------------------------------------------------------------------------

  getDataApi() {
    MyactivityEditModel.myactivityedit.forEach((element) {});
  }

  Future<void> requestPermission() async {
    final permission = Permission.storage;
    print('permission');
    await notifPermission
        .NotificationPermissions.requestNotificationPermissions;
    await notifPermission.NotificationPermissions
        .getNotificationPermissionStatus();
    await Permission.manageExternalStorage.request();

    final result = await permission.request();

    if (result == PermissionStatus.denied) {
      final requestStorageAgain = await Permission.storage.request();
      ("result permission $requestStorageAgain");
      if (requestStorageAgain == PermissionStatus.denied) {
        throw Exception("Permission Storage is need");
      }
    }
    if (Platform.isIOS) {
      bool storage = await Permission.storage.status.isGranted;
      if (storage) {
        // Awesome
      } else {
        // Crap
      }
    } else {
      bool storage = true;
      bool videos = true;
      bool photos = true;

      // Only check for storage < Android 13
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        print('diatas 33');
        print(Permission.photos.status);
        videos = await Permission.videos.status.isGranted;
        photos = await Permission.photos.status.isGranted;
      } else {
        storage = await Permission.storage.status.isGranted;
      }

      if (storage && videos && photos) {
        // Awesome
      } else {
        // Crap
      }
    }
  }

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      _directoryPath = null;
      uploadEdit = false;

      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: _multiPick,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'xlsx', 'pdf'],
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      print(_paths?.first.extension);

      _fileName =
          _paths != null ? _paths!.map((e) => e.name).toString() : '...';
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DefaultBottomBarController(child: Ramayana()),
                  ),
                  (Route<dynamic> route) => false);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 23,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: Text('My Activity',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 23, color: Colors.white)),
          backgroundColor: baseColors.primaryColor,
          elevation: 5,
          toolbarHeight: 80,
        ),
        body: BlocListener<MyActivityCubit, MyActivityState>(
            listener: (context, state) {
              if (state is MyActivitySuccess) {
                final response = state.response.data;
                response?.forEach((element) {
                  MyactivityModel.myactivitymodel
                      .add(MyactivityModel.fromjson(element.toJson()));
                  setState(() {
                    resultProject.add(element.projectDesc!);
                    if (element.projectId == widget.response!.projectId) {
                      projectId = element.projectId!;
                      selected = element.projectDesc!;
                      debugPrint('selected is ' + projectId);
                    }
                  });
                });

                debugPrint('result Project' + resultProject.toString());
              }
              if (state is MyActivitySuccessTask) {
                final response = state.response.data;
                response?.forEach((element) {
                  setState(() {
                    result.add(element.taskDesc!);
                    if (element.taskId == widget.response?.taskId) {
                      taskId = element.taskId!;
                      selectedTask = element.taskDesc!;
                      debugPrint('selected task is ' + taskId);
                    }
                  });
                });

                debugPrint('result Project' + resultProject.toString());
              }
            },
            child: Stack(children: [
              Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.only(top: 10, left: 30, right: 30),
                  // height: 450,
                  // width: 300,
                  child: ListView(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tanggal',
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFFEFECF1),
                              borderRadius: BorderRadius.circular(25)
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 10
                                    ),
                                  child: Image.asset('assets/calender.png'),
                                ),
                                Text('${formattedDate}',
                                style: GoogleFonts.plusJakartaSans(
                                    fontSize: 17, color: Colors.black),
                                )
                              ],
                            )
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Project',
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFFEFECF1),
                              borderRadius: BorderRadius.circular(25)
                            ),
                            child: 
                            MaterialButton(
                              // color: Colors.amber,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                              onPressed: (){
                                Navigator.push(context, 
                                MaterialPageRoute(builder: (context){
                                  return RamayanaMyActivityProject();
                                }));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 5,
                                          right: 15
                                          ),
                                        child: Image.asset('assets/project.png'),
                                      ),
                                  Text(widget.projectDesc == null ? 'Reguler' : '${widget.projectDesc}',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 17, color: Colors.black),
                                  ),
                                  ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 10
                                      ),
                                    child: Image.asset('assets/dropdown2.png'),
                                  ),
                                ],
                              ),
                            )
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tugas',
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                           Container(
                            margin: EdgeInsets.only(top: 5),
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFFEFECF1),
                              borderRadius: BorderRadius.circular(25)
                            ),
                            child: 
                            MaterialButton(
                              // color: Colors.amber,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                              onPressed: (){
                                if(widget.projectId == null) {
                                  Navigator.push(context, 
                                  MaterialPageRoute(builder: (context){
                                  return RamayanaMyActivityTask(
                                  projectId: 'P202300001',
                                  projectDesc: 'Reguler',
                                  );
                                  }));
                                } else {
                                  Navigator.push(context, 
                                MaterialPageRoute(builder: (context){
                                  return RamayanaMyActivityTask(
                                  projectId: '${widget.projectId}',
                                  projectDesc: '${widget.projectDesc}',
                                  );
                                  }));
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 5,
                                          right: 15
                                          ),
                                        child: Image.asset('assets/task.png'),
                                      ),
                                  Text(widget.taskDesc == null ? 'My Task' : '${widget.taskDesc}',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 17, color: Colors.black),
                                  ),
                                  ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 10
                                      ),
                                    child: Image.asset('assets/dropdown2.png'),
                                  ),
                                ],
                              ),
                            )
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Waktu Mulai',
                                    style: GoogleFonts.plusJakartaSans(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500)),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  width: 150,
                                  height: 40,
                                  child: MaterialButton(
                                    onPressed: () {
                                      _openTimePickerSheet(context);
                                    },
                                    color: Color(0xFFEFECF1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Text('${dateTimeSelected.hour}:${dateTimeSelected.minute}',
                                    style: GoogleFonts.plusJakartaSans(
                                        fontSize: 16,
                                        color: Colors.black,)
                                    ),
                                    ),
                                )
                                
                              ]),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Waktu Selesai',
                                style: GoogleFonts.plusJakartaSans(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500)),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              width: 150,
                              height: 40,
                              child: MaterialButton(
                                onPressed: () {
                                  _openTimePickerSheetEnd(context);
                                },
                                color: Color(0xFFEFECF1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                child: Text('${dateTimeSelectedEnd.hour}:${dateTimeSelectedEnd.minute}',
                                style: GoogleFonts.plusJakartaSans(
                                    fontSize: 16,
                                    color: Colors.black,)
                                ),
                                ),
                            )
                            
                          ]),
                        ],
                      ),

                      SizedBox(
                        height: 15,
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Status Tugas',
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                           Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFFEFECF1),
                              borderRadius: BorderRadius.circular(25)
                            ),
                            child: 
                            MaterialButton(
                              // color: Colors.amber,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                              onPressed: (){
                                popUpTaskStatus();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 10
                                          ),
                                        child: Image.asset('assets/progress.png'),
                                      ),
                                  Text(widget.status == null ? 'Perbarui Status' : widget.status!,
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 17, color: Colors.black),
                                  ),
                                  ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 10
                                      ),
                                    child: Image.asset('assets/dropdown2.png'),
                                  ),
                                ],
                              ),
                            )
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Deskripsi',
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator:
                                RequiredValidator(errorText: ' Please Enter'),
                            controller: desc,
                            maxLines: 7,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              labelText: 'Deskripsi',
                              labelStyle: GoogleFonts.plusJakartaSans(
                                  fontSize: 17, color: Colors.red),
                              prefixIcon: Image.asset('assets/note.png'),
                              // fillColor: Colors.grey[200],
                              filled: true,
                            ),
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 17, color: Colors.black),
                          ),
                        ],
                      ),

                      // -------------------------------------------UPLOAD DOKUMEN ----------------------------------------------
                      SizedBox(height: 10),

                      Builder(
                          builder: (BuildContext context) => uploadEdit
                              ? ListTile(
                                  title: Text(dokumen),
                                )
                              : _loadingPath
                                  ? SpinKitWave(
                                      color: Color.fromARGB(255, 255, 17, 17),
                                      size: 30.0,
                                      duration: Duration(seconds: 10),
                                    )
                                  : _directoryPath != null
                                      ? ListTile(
                                          title: const Text('Directory path'),
                                          subtitle: Text(_directoryPath!),
                                        )
                                      : _paths != null
                                          ? Container(
                                              // padding: const EdgeInsets.only(bottom: 30),
                                              height: 80,
                                              child: Scrollbar(
                                                  child: ListView.separated(
                                                itemCount: _paths != null &&
                                                        _paths!.isNotEmpty
                                                    ? _paths!.length
                                                    : 1,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  final bool isMultiPath =
                                                      _paths != null &&
                                                          _paths!.isNotEmpty;
                                                  nameFile = (isMultiPath
                                                      ? _paths!
                                                          .map((e) => e.name)
                                                          .toList()[index]
                                                      : _fileName ?? '...');
                                                  paths = _paths!
                                                      .map((e) => e.path)
                                                      .toList()[index]
                                                      .toString();

                                                  file = File(paths);
                                                  print(file);

                                                  return ListTile(
                                                    title: Text(
                                                      nameFile!,
                                                    ),
                                                    subtitle: Text(paths),
                                                  );
                                                },
                                                separatorBuilder:
                                                    (BuildContext context,
                                                            int index) =>
                                                        const Divider(),
                                              )),
                                            )
                                          : const SizedBox()),

                      Container(
                        margin: EdgeInsets.only(right: 200),
                        child: MaterialButton(
                          height: 45,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color:Color(0xFFEFECF1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/upload.png'),
                              Text(
                                'Upload Document',
                                style: GoogleFonts.plusJakartaSans(
                                    fontSize: 15, color: Colors.black),
                              )
                            ],
                          ),
                          onPressed: () {
                            // requestPermission(); //dikomennnnn
                            print('dateinput : ${dateInput}');
                            _openFileExplorer();
                          },
                        ),
                      ),

                      SizedBox(height: 20),

                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              minWidth: 1000,
                              height: 50,
                              color: baseColors.primaryColor,
                              onPressed: () async {
                                _loadData();
                              },
                              child: Text(
                                "Edit",
                                style: GoogleFonts.plusJakartaSans(
                                    fontSize: 17, color: Colors.white),
                              ),
                            ),
                            SizedBox(
                        height: 20,
                      ),
                           MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                minWidth: 1000,
                                height: 50,
                                color: baseColors.primaryColor,
                                onPressed: () async {
                                  submitActivity();
                                },
                                child: Text(
                                  "Save",
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 17, color: Colors.white),
                                ),
                              ),
                          ]),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              )
            ])));
  }

   getStatusTask(String text) {
    return Navigator.pushAndRemoveUntil(context,
    MaterialPageRoute(builder: (context) => RamayanaMyActivity(
      status: '$text',
      projectId: widget.projectId ?? 'P202300001',
      projectDesc: widget.projectDesc ?? 'Reguler',
      taskId: widget.taskId ?? 'P202300001-001',
      taskDesc: widget.taskDesc ?? 'My Task',
      )),
      (Route<dynamic> route) => false,);
  }

  submitActivity() {
    final body =
        MyActivityBody(
          user_create: '${userData.getUsername7()}',
          time_start: '${dateTimeSelected}',
          time_end: '${dateTimeSelectedEnd}',
          task_id: '${widget.taskId ?? 'P202300001-001'}',
          projek_id: '${widget.projectId ?? 'P202300001'}',
          myactivity_desc: '${desc.text}',
          myactivity_status: '${widget.status}',
          dokumen: '',
          date_create: '${DateTime.now()}'

        );
    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      text: 'Berhasil',
      confirmBtnText: 'Ya',
      cancelBtnText: 'Tidak',
      confirmBtnColor: Colors.green,
      onConfirmBtnTap: () {
      cubit.submitactivity(body);
        // loginCubit.createLog(
        //   baseParam.logInfoActivityPage, baseParam.logInfoActitySucc, urlApi);
        Navigator.pop(context);
      },
    );
  }
}

