// part of 'import.dart';

// class RamayanaMyActivity extends StatefulWidget {
//   RamayanaMyActivity({super.key, this.response});
//   final GetTaskResponse.Data? response;

//   @override
//   State<RamayanaMyActivity> createState() => _RamayanaMyActivityState();
// }

// class _RamayanaMyActivityState extends State<RamayanaMyActivity> {
//   GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   @override
//   TextEditingController date = TextEditingController();
//   TextEditingController timeStart = TextEditingController();
//   TextEditingController timeEnd = TextEditingController();
//   TextEditingController project = TextEditingController();
//   TextEditingController task = TextEditingController();
//   TextEditingController desc = TextEditingController();
//   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//   UserData userData = UserData();
//   bool _loadingPath = false;
//   bool _loadingSpinkit = false;
//   var apiTask = 'P202300001';
//   bool up = false;
//   bool sendDataApi = false;
//   String _udid = 'Unknown';
//   var dokumen = '';
//   var infoTask = '';
//   bool uploadEdit = false;
//   bool iniApiEdit = false;
//   bool iniApiSave = false;
//   bool edit = false;
//   String? _fileName;
//   List<PlatformFile>? _paths;
//   // final File fileForFirebase = File(_path.path);
//   String? _directoryPath;
//   var selected = 'Reguler';
//   late int idEdit;
//   File? file;
//   int intJoinStart = 0;
//   String? nameFile;
//   var token = '';
//   String paths = '';
//   String dokumenEdit = '';
//   var projectId = '';
//   var taskId = '';
//   var taskId2 = '';
//   var taskId3 = '';
//   List<String> result = [];
//   List<String> resultEdit = [];
//   List<String> resultProject = [];
//   var selectedTask = 'My Task';
//   String? _extension;
//   bool _multiPick = false;
//   FileType _pickingType = FileType.any;
//   DateTime selectedDate = DateTime.now();
//   TimeOfDay selectedTimeStart = TimeOfDay.now();
//   TimeOfDay selectedTime = TimeOfDay.now();
//   String? _setDate;
//   Dio dio = Dio();

//   String formattedDate = DateFormat('d MMMM yyyy').format(DateTime.now());
//   String dateInput = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
//   String formattedTime = DateFormat('HH:mm').format(DateTime.now());
//   final urlApi = '${tipeurl}${basePath.api_login}';
//   late MyActivityCubit cubit;
//   late LoginCubit loginCubit;

//   @override
//   void initState() {
//     super.initState();
//     cubit = context.read<MyActivityCubit>();
//     loginCubit = context.read<LoginCubit>();
//     iniApiEdit;
//     _loadToken();
//     if (widget.response == null) {
//       fetchProject();
//       apiTask;
//       fetchTask(apiProject: '${apiTask}');
//       fetchEdit(user_create: '${userData.getUsername7()}');
//       initPlatformState();
//     } else {
//       setData(widget.response);
//     }
//     _loadingSpinkit;
//   }

//   void setData(GetTaskResponse.Data? response) {
//     if (response != null) {
//       cubit.getProject();
//       cubit.getTaskById(widget.response!.projectId!);
//       date.text = response.dateCreate.toString();
//       // desc.text = response.taskDesc.toString();
//       // timeStart.text = response.taskStart.toString();
//       // timeEnd.text = response.taskClose.toString();
//     }
//   }

//   void _loadData() async {
//     setState(() {
//       _loadingSpinkit = true;
//     });
//     try {
//       popupEdit();
//       await Future.delayed(const Duration(seconds: 3));
//       MyactivityModelTask.myactivitytask.clear();
//       result.clear();
//       fetchEdit(user_create: '${userData.getUsername7()}');
//       fetchProject();
//       result.clear();
//       MyactivityModelTask.addselectTask.clear();
//       resultEdit.clear();
//       MyactivityModelTask.addselectTaskEdit.clear();
//       _loadingPath = false;
//       print(edit);
//       print('iniApiEdit : ${iniApiEdit}');
//       iniApiEdit = false;
//       fetchProject();
//       fetchTask(apiProject: '${apiTask}');
//       print('HasilTask : ${result}');
//       print('HasilTask2 : ${MyactivityModelTask.addselectTask}');
//       // popupEdit();
//     } on PlatformException catch (e) {
//       print("Unsupported operation" + e.toString());
//     } catch (ex) {
//       print(ex);
//     }
//     if (!mounted) return;
//     setState(() {
//       _loadingSpinkit = false;
//       print('delay');
//     });
//   }

//   Future<void> initPlatformState() async {
//     String udid;
//     try {
//       udid = await FlutterUdid.consistentUdid;
//     } on PlatformException {
//       udid = 'Failed to get UDID.';
//     }

//     if (!mounted) return;

//     setState(() {
//       _udid = udid;
//     });
//   }

//   _loadToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     UserData userData = UserData();
//     print('token ${prefs.getString('token')}');
//     setState(() {
//       token = userData.getUserToken();
//     });
//     return token;
//   }

//   //---------------------------------------------------POP UP----------------------------------------------------------
//   popUpSuccess() {
//     AlertDialog popupSucc = AlertDialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),

//       // shadowColor: Colors.black,
//       titlePadding: EdgeInsets.all(0),
//       title: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20),
//               topRight: Radius.circular(20),
//             ),
//           ),
//           height: 170,
//           width: 2000,
//           child: Image.asset(
//             'assets/omaigat.png',
//           )),
//       content: Container(
//         margin: EdgeInsets.only(bottom: 10),
//         height: 30,
//         child: Center(
//           child: Text(
//             'SUCCESS',
//             style: TextStyle(
//                 color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//       actionsAlignment: MainAxisAlignment.start,
//       actionsPadding: EdgeInsets.only(bottom: 20),
//     );
//     showCupertinoModalPopup(context: context, builder: (context) => popupSucc);
//   }

//   popupFormat() {
//     AlertDialog popup1 = AlertDialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),

//       // shadowColor: Colors.black,
//       titlePadding: EdgeInsets.all(0),
//       title: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20),
//               topRight: Radius.circular(20),
//             ),
//           ),
//           height: 170,
//           width: 2000,
//           child: Image.asset(
//             'assets/omaigat.png',
//           )),
//       content: Container(
//         margin: EdgeInsets.only(bottom: 10),
//         height: 30,
//         child: Center(
//           child: Text(
//             'Format Harus .jpg/.jpeg/.png/.docx/.xlsx/.pdf',
//             style: TextStyle(
//                 color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//       actionsAlignment: MainAxisAlignment.start,
//       actionsPadding: EdgeInsets.only(bottom: 20),
//     );
//     showCupertinoModalPopup(context: context, builder: (context) => popup1);
//   }

//   popupEdit() {
//     AlertDialog popup1 = AlertDialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),

//       // shadowColor: Colors.black,
//       titlePadding: EdgeInsets.all(0),
//       title: Container(
//         decoration: BoxDecoration(
//           // color: Colors.green,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         height: 600,
//         width: 2000,
//         child: Column(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 color: Color.fromARGB(255, 224, 224, 224),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   topRight: Radius.circular(20),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey,
//                     offset: Offset(0.0, 1.0), //(x,y)
//                     blurRadius: 6.0,
//                   ),
//                 ],
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     width: 50,
//                   ),
//                   CircleAvatar(
//                       backgroundColor: Color.fromARGB(255, 255, 17, 17),
//                       minRadius: 45,
//                       child: Icon(
//                         Icons.task,
//                         size: 50,
//                         color: Colors.white,
//                       )),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Select Task',
//                         style: TextStyle(
//                             fontSize: 25, fontWeight: FontWeight.bold),
//                       ),
//                       Container(
//                         color: Colors.black,
//                         height: 1,
//                       )
//                     ],
//                   )
//                 ],
//               ),
//               height: 120,
//               width: 2000,
//             ),
//             Container(
//               margin: EdgeInsets.only(),
//               // color: Colors.amber,
//               height: 450,
//               child: ListView(
//                 children: MyactivityEditModel.myactivityedit.map((e) {
//                   var iniIdnya = '${e.task_id}';
//                   fetchTask(apiProject: '${e.projek_id}');
//                   deskripsi() {
//                     final text = '${e.myactivity_desc}';
//                     print(text.length);
//                     if (text.length >= 20) {
//                       return '${text.characters.take(20)}....';
//                     } else {
//                       return text;
//                     }
//                   }

//                   taskIdd() {
//                     var taskDescId = '';
//                     MyactivityModelTask.myactivitytask.forEach((element) {
//                       if (e.task_id == element.task_id) {
//                         taskDescId = '${element.task_id}';
//                       }
//                     });
//                     print(taskDescId);
//                     return taskDescId;
//                   }

//                   project() {
//                     var projectDesc = '';
//                     MyactivityModel.myactivitymodel.forEach((element) {
//                       if (e.projek_id == element.project_id) {
//                         selected = '${element.project_desc}';
//                         apiTask = '${element.project_id}';
//                         projectDesc = '${element.project_desc}';
//                       }
//                     });
//                     print(projectDesc);
//                   }

//                   projectIdd() {
//                     var projectDescId = '';
//                     MyactivityModel.myactivitymodel.forEach((element) {
//                       if (e.projek_id == element.project_id) {
//                         projectDescId = '${element.project_id}';
//                         fetchTask(apiProject: '${projectDescId}');
//                       }
//                     });
//                     print(projectDescId);
//                     return projectDescId;
//                   }

//                   task() {
//                     var taskDesc = '';
//                     MyactivityModelTask.myactivitytask.forEach((element) {
//                       if (e.task_id == element.task_id) {
//                         selectedTask = '';
//                         result.clear();
//                         selectedTask = '${element.task_desc}';
//                         taskDesc = '${element.task_desc}';
//                       }
//                     });
//                     print(taskDesc);
//                     return taskDesc;
//                   }

//                   return ListTile(
//                     onTap: () async {
//                       setState(() {
//                         taskId2 = '${e.task_id}';
//                         infoTask = taskIdd();
//                         sendDataApi = false;
//                         iniApiSave = false;
//                         iniApiEdit = true;
//                         print('sendDataApi :${sendDataApi}');
//                         edit = true;
//                         print(task());
//                         print(project());
//                         timeStart..text = '${e.time_start}';
//                         timeEnd..text = '${e.time_end}';
//                         projectId = '${projectIdd()}';
//                         taskId = '${taskIdd()}';
//                         desc..text = '${e.myactivity_desc}';
//                         uploadEdit = true;
//                         _directoryPath = null;
//                         dokumen = '${e.dokumen}';
//                         dokumenEdit = '${e.dokumen != null ? e.dokumen : ''}';
//                         // file = File('${e.dokumen}');
//                         idEdit = e.myactivity_id;
//                       });
//                       print('sendDataApi :${sendDataApi}');
//                       print('paths : ${_paths}');
//                       print('up : ${dokumen}');
//                       print('edit : ${edit}');

//                       print('selected : ${selected}');
//                       print('selectedTask : ${selectedTask}');
//                       print('Task : ${task()}');
//                       print('file : ${file}');
//                       print('tolong bgt: ${taskId2}');
//                       print('tolong bgtt: ${taskId3}');
//                       print('tolong bgtt: ${iniApiEdit}');
//                       Navigator.pop(context);
//                     },
//                     leading: Icon(
//                       Icons.task_alt,
//                       color: Color.fromARGB(255, 255, 17, 17),
//                     ),
//                     title: Text(
//                       '${deskripsi()}',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//                     ),
//                     subtitle: Text(
//                       '${e.time_start} s/d ${e.time_end}',
//                       style:
//                           TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             )
//           ],
//         ),
//       ),

//       actionsAlignment: MainAxisAlignment.start,
//       actionsPadding: EdgeInsets.only(bottom: 20),
//     );
//     showCupertinoModalPopup(context: context, builder: (context) => popup1);
//   }

//   //------------------------------------------------------------------------------------------------------

//   //---------------------------------------------API------------------------------------------------------

//   fetchProject() async {
//     resultProject.clear();
//     _loadToken();
//     print('ini token1111 : $token');
//     MyactivityModel.myactivitymodel.clear();
//     // cubit.getProject();
//     // cubit.getTaskById(apiTask);
//     final responseku = await http
//         .get(Uri.parse('${tipeurl}v1/activity/list-project'), headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token',
//     });
//     print('ini token2222 : $token');
//     final responseku2 = await http
//         .get(Uri.parse('${tipeurl}v1/activity/list-project'), headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token',
//     });
//     var data = jsonDecode(responseku2.body);
//     print('respone : ${responseku2}');
//     print('data : ${data}');
//     if (data['status'] == 200) {
//       print("API Success");
//       print(data);
//       int count = data['data'].length;
//       final Map<String, MyactivityModel> profileMap = new Map();
//       for (int i = 0; i < count; i++) {
//         MyactivityModel.myactivitymodel
//             .add(MyactivityModel.fromjson(data['data'][i]));
//         MyactivityModel.myactivitymodel.forEach((element) {
//           MyactivityModel.addSelect.add('${element.project_desc}');
//           print(MyactivityModel.addSelect);
//           resultProject =
//               LinkedHashSet<String>.from(MyactivityModel.addSelect).toList();
//         });
//         debugPrint('result Project' + resultProject.toString());
//         if (iniApiSave == true) {
//           selected = 'Reguler';
//         }
//       }

//       print('check length ${MyactivityModel.myactivitymodel.length}');
//       print(data['data'].toString());
//       if (data['status'] != 200) {
//         print('data[status] ${data['status']}');
//       }
//     } else {
//       print('NO DATA');
//       print('data[status] ${data['status']}');
//     }
//     if (mounted) {
//       setState(() {});
//     }
//   }

//   fetchTask({required String apiProject}) async {
//     result.clear;
//     _loadToken();
//     MyactivityModelTask.myactivitytask.clear();
//     MyactivityModelTask.addselectTaskEdit.clear;
//     MyactivityModelTask.addselectTask.clear();
//     print('coba disini');
//     final responseku = await http.get(
//       Uri.parse('${tipeurl}v1/activity/list-task?project_id=${apiTask}'),
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//     );
//     print('ini token : $token');
//     final responseku2 = await http.get(
//       Uri.parse('${tipeurl}v1/activity/list-task?project_id=${apiTask}'),
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//     );

//     var data = jsonDecode(responseku2.body);
//     print('respone : ${responseku2}');
//     print('data : ${data}');
//     if (data['status'] == 200) {
//       print("API Success");
//       print(data);
//       int count = data['data'].length;
//       for (int i = 0; i < count; i++) {
//         MyactivityModelTask.myactivitytask
//             .add(MyactivityModelTask.fromjson(data['data'][i]));
//         MyactivityModelTask.myactivitytask.forEach((element) {
//           if (iniApiEdit == true) {
//             MyactivityModelTask.addselectTaskEdit.add('${element.task_desc}');
//             print('MyactivityModelTask.addselectTask');
//             print(MyactivityModelTask.addselectTask);

//             resultEdit = LinkedHashSet<String>.from(
//                     MyactivityModelTask.addselectTaskEdit)
//                 .toList();
//             if (taskId2 == element.task_id) {
//               taskId3 = element.task_desc;
//               selectedTask = '${taskId3}';
//             }
//             print('resulttttttttttt : ${taskId2}');
//             print('resulttttttttttt : ${taskId3}');
//           } else {
//             MyactivityModelTask.addselectTask.add('${element.task_desc}');
//             print('MyactivityModelTask.addselectTask');
//             print(MyactivityModelTask.addselectTask);
//             result =
//                 LinkedHashSet<String>.from(MyactivityModelTask.addselectTask)
//                     .toList();
//             print('result : ${result}');
//             selectedTask = '${result.elementAt(0)}';
//           }
//         });
//       }
//       print('check length ${MyactivityModelTask.myactivitytask.length}');
//       print(data['data'].toString());
//     } else {
//       print('NO DATA');
//     }
//     if (mounted) {
//       setState(() {});
//     }
//   }

//   fetchEdit({required String user_create}) async {
//     MyactivityEditModel.myactivityedit.clear();
//     final responseku = await http.post(
//         Uri.parse('${tipeurl}v1/activity/clock_daily_activity'),
//         body: {'user_create': '${user_create}'});

//     var data = jsonDecode(responseku.body);

//     if (data['status'] == 200) {
//       print("API Success");
//       print(data);
//       int count = data['data'].length;
//       final Map<String, MyactivityEditModel> profileMap = new Map();
//       for (int i = 0; i < count; i++) {
//         MyactivityEditModel.myactivityedit
//             .add(MyactivityEditModel.fromjson(data['data'][i]));
//       }
//       MyactivityEditModel.myactivityedit.forEach((element) {
//         profileMap[element.myactivity_desc] = element;
//         MyactivityEditModel.myactivityedit = profileMap.values.toList();
//         print(MyactivityEditModel.myactivityedit);
//       });
//       print('check length ${MyactivityEditModel.myactivityedit.length}');
//       print(data['data'].toString());
//     } else {
//       print('NO DATA');
//     }
//   }

//   //----------------------------------------------------------------------------------------------------------------

//   getDataApi() {
//     MyactivityEditModel.myactivityedit.forEach((element) {});
//   }

//   Future<void> requestPermission() async {
//     final permission = Permission.storage;
//     print('permission');
//     await notifPermission
//         .NotificationPermissions.requestNotificationPermissions;
//     await notifPermission.NotificationPermissions
//         .getNotificationPermissionStatus();
//     await Permission.manageExternalStorage.request();

//     final result = await permission.request();

//     if (result == PermissionStatus.denied) {
//       final requestStorageAgain = await Permission.storage.request();
//       ("result permission $requestStorageAgain");
//       if (requestStorageAgain == PermissionStatus.denied) {
//         throw Exception("Permission Storage is need");
//       }
//     }
//     if (Platform.isIOS) {
//       bool storage = await Permission.storage.status.isGranted;
//       if (storage) {
//         // Awesome
//       } else {
//         // Crap
//       }
//     } else {
//       bool storage = true;
//       bool videos = true;
//       bool photos = true;

//       // Only check for storage < Android 13
//       DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//       AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//       if (androidInfo.version.sdkInt >= 33) {
//         print('diatas 33');
//         print(Permission.photos.status);
//         videos = await Permission.videos.status.isGranted;
//         photos = await Permission.photos.status.isGranted;
//       } else {
//         storage = await Permission.storage.status.isGranted;
//       }

//       if (storage && videos && photos) {
//         // Awesome
//       } else {
//         // Crap
//       }
//     }
//   }

//   void _openFileExplorer() async {
//     setState(() => _loadingPath = true);
//     try {
//       _directoryPath = null;
//       uploadEdit = false;

//       _paths = (await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowMultiple: _multiPick,
//         allowedExtensions: ['jpg', 'jpeg', 'png', 'xlsx', 'pdf'],
//       ))
//           ?.files;
//     } on PlatformException catch (e) {
//       print("Unsupported operation" + e.toString());
//     } catch (ex) {
//       print(ex);
//     }
//     if (!mounted) return;
//     setState(() {
//       _loadingPath = false;
//       print(_paths?.first.extension);

//       _fileName =
//           _paths != null ? _paths!.map((e) => e.name).toString() : '...';
//     });
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//               // Navigator.pushAndRemoveUntil(
//               //     context,
//               //     MaterialPageRoute(
//               //       builder: (context) =>
//               //           DefaultBottomBarController(child: Ramayana()),
//               //     ),
//               //     (Route<dynamic> route) => false);
//             },
//             icon: Icon(
//               Icons.arrow_back_ios,
//               size: 23,
//               color: Colors.white,
//             ),
//           ),
//           title: Text('My Activity',
//               style: GoogleFonts.plusJakartaSans(
//                   fontSize: 23, color: Colors.white)),
//           backgroundColor: Color.fromARGB(255, 255, 17, 17),
//           elevation: 5,
//           toolbarHeight: 80,
//         ),
//         body: BlocListener<MyActivityCubit, MyActivityState>(
//             listener: (context, state) {
//               if (state is MyActivitySuccess) {
//                 final response = state.response.data;
//                 response?.forEach((element) {
//                   MyactivityModel.myactivitymodel
//                       .add(MyactivityModel.fromjson(element.toJson()));
//                   setState(() {
//                     resultProject.add(element.projectDesc!);
//                     if (element.projectId == widget.response!.projectId) {
//                       projectId = element.projectId!;
//                       selected = element.projectDesc!;
//                       debugPrint('selected is ' + projectId);
//                     }
//                   });
//                 });

//                 debugPrint('result Project' + resultProject.toString());
//               }
//               if (state is MyActivitySuccessTask) {
//                 final response = state.response.data;
//                 response?.forEach((element) {
//                   setState(() {
//                     result.add(element.taskDesc!);
//                     if (element.taskId == widget.response?.taskId) {
//                       taskId = element.taskId!;
//                       selectedTask = element.taskDesc!;
//                       debugPrint('selected task is ' + taskId);
//                     }
//                   });
//                 });

//                 debugPrint('result Project' + resultProject.toString());
//               }
//             },
//             child: Stack(children: [
//               Form(
//                 key: _formKey,
//                 child: Container(
//                   margin: EdgeInsets.only(top: 20, left: 30, right: 30),
//                   // height: 450,
//                   // width: 300,
//                   child: ListView(
//                     children: [
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Date',
//                               style: GoogleFonts.plusJakartaSans(
//                                   fontSize: 18,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w500)),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           TextFormField(
//                             decoration: InputDecoration(
//                               border: UnderlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.black),
//                               ),
//                               enabledBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.black),
//                               ),
//                               focusedBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.black),
//                               ),
//                               prefixIcon: Icon(
//                                 Icons.date_range_rounded,
//                                 size: 33,
//                                 color: Color.fromARGB(255, 255, 17, 17),
//                               ),
//                               //  labelText: 'Date',
//                               hintText: '${formattedDate}',
//                               hintStyle: GoogleFonts.plusJakartaSans(
//                                   fontSize: 17, color: Colors.black),
//                             ),
//                             style: GoogleFonts.plusJakartaSans(
//                                 fontSize: 17, color: Colors.black),
//                             // enabled: false,
//                             keyboardType: TextInputType.text,
//                             readOnly: true,

//                             onSaved: (String? val) {
//                               _setDate = val;
//                             },
//                           ),
//                         ],
//                       ),

//                       SizedBox(
//                         height: 20,
//                       ),

//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Project',
//                               style: GoogleFonts.plusJakartaSans(
//                                   fontSize: 18,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w500)),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Icon(
//                                 Icons.file_copy_outlined,
//                                 color: Color.fromARGB(255, 255, 17, 17),
//                                 size: 30,
//                               ),
//                               SizedBox(
//                                 width: 30,
//                               ),
//                               Container(
//                                 // margin: EdgeInsets.only(right: 20),
//                                 width: 350,
//                                 child: DropdownButton(
//                                      isExpanded: true,
//                                   style: GoogleFonts.plusJakartaSans(
//                                       fontSize: 17, color: Colors.black),
//                                   value: selected,
//                                   hint: Text(
//                                     '${selected}',
//                                     style: GoogleFonts.plusJakartaSans(
//                                         fontSize: 17, color: Colors.black) ,overflow: TextOverflow.ellipsis,
//                                   ),
//                                   onChanged: (value) {
//                                     print(value);
//                                     setState(() {
//                                       iniApiEdit = false;
//                                       print('tes iniApiEdit :${iniApiEdit}');
//                                       selected = value as String;
//                                     });
//                                   },
//                                   items: resultProject
//                                       .map((e) => DropdownMenuItem(
//                                             onTap: () {
//                                               MyactivityModelTask.myactivitytask
//                                                   .clear();
//                                               MyactivityModel.myactivitymodel
//                                                   .forEach((element) {
//                                                 if (e == element.project_desc) {
//                                                   setState(() {
//                                                     apiTask =
//                                                         '${element.project_id}';
//                                                     projectId =
//                                                         '${element.project_id}';
//                                                     selected = projectId;
//                                                     MyactivityModelTask
//                                                         .addselectTask
//                                                         .clear();
//                                                     print(apiTask);
//                                                     result.clear;
//                                                     fetchTask(
//                                                         apiProject:
//                                                             '${apiTask}');
//                                                     print(
//                                                         'tes range 1 : ${iniApiEdit}');
//                                                     // selectedTask = MyactivityModelTask.addselectTask[0];
//                                                   });
//                                                 }
//                                               });
//                                             },
//                                             value: e,
//                                             child: Text('${e}',style:TextStyle(overflow: TextOverflow.ellipsis)),
//                                           ))
//                                       .toList(),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),

//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Task',
//                               style: GoogleFonts.plusJakartaSans(
//                                   fontSize: 18,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w500)),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Icon(
//                                 Icons.task,
//                                 color: Color.fromARGB(255, 255, 17, 17),
//                                 size: 30,
//                               ),
//                               SizedBox(
//                                 width: 30,
//                               ),
//                               Container(
//                                 // margin: EdgeInsets.only(right: 30),
//                                 width: 250,
//                                 child: DropdownButton(
//                                   isExpanded: true,
//                                   style: GoogleFonts.plusJakartaSans(
//                                       fontSize: 17, color: Colors.black),
//                                   value: selectedTask,
//                                   hint: Text(
//                                     '${selectedTask}',
//                                     style: GoogleFonts.plusJakartaSans(
//                                         fontSize: 17, color: Colors.black),
//                                         overflow: TextOverflow.ellipsis,
//                                         // textScaler: TextScaler.noScaling,
//                                   ),
//                                   onChanged: (value) {
//                                     print(value);
//                                     setState(() {
//                                       iniApiEdit;
//                                       print(
//                                           'tes range 1 : ${result.elementAt(0)}');
//                                       selectedTask = value as String;
//                                     });
//                                   },
//                                   items: iniApiEdit
//                                       ? resultEdit
//                                           .map((e) => DropdownMenuItem(
//                                                 onTap: () {
//                                                   MyactivityModelTask
//                                                       .addselectTask
//                                                       .clear();
//                                                   MyactivityModelTask
//                                                       .myactivitytask
//                                                       .forEach((element) {
//                                                     if (e ==
//                                                         element.task_desc) {
//                                                       setState(() {
//                                                         taskId =
//                                                             '${element.task_id}';
//                                                         selectedTask = taskId;
//                                                       });
//                                                     }
//                                                   });
//                                                 },
//                                                 value: e,
//                                                 child: Text('${e}', style: TextStyle(overflow: TextOverflow.ellipsis),),
//                                               ))
//                                           .toList()
//                                       : result
//                                           .map((e) => DropdownMenuItem(
//                                                 onTap: () {
//                                                   MyactivityModelTask
//                                                       .addselectTaskEdit
//                                                       .clear();
//                                                   MyactivityModelTask
//                                                       .addselectTask
//                                                       .clear();
//                                                   MyactivityModelTask
//                                                       .myactivitytask
//                                                       .forEach((element) {
//                                                     if (e ==
//                                                         element.task_desc) {
//                                                       setState(() {
//                                                         taskId =
//                                                             '${element.task_id}';
//                                                         selectedTask = taskId;
//                                                       });
//                                                     }
//                                                   });
//                                                 },
//                                                 value: e,
//                                                 child: Text('${e}',style:TextStyle(overflow: TextOverflow.ellipsis)),
//                                               ))
//                                           .toList(),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),

//                       Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('Time',
//                                 style: GoogleFonts.plusJakartaSans(
//                                     fontSize: 18,
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.w500)),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                   width: 170,
//                                   child: TextFormField(
//                                       validator: RequiredValidator(
//                                           errorText: ' Please Enter'),
//                                       decoration: InputDecoration(
//                                         border: UnderlineInputBorder(
//                                           borderSide:
//                                               BorderSide(color: Colors.black),
//                                         ),
//                                         enabledBorder: UnderlineInputBorder(
//                                           borderSide:
//                                               BorderSide(color: Colors.black),
//                                         ),
//                                         focusedBorder: UnderlineInputBorder(
//                                           borderSide:
//                                               BorderSide(color: Colors.black),
//                                         ),
//                                         prefixIcon: Icon(
//                                           Icons.lock_clock,
//                                           size: 30,
//                                           color:
//                                               Color.fromARGB(255, 255, 17, 17),
//                                         ),
//                                         //  labelText: 'Date',
//                                         hintText: '${formattedTime}',
//                                         hintStyle: GoogleFonts.plusJakartaSans(
//                                             fontSize: 17, color: Colors.black),
//                                       ),
//                                       style: GoogleFonts.plusJakartaSans(
//                                           fontSize: 17, color: Colors.black),
//                                       // enabled: false,
//                                       keyboardType: TextInputType.text,
//                                       controller: timeStart,
//                                       onTap: () async {
//                                         TimeOfDay? picked =
//                                             await showTimePicker(
//                                                 context: context,
//                                                 builder: (BuildContext context,
//                                                     Widget? child) {
//                                                   return Theme(
//                                                     data: ThemeData(
//                                                       primarySwatch:
//                                                           Colors.grey,
//                                                       splashColor: Colors.white,
//                                                       textTheme: TextTheme(
//                                                         subtitle1: TextStyle(
//                                                             color:
//                                                                 Colors.black),
//                                                         button: TextStyle(
//                                                             color:
//                                                                 Colors.black),
//                                                       ),
//                                                       hintColor: Colors.black,
//                                                       colorScheme:
//                                                           ColorScheme.light(
//                                                               primary: Color
//                                                                   .fromARGB(
//                                                                       255,
//                                                                       255,
//                                                                       17,
//                                                                       17),
//                                                               // primaryVariant:
//                                                               //     Colors.white,
//                                                               // secondaryVariant:
//                                                               //     Colors.black,
//                                                               onSecondary:
//                                                                   Colors.black,
//                                                               onPrimary:
//                                                                   Colors.white,
//                                                               surface:
//                                                                   Colors.white,
//                                                               onSurface:
//                                                                   Colors.black,
//                                                               secondary:
//                                                                   Colors.white),
//                                                       dialogBackgroundColor:
//                                                           Colors.white,
//                                                     ),
//                                                     child: child ?? Text(""),
//                                                   );
//                                                 },
//                                                 initialTime: selectedTimeStart
//                                                 //   .replacing(
//                                                 //       hour: selectedTimeStart.hourOfPeriod),
//                                                 );
//                                         if (picked != null)
//                                           setState(() {
//                                             selectedTimeStart = picked;
//                                             var hourStart = selectedTimeStart
//                                                 .hour
//                                                 .toString()
//                                                 .padLeft(2, '0');
//                                             var minuteStart = selectedTimeStart
//                                                 .minute
//                                                 .toString()
//                                                 .padLeft(2, '0');
//                                             var join = hourStart + minuteStart;
//                                             intJoinStart = int.parse(join);
//                                             print(join);
//                                             print(intJoinStart);

//                                             timeStart.text = DateFormat(
//                                                     '${selectedTimeStart.hour.toString().padLeft(2, '0')}:${selectedTimeStart.minute.toString().padLeft(2, '0')}'
//                                                     // 'HH:mm:ss'
//                                                     )
//                                                 .format(
//                                                     // dt
//                                                     DateTime(
//                                                         selectedTimeStart.hour,
//                                                         selectedTimeStart
//                                                             .minute))
//                                                 .toString();
//                                             print(timeStart.text);
//                                           });
//                                       }),
//                                 ),
//                                 Text('to',
//                                     style: GoogleFonts.plusJakartaSans(
//                                         fontSize: 15,
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.w500)),
//                                 Container(
//                                   width: 170,
//                                   child: TextFormField(
//                                       validator: RequiredValidator(
//                                           errorText: ' Please Enter'),
//                                       decoration: InputDecoration(
//                                         border: UnderlineInputBorder(
//                                           borderSide:
//                                               BorderSide(color: Colors.black),
//                                         ),
//                                         enabledBorder: UnderlineInputBorder(
//                                           borderSide:
//                                               BorderSide(color: Colors.black),
//                                         ),
//                                         focusedBorder: UnderlineInputBorder(
//                                           borderSide:
//                                               BorderSide(color: Colors.black),
//                                         ),
//                                         prefixIcon: Icon(
//                                           Icons.lock_clock,
//                                           color:
//                                               Color.fromARGB(255, 255, 17, 17),
//                                           size: 30,
//                                         ),
//                                         //  labelText: 'Date',
//                                         hintText: '${formattedTime}',
//                                         hintStyle: GoogleFonts.plusJakartaSans(
//                                             fontSize: 17, color: Colors.black),
//                                       ),
//                                       style: GoogleFonts.plusJakartaSans(
//                                           fontSize: 17, color: Colors.black),
//                                       // enabled: false,
//                                       keyboardType: TextInputType.text,
//                                       controller: timeEnd,
//                                       onTap: () async {
//                                         sendDataApi = false;
//                                         final TimeOfDay? picked =
//                                             await showTimePicker(
//                                                 context: context,
//                                                 builder: (BuildContext context,
//                                                     Widget? child) {
//                                                   return Theme(
//                                                     data: ThemeData(
//                                                       primarySwatch:
//                                                           Colors.grey,
//                                                       splashColor: Colors.white,
//                                                       textTheme: TextTheme(
//                                                         subtitle1: TextStyle(
//                                                             color:
//                                                                 Colors.black),
//                                                         button: TextStyle(
//                                                             color:
//                                                                 Colors.black),
//                                                       ),
//                                                       hintColor: Colors.black,
//                                                       colorScheme:
//                                                           ColorScheme.light(
//                                                               primary: Color
//                                                                   .fromARGB(
//                                                                       255,
//                                                                       255,
//                                                                       17,
//                                                                       17),
//                                                               // primaryVariant:
//                                                               //     Colors.white,
//                                                               // secondaryVariant:
//                                                               //     Colors.black,
//                                                               onSecondary:
//                                                                   Colors.black,
//                                                               onPrimary:
//                                                                   Colors.white,
//                                                               surface:
//                                                                   Colors.white,
//                                                               onSurface:
//                                                                   Colors.black,
//                                                               secondary:
//                                                                   Colors.white),
//                                                       dialogBackgroundColor:
//                                                           Colors.white,
//                                                     ),
//                                                     child: child ?? Text(""),
//                                                   );
//                                                 },
//                                                 initialTime: selectedTime);

//                                         if (picked != null)
//                                           setState(() {
//                                             selectedTime = picked;
//                                             var hour = selectedTime.hour
//                                                 .toString()
//                                                 .padLeft(2, '0');
//                                             var minute = selectedTime.minute
//                                                 .toString()
//                                                 .padLeft(2, '0');
//                                             var join = hour + minute;
//                                             int intJoin = int.parse(join);
//                                             print(join);
//                                             print(intJoin);

//                                             print(selectedTime);
//                                             intJoinStart >= intJoin
//                                                 ? timeEnd.text = timeStart.text
//                                                 : timeEnd.text = DateFormat(
//                                                         '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}')
//                                                     .format(DateTime(
//                                                         picked.hour,
//                                                         picked.minute));
//                                             print(timeEnd.text);
//                                           });
//                                       }),
//                                 ),
//                               ],
//                             ),
//                           ]),

//                       SizedBox(
//                         height: 20,
//                       ),

//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Description',
//                               style: GoogleFonts.plusJakartaSans(
//                                   fontSize: 18,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w500)),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           TextFormField(
//                             validator:
//                                 RequiredValidator(errorText: ' Please Enter'),
//                             controller: desc,
//                             maxLines: 7,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                                 borderSide: BorderSide(color: Colors.black),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                                 borderSide: BorderSide(color: Colors.black),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                                 borderSide: BorderSide(color: Colors.black),
//                               ),
//                               disabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                                 borderSide: BorderSide(color: Colors.black),
//                               ),
//                               labelText: 'Deskripsi',
//                               labelStyle: GoogleFonts.plusJakartaSans(
//                                   fontSize: 17, color: Colors.red),
//                               prefixIcon: Icon(
//                                 Icons.chrome_reader_mode,
//                                 color: Color.fromARGB(255, 255, 17, 17),
//                                 size: 30,
//                               ),
//                               // fillColor: Colors.grey[200],
//                               filled: true,
//                             ),
//                             style: GoogleFonts.plusJakartaSans(
//                                 fontSize: 17, color: Colors.black),
//                           ),
//                         ],
//                       ),

//                       // -------------------------------------------UPLOAD DOKUMEN ----------------------------------------------
//                       SizedBox(height: 20),

//                       Builder(
//                           builder: (BuildContext context) => uploadEdit
//                               ? ListTile(
//                                   title: Text(dokumen),
//                                 )
//                               : _loadingPath
//                                   ? SpinKitWave(
//                                       color: Color.fromARGB(255, 255, 17, 17),
//                                       size: 30.0,
//                                       duration: Duration(seconds: 10),
//                                     )
//                                   : _directoryPath != null
//                                       ? ListTile(
//                                           title: const Text('Directory path'),
//                                           subtitle: Text(_directoryPath!),
//                                         )
//                                       : _paths != null
//                                           ? Container(
//                                               // padding: const EdgeInsets.only(bottom: 30),
//                                               height: 80,
//                                               child: Scrollbar(
//                                                   child: ListView.separated(
//                                                 itemCount: _paths != null &&
//                                                         _paths!.isNotEmpty
//                                                     ? _paths!.length
//                                                     : 1,
//                                                 itemBuilder:
//                                                     (BuildContext context,
//                                                         int index) {
//                                                   final bool isMultiPath =
//                                                       _paths != null &&
//                                                           _paths!.isNotEmpty;
//                                                   nameFile = (isMultiPath
//                                                       ? _paths!
//                                                           .map((e) => e.name)
//                                                           .toList()[index]
//                                                       : _fileName ?? '...');
//                                                   paths = _paths!
//                                                       .map((e) => e.path)
//                                                       .toList()[index]
//                                                       .toString();

//                                                   file = File(paths);
//                                                   print(file);

//                                                   return ListTile(
//                                                     title: Text(
//                                                       nameFile!,
//                                                     ),
//                                                     subtitle: Text(paths),
//                                                   );
//                                                 },
//                                                 separatorBuilder:
//                                                     (BuildContext context,
//                                                             int index) =>
//                                                         const Divider(),
//                                               )),
//                                             )
//                                           : const SizedBox()),

//                       Container(
//                         margin: EdgeInsets.only(right: 220),
//                         child: MaterialButton(
//                           height: 45,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           color: Color.fromARGB(255, 219, 215, 215),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(Icons.file_copy),
//                               Text(
//                                 'Upload Document',
//                                 style: GoogleFonts.plusJakartaSans(
//                                     fontSize: 15, color: Colors.black),
//                               )
//                             ],
//                           ),
//                           onPressed: () {
//                             // requestPermission(); //dikomennnnn
//                             print('dateinput : ${dateInput}');
//                             _openFileExplorer();
//                           },
//                         ),
//                       ),

//                       SizedBox(height: 20),

//                       Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             MaterialButton(
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(30)),
//                               minWidth: 100,
//                               height: 50,
//                               color: Color.fromARGB(255, 255, 17, 17),
//                               onPressed: () async {
//                                 _loadData();
//                               },
//                               child: Text(
//                                 "Edit",
//                                 style: GoogleFonts.plusJakartaSans(
//                                     fontSize: 17, color: Colors.white),
//                               ),
//                             ),
//                             MaterialButton(
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(30)),
//                               minWidth: 100,
//                               height: 50,
//                               color: Color.fromARGB(255, 255, 17, 17),
//                               onPressed: () async {
//                                 print(edit);
//                                 if (_formKey.currentState!.validate()) {
//                                   MyActivity apiMyactivity = MyActivity();
//                                   iniApiEdit = false;
//                                   print('edit : ${edit}');
//                                   print('iniApiEdit : ${iniApiEdit}');
//                                   print('loading : ${up}');
//                                   //1x save
//                                   if (sendDataApi == false) {
//                                     sendDataApi = true;

//                                     if (edit == true) {
//                                       if (_paths != null) {
//                                         var formData = FormData.fromMap({
//                                           'user_create':
//                                               '${userData.getUsername7()}',
//                                           'time_start': timeStart.text,
//                                           'time_end': timeEnd.text,
//                                           'task_id': taskId == ''
//                                               ? 'P202300001-001'
//                                               : taskId,
//                                           'projek_id': projectId == ''
//                                               ? 'P202300001'
//                                               : projectId,
//                                           'myactivity_id': idEdit,
//                                           'myactivity_desc': desc.text,
//                                           'date_create': dateInput,
//                                           'dokumen':
//                                               await MultipartFile.fromFile(
//                                                   file!.path,
//                                                   filename: '${nameFile}'),
//                                           'beforedokumen': '${dokumen}'
//                                         });

//                                         var response = await dio.post(
//                                             '${tipeurl}v1/activity/updateDailyActivity',
//                                             data: formData);

//                                         AndroidDeviceInfo info =
//                                             await deviceInfo.androidInfo;
//                                         var formDataLog = FormData.fromMap({
//                                           'progname': 'RALS_TOOLS ',
//                                           'versi': '${versi}',
//                                           'date_run': '${DateTime.now()}',
//                                           'info1':
//                                               'My Activity - Edit My Activity',
//                                           ' info2': '${_udid} ',
//                                           'userid':
//                                               '${userData.getUsernameID()}',
//                                           ' toko': '${userData.getUserToko()}',
//                                           ' devicename': '${info.device}',
//                                           'TOKEN': 'R4M4Y4N4'
//                                         });
//                                         print('berhasil $_udid');
//                                         var responseLog = await dio.post(
//                                             '${tipeurl}v1/activity/createmylog',
//                                             data: formDataLog);
//                                         print('berhasil $_udid');
//                                       } else {
//                                         var formData = FormData.fromMap({
//                                           'user_create':
//                                               '${userData.getUsername7()}',
//                                           'time_start': timeStart.text,
//                                           'time_end': timeEnd.text,
//                                           'task_id': taskId == ''
//                                               ? 'P202300001-001'
//                                               : taskId,
//                                           'projek_id': projectId == ''
//                                               ? 'P202300001'
//                                               : projectId,
//                                           'myactivity_id': idEdit,
//                                           'myactivity_desc': desc.text,
//                                           'date_create': dateInput,
//                                           'dokumen': '${dokumenEdit}',
//                                           'beforedokumen': '${dokumen}'
//                                         });
//                                         var urlEditAct =
//                                             '${tipeurl}v1/activity/updateDailyActivity';
//                                         var response = await dio
//                                             .post(urlEditAct, data: formData);

//                                         AndroidDeviceInfo info =
//                                             await deviceInfo.androidInfo;
//                                         var formDataLog = FormData.fromMap({
//                                           'progname': 'RALS_TOOLS ',
//                                           'versi': '${versi}',
//                                           'date_run': '${DateTime.now()}',
//                                           'info1':
//                                               'My Activity - Edit My Activity',
//                                           ' info2': '${_udid} ',
//                                           'userid':
//                                               '${userData.getUsernameID()}',
//                                           ' toko': '${userData.getUserToko()}',
//                                           ' devicename': '${info.device}',
//                                           'TOKEN': 'R4M4Y4N4'
//                                         });
//                                         loginCubit.createLog(
//                                             baseParam.logInfoActityEdit,
//                                             '${baseParam.logInfoActitySucc} ${projectId}',
//                                             urlEditAct);
//                                         print('berhasil $_udid');
//                                         print('berhasil $_udid');
//                                       }

//                                       print('file : ${file}');
//                                       print('DATA EDIT');

//                                       print('DATA Input');
//                                     } else {
//                                       if (_paths != null) {
//                                         var formData = FormData.fromMap({
//                                           'user_create':
//                                               '${userData.getUsername7()}',
//                                           'time_start': timeStart.text,
//                                           'time_end': timeEnd.text,
//                                           'task_id': taskId == ''
//                                               ? 'P202300001-001'
//                                               : taskId,
//                                           'projek_id': projectId == ''
//                                               ? 'P202300001'
//                                               : projectId,
//                                           'myactivity_status': null,
//                                           'myactivity_desc': desc.text,
//                                           'date_create': dateInput,
//                                           'dokumen':
//                                               await MultipartFile.fromFile(
//                                                   file!.path,
//                                                   filename: '${nameFile}')
//                                         });
//                                         var urlCreateAct =
//                                             '${tipeurl}v1/activity/create_daily_activity';
//                                         var response = await dio
//                                             .post(urlCreateAct, data: formData);

//                                         AndroidDeviceInfo info =
//                                             await deviceInfo.androidInfo;
//                                         var formDataLog = FormData.fromMap({
//                                           'progname': 'RALS_TOOLS ',
//                                           'versi': '${versi}',
//                                           'date_run': '${DateTime.now()}',
//                                           'info1':
//                                               'My Activity - Input My Activity',
//                                           ' info2': '${_udid} ',
//                                           'userid':
//                                               '${userData.getUsernameID()}',
//                                           ' toko': '${userData.getUserToko()}',
//                                           ' devicename': '${info.device}',
//                                           'TOKEN': 'R4M4Y4N4'
//                                         });

//                                         print('berhasil $_udid');
//                                         loginCubit.createLog(
//                                             baseParam.logInfoActivityPage,
//                                             '${baseParam.logInfoActivityInputSucc}${projectId}',
//                                             urlCreateAct);
//                                         // var responseLog = await dio.post(
//                                         //     '${tipeurl}v1/activity/createmylog',
//                                         //     data: formDataLog);
//                                         print('berhasil $_udid');
//                                       } else {
//                                         var formData = FormData.fromMap({
//                                           'user_create':
//                                               '${userData.getUsername7()}',
//                                           'time_start': timeStart.text,
//                                           'time_end': timeEnd.text,
//                                           'task_id': taskId == ''
//                                               ? 'P202300001-001'
//                                               : taskId,
//                                           'projek_id': projectId == ''
//                                               ? 'P202300001'
//                                               : projectId,
//                                           'myactivity_status': null,
//                                           'myactivity_desc': desc.text,
//                                           'date_create': dateInput,
//                                         });
//                                         var urlCreateAct =
//                                             '${tipeurl}v1/activity/create_daily_activity';

//                                         var response = await dio
//                                             .post(urlCreateAct, data: formData);

//                                         AndroidDeviceInfo info =
//                                             await deviceInfo.androidInfo;
//                                         var formDataLog = FormData.fromMap({
//                                           'progname': 'RALS_TOOLS ',
//                                           'versi': '${versi}',
//                                           'date_run': '${DateTime.now()}',
//                                           'info1':
//                                               'My Activity - Input My Activity',
//                                           ' info2': '${_udid} ',
//                                           'userid':
//                                               '${userData.getUsernameID()}',
//                                           ' toko': '${userData.getUserToko()}',
//                                           ' devicename': '${info.device}',
//                                           'TOKEN': 'R4M4Y4N4'
//                                         });
//                                         print('berhasil $_udid');
//                                         loginCubit.createLog(
//                                             baseParam.logInfoActivityPage,
//                                             '${baseParam.logInfoActivityInputSucc}${projectId}',
//                                             urlCreateAct);
//                                         print('berhasil $_udid');
//                                       }
//                                     }
//                                     print(
//                                         'Berhasil ${dokumen} ${dokumenEdit}, ${selectedTask}, ${timeStart.text}, ${timeStart.text}, ${timeStart.text},');
//                                     popUpSuccess();
//                                     iniApiSave = true;
//                                     apiTask = 'P202300001';
//                                     fetchProject();
//                                     fetchTask(apiProject: '${apiTask}');
//                                     result.clear();
//                                     resultProject.clear();
//                                     uploadEdit = false;
//                                     timeStart.clear();
//                                     timeEnd.clear();
//                                     desc.clear();
//                                     _paths = null;
//                                     up = false;
//                                     setState(() {
//                                       fetchEdit(
//                                           user_create:
//                                               '${userData.getUsername7()}');
//                                       edit = false;
//                                     });
//                                   }
//                                 } else {
//                                   print('sudah input/edit');
//                                 }
//                                 //save data 1x
//                               },
//                               child: Text(
//                                 "Save",
//                                 style: GoogleFonts.plusJakartaSans(
//                                     fontSize: 17, color: Colors.white),
//                               ),
//                             ),
//                           ]),
//                       SizedBox(
//                         height: 30,
//                       )
//                     ],
//                   ),
//                 ),
//               )
//             ])));
//   }
//   // DropdownMenuItem<String> buildMenuItem(String item) =>
//   // DropdownMenuItem(
//   //   value: item,
//   //   child: Text(
//   //     item,
//   //     style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Color.fromARGB(255, 255, 17, 17)),
//   //   ),
//   // );
// }
