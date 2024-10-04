part of 'import.dart';

class RamayanaMyActivity extends StatefulWidget {
  RamayanaMyActivity(
    {super.key,
    this.response,
    this.responseEdit,
    this.filename,
    this.projectId,
    this.projectDesc,
    this.taskId,
    this.taskDesc,
    this.status,
    this.timeStart,
    this.timeEnd,
    this.id,
    this.desc,
    required this.update});

  final GetTaskResponse.Data? response;
  final MyActivityEditResponse.Data? responseEdit;
  List<Dokumen>? filename;
  String? projectId;
  String? projectDesc;
  String? taskId;
  String? taskDesc;
  String? status;
  DateTime? timeStart;
  DateTime? timeEnd;
  String? id;
  String? desc;
  bool update = false;

  @override
  State<RamayanaMyActivity> createState() => _RamayanaMyActivityState();
}

class _RamayanaMyActivityState extends State<RamayanaMyActivity> {
  @override
  final QuillEditorController descriptionController = QuillEditorController();

  UserData userData = UserData();

  late MyActivityCubit cubit;
  late LoginCubit loginCubit;
  late PopUpWidget popUpWidget;
  final urlApi = '${tipeurl}${basePath.api_activity_create_daily}';

  File? file;

  String? token;

  bool _loadingPath = false;
  bool _loadingSpinkit = false;
  bool _loadingUpload = false;
  bool _loadingButton = false;

  String? idUpdate;
  String? _fileName;
  String? _directoryPath;

  bool uploadEdit = false;
  bool _multiPick = false;

  List<PlatformFile>? _paths;
  // List<Dokumen> dataDokumenList = [];
  // List<Attachment> dataDokumenListUpdate = [];

  var selectedProject = 'Reguler';
  var selectedTask = 'My Task';
  var dokumen = '';
  var projectId = '';

  String? nameFile;
  String paths = '';
  String taskId = '';
  String myActId = '';
  String? base64File;
  String formattedDate = DateFormat('d MMMM yyyy').format(DateTime.now());

  List<String> result = [];
  List<String> resultProject = [];

  DateTime dateTimeSelected = DateTime.now().subtract(Duration(minutes: DateTime.now().minute % 15));
  DateTime dateTimeSelectedEnd = DateTime.now().add(Duration(minutes: (15 - (DateTime.now().minute % 15)) % 15));

  refreshpage() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    token = await SharedPref.getToken();
    cubit.getTaskById(token!, widget.projectId ?? 'P202300001');
    setData(widget.response!);
  }

  

  void _openTimePickerSheet(BuildContext context) async {
    TimeOfDay? pickedTime =  await showTimePicker(
        initialTime: TimeOfDay.now(),
        context: context, //context of current state
    );
    if(pickedTime != null ){
      setState(() {
        DateTime now = DateTime.now();
        DateTime parsedTime = DateTime(
        now.year, 
        now.month, 
        now.day, 
        pickedTime.hour, 
        pickedTime.minute
      );
        dateTimeSelected = parsedTime;
        print(dateTimeSelected);
      });
    }
  }

  void _openTimePickerSheetEnd(BuildContext context) async {
    TimeOfDay? pickedTime =  await showTimePicker(
        initialTime: TimeOfDay.now(),
        context: context,
        
    );

    if(pickedTime != null ){
        setState(() {
        DateTime now = DateTime.now();
        DateTime parsedTime = DateTime(
        now.year, 
        now.month, 
        now.day, 
        pickedTime.hour, 
        pickedTime.minute
      );
        dateTimeSelectedEnd = parsedTime;
        print(dateTimeSelectedEnd);
        });
        }
  }

  @override
  void initState() {
    super.initState();
    cubit = context.read<MyActivityCubit>();
    loginCubit = context.read<LoginCubit>();
    refreshpage();
    popUpWidget = PopUpWidget(context);
    Permission.camera.request();
    print('paths :${_paths}');
  }

  void setData(GetTaskResponse.Data? response) {
    if (response != null) {
      print('Object not null');
      cubit.getProject(token!);
      cubit.getTaskById(token!, widget.response!.projectId!);
      response.forEach((element) {
        setState(() {
          resultProject.add(element.projectDesc!);
          if (element.projectId == widget.response?.projectId) {
            projectId = element.projectId!;
            widget.projectDesc = element.projectDesc!;
            debugPrint('selected is ' + projectId);
          }
        });
      });
      widget.taskDesc = widget.response?.taskDesc;
    }
    else {
      print('Object null');
    }
  }

  //---------------------------------------------------POP UP----------------------------------------------------------
  popUpTaskStatus() async {
    final result = await showCupertinoModalPopup(context: context, builder: (context) => MyActivityPopUpStatus());
    if (result != null) {
      setState(() {
        widget.status = '${result}';
      });
    }
  }

  popupFormat() {
    showCupertinoModalPopup(context: context, builder: (context) => MyActivityAlertFormat());
  }

  popupEdit() async {
    final result = await showCupertinoModalPopup(context: context, builder: (context) => MyActivityEdit());
    widget.id = result['id'].toString();
    List<Dokumen>? filenameList = result['filename'];
    widget.filename = filenameList;
    debugPrint('desc controller ${widget.filename}');
    descriptionController.setText(result['desc']);
    debugPrint('desc controller ${descriptionController}');
    widget.desc = result['desc'];
    dateTimeSelected = DateTimeUtils.convertStringToDateTime(result['timeStart']);
    dateTimeSelectedEnd = DateTimeUtils.convertStringToDateTime(result['timeEnd']);
    setState(() {
      projectId = result['projectId'];
      taskId = result['taskId'];
      widget.update = result['update'];
      widget.status = result['status'];
      widget.projectId = result['projectId'];
      widget.taskId = result['taskId'];
      widget.id = result['id'];
      widget.filename = result['filename'];
      
    });
  }

  Future<void> requestPermission() async {
    final permission = Permission.storage;
    await notifPermission.NotificationPermissions.requestNotificationPermissions;
    await notifPermission.NotificationPermissions.getNotificationPermissionStatus();
    await Permission.manageExternalStorage.request();
    await Permission.camera.request();
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
      } else {
      }
    } else {
      bool storage = true;
      bool videos = true;
      bool photos = true;
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        videos = await Permission.videos.status.isGranted;
        photos = await Permission.photos.status.isGranted;
      } else {
        storage = await Permission.storage.status.isGranted;
      }
      if (storage && videos && photos) {
      } else {
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
        allowMultiple: true,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'xlsx', 'pdf'],
      ))
          ?.files;
     
    } on PlatformException catch (e) {
    } catch (ex) {
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      _fileName = _paths != null ? _paths!.map((e) => e.name).toString() : '...';
      if(_paths != null) {
        widget.filename = null;
      }
    });
  }

  _openFileExplorerQuill() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
      );      if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files.first;
        if (file.path != null) {
          final _imagePath = file.path;
          final imageData = await File(_imagePath!).readAsBytes();
          final imageBase64 = base64Encode(imageData);
          descriptionController!.embedImage(
            'data:image/png;base64,$imageBase64',
          );
        }
      }
    } on PlatformException catch (e) {
    }
  }

  void resetState(String info2) {
   
    widget.projectDesc = 'Reguler';
    widget.projectId = 'P202300001';
    widget.taskId = 'P202300001-001';
    widget.taskDesc = 'My Task';
    dateTimeSelected = DateTime.now().subtract(Duration(minutes: DateTime.now().minute % 15));
    dateTimeSelectedEnd = DateTime.now().add(Duration(minutes: (15 - (DateTime.now().minute % 15)) % 15));
    widget.status = 'Perbarui Status';
    descriptionController.clear();
    uploadEdit = true;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(
              builder: (context) => Ramayana(),),
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
          fontSize: 23, 
          color: Colors.white)
        ),
        backgroundColor: baseColors.primaryColor,
        elevation: 5,
        toolbarHeight: 70,
        ),
        body: BlocListener<MyActivityCubit, MyActivityState>(
          listener: (context, state) {
            setState(() {
              widget.projectDesc;
              widget.taskDesc;
              widget.id;
            });
            if (state is MyActivityLoading) {
              setState(() {
                _loadingUpload = true;
              });
            }
            if (state is MyActivityButtonLoading) {
              setState(() {
                _loadingButton = true;
              });
            }
            if (state is MyActivitySuccess) {
              
              final response = state.response.data;
              response?.forEach((element) {
                setState(() {
                  resultProject.add(element.projectDesc ?? '');
                  if (element.projectId == widget.response?.projectId) {
                    projectId = element.projectId ?? '';
                    selectedProject = element.projectDesc ?? '';
                    widget.projectDesc = selectedProject;
                  }
                });
                if (projectId == element.projectId) {
                  setState(() {
                    widget.projectDesc = element.projectDesc;
                  });
                }
              });
              
            }
            if (state is MyActivityFailure) {
              loginCubit.createLog(baseParam.logInfoActivityInputSucc, state.message, urlApi);
              popUpWidget.showPopUpError('Gagal Submit', state.message);
              setState(() {
                _loadingButton = false;
              });
            }
            if (state is MyActivitySuccessGetTask) {
              _loadingUpload = false;
              final response = state.response.data;
              response?.forEach((element) {
                setState(() {
                  result.add(element.taskDesc ?? '');
                  if (element.taskId == widget.response?.taskId) {
                    taskId = element.taskId ?? '';
                    selectedTask = element.taskId ?? '';
                    widget.taskDesc = selectedTask;
                  }
                });
                if (taskId == element.taskId) {
                  setState(() {
                    widget.taskDesc = element.taskDesc;
                  });
                }
              });
            }
            if (state is MyActivitySuccessSubmit) {
               loginCubit.createLog(baseParam.logInfoActivityPage, '${baseParam.logInfoActivityInputSucc}${widget.response?.taskId ?? widget.taskId ?? 'P202300001-001'}', urlApi);
              resetState(baseParam.logInfoActivityInputSucc);
              popUpWidget.showPopupSuccess();
              setState(() {
                _paths = null;
                _loadingButton = false;
              });
            }
            if (state is MyActivitySuccessUpdate) {
              loginCubit.createLog(baseParam.logInfoActivityPage, '${baseParam.logInfoActityEdit}${widget.response?.taskId ?? widget.taskId ?? 'P202300001-001'}', urlApi);
              resetState(baseParam.logInfoActityEdit);
              widget.update = false;
              widget.filename = null;
              popUpWidget.showPopupSuccess();
              setState(() {
                _paths = null;
                _loadingButton = false;
              });
            }
          },
          child: Stack(children: [
            Container(
              margin: EdgeInsets.only(top: 10, left: 30, right: 30),
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
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        child: Image.asset('assets/calender.png'),),
                        Text('${formattedDate}',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 17, 
                            color: Colors.black),
                          )
                        ],
                      )),
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
                      fontWeight: FontWeight.w500)
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color(0xFFEFECF1), 
                        borderRadius: BorderRadius.circular(25)
                      ),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return RamayanaMyActivityProject(update: widget.update, desc: '${descriptionController.getDelta}', id: widget.id, dokumen: widget.filename);
                          }));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5, right: 15),
                                child: Image.asset('assets/project.png'),
                              ),
                              Text(
                                widget.projectDesc == null ? 'Reguler' : '${widget.projectDesc}',
                                style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Colors.black),
                              ),
                            ],),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Image.asset('assets/dropdown2.png'),
                            ),
                          ], ),
                        )),
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
                    fontWeight: FontWeight.w500)
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color(0xFFEFECF1), 
                      borderRadius: BorderRadius.circular(25)
                    ),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return RamayanaMyActivityTask(
                          update: widget.update, 
                          desc: '${descriptionController.getText()}', 
                          id: widget.id, 
                          projectId: widget.projectId ?? 'P202300001',
                          projectDesc: widget.projectDesc,
                          dokumen: widget.filename,
                        );
                      }));
                      },
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                        children: [
                          Padding(
                          padding: const EdgeInsets.only(left: 5, right: 15),
                          child: Image.asset('assets/task.png'),
                        ),
                        BlocBuilder<MyActivityCubit, MyActivityState>(builder: (context, state) {
                          if (state is MyActivityLoading) {
                            return Text('${widget.taskDesc ?? 'My Task'}',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 17, 
                                color: Colors.black
                              ),
                            );
                          }
                           if (state is MyActivitySuccessTask) {
                              if (state.response.data!.isEmpty) {
                                return Text('Pilih Task',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 17, 
                                    color: Colors.black
                                  ),
                                );
                              } else {
                                widget.taskId = widget.taskId ?? state.response.data?.first.taskId ?? '${widget.taskId}';
                                final taskDesc = widget.taskDesc ?? state.response.data?.first.taskDesc ?? '${widget.taskDesc}';
                                  return Text('${taskDesc}',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 17, 
                                      color: Colors.black
                                    ),
                                  );}
                              } else {
                                return Text('${widget.taskDesc ?? 'My Task'}',
                                  style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Colors.black),
                                );
                              }
                            }
                          )
                        ],),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Image.asset('assets/dropdown2.png'),
                        ),
                      ],),
                    )),
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
                          fontWeight: FontWeight.w500)
                        ),
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
                          child: widget.timeStart != null
                          ? Text('${widget.timeStart!.hour}:${widget.timeStart!.minute}',
                            style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            color: Colors.black,
                          ))
                          : Text('${DateTimeUtils.convertTohhmm(dateTimeSelected)}',
                            style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            color: Colors.black,
                          ))),
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
                          fontWeight: FontWeight.w500)
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          width: 150,
                          height: 40,
                          child: MaterialButton(
                            onPressed: () {
                              _openTimePickerSheetEnd(context);
                            },
                            color: Color(0xFFEFECF1),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            child: Text('${DateTimeUtils.convertTohhmm(dateTimeSelectedEnd)}',
                              style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              color: Colors.black,
                            )),
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
                      fontWeight: FontWeight.w500)
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color(0xFFEFECF1), 
                        borderRadius: BorderRadius.circular(25)
                      ),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          popUpTaskStatus();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Image.asset('assets/progress.png'),
                              ),
                              Text(
                              widget.status == null
                              ? 'Perbarui Status'
                              : widget.status! == 'Verification'
                                ? 'Closed'
                                : widget.status!,
                                style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Colors.black),
                              ),
                            ],),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Image.asset('assets/dropdown2.png'),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),

                SizedBox(
                  height: 10,
                ),
                Text('Deskripsi', 
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18, 
                  color: Colors.black, 
                  fontWeight: FontWeight.w500)
                ),
                SizedBox(
                  height: 10,
                ),
                ToolBar(
                  toolBarColor: baseColors.primaryColor,
                  padding: const EdgeInsets.all(8),
                  iconSize: 25,
                  iconColor: Colors.white,
                  activeIconColor: Colors.cyan,
                  controller: descriptionController,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction: Axis.horizontal,
                  toolBarConfig: [
                    ToolBarStyle.bold,
                    ToolBarStyle.italic,
                    ToolBarStyle.underline,
                    ToolBarStyle.strike,
                    ToolBarStyle.size,
                    ToolBarStyle.color,
                    ToolBarStyle.listBullet,
                    ToolBarStyle.listOrdered,
                    ToolBarStyle.align,
                    ToolBarStyle.addTable,
                  ],
                  customButtons: [
                    InkWell(onTap: () {
                      _openFileExplorerQuill();
                    },
                    child: const Icon(
                      Icons.image,
                        color: Colors.white,
                      )
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                QuillHtmlEditor(
                  text: '',
                  hintText: 'Masukkan Deskripsi',
                  controller: descriptionController,
                  isEnabled: true,
                  ensureVisible: false,
                  minHeight: 250,
                  autoFocus: false,
                  textStyle: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black),
                  hintTextStyle: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black),
                  hintTextAlign: TextAlign.start,
                  padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                  hintTextPadding: const EdgeInsets.only(left: 20,right: 20),
                  backgroundColor: Color(0xFFEFECF1),
                  inputAction: InputAction.newline,
                  onEditingComplete: (s) => debugPrint('Editing completed $s'),
                  loadingBuilder: (context) {
                    requestPermission();
                    return const Center(
                      child: SpinKitCircle(
                        color: Color.fromARGB(255, 255, 17, 17),
                        size: 60.0,
                        )
                    );
                  },
                ),

                    // -------------------------------------------UPLOAD DOKUMEN ----------------------------------------------
                SizedBox(height: 10),
                widget.filename == null
                ?
                Builder(
                  builder: (BuildContext context) => uploadEdit
                    ? ListTile(
                      title: Text(dokumen),)
                    : _loadingPath
                      ? AppWidget().LoadingWidget()
                      : _directoryPath != null
                        ? ListTile(
                          title: const Text('Directory path'),
                          subtitle: Text(_directoryPath!),
                        )
                        : _paths != null
                          ? Container(
                            height: 140,
                            child: Scrollbar(
                              child: ListView.separated(
                                itemCount: _paths != null && _paths!.isNotEmpty ? _paths!.length : 1,
                                itemBuilder: (BuildContext context, int index) {
                                  final bool isMultiPath = _paths != null && _paths!.isNotEmpty;
                                  nameFile = (isMultiPath ? _paths!.map((e) => e.name).toList()[index] : _fileName ?? '...');
                                  paths = _paths!.map((e) => e.path).toList()[index].toString();
                                  file = File(paths);
                                  return ListTile(
                                  title: 
                                  Text(nameFile ?? 'File : Tidak ada file yang dipilih'),
                                    subtitle: Text(paths ?? ''),
                                  );
                                  
                                },
                                separatorBuilder: (BuildContext context, int index) => const Divider(),
                               )),
                            )
                    : const SizedBox()
                )
                :
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.filename!.map((e){
                      return Text('File : ${e.filename}',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 15, 
                        color: Colors.black,
                        fontWeight: FontWeight.w500
                        ),
                      );
                    }).toList()
                  )
                 
                  
                ),

                Container(
                  margin: EdgeInsets.only(right: 200),
                  child: MaterialButton(
                  height: 45,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Color(0xFFEFECF1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/upload.png'),
                      Text(
                        'Upload Document',
                        style: GoogleFonts.plusJakartaSans(fontSize: 15, color: Colors.black),
                      )
                    ],
                  ),
                  onPressed: () {
                    requestPermission();
                    _openFileExplorer();
                  },
                ),
                ),
                SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                  children: [
                    MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      minWidth: 1000,
                      height: 50,
                      color: baseColors.primaryColor,
                      onPressed: () async {
                        editActivity();
                        widget.timeStart = null;
                      },
                      child: Text(
                        "Edit",
                        style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _loadingButton
                    ? AppWidget().LoadingWidget()
                    : widget.update
                      ? MaterialButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          minWidth: 1000,
                          height: 50,
                          color: baseColors.primaryColor,
                          onPressed: () async {
                            print(dateTimeSelected);
                            print(dateTimeSelectedEnd);
                            if (dateTimeSelected.isBefore(dateTimeSelectedEnd)) {
                              updateActivity();
                            } else {
                              PopUpWidget(context).showPopUpWarning('Waktu Mulai Harus Sebelum Waktu Selesai!', 'Ok');
                            }
                          },
                          child: Text("Update",
                            style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Colors.white),
                          ),
                        )
                      : MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        minWidth: 1000,
                        height: 50,
                        color: baseColors.primaryColor,
                        onPressed: () async {
                          getHtmlText();
                          if (dateTimeSelected.isBefore(dateTimeSelectedEnd)) {
                            submitActivity();
                          } else {
                            PopUpWidget(context).showPopUpWarning('Waktu Mulai Harus Sebelum Waktu Selesai!', 'Ok');
                          }
                        },
                        child: Text("Save",
                          style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Colors.white),
                        ),
                      ),
                ]),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          )
      ])));
  }

  submitActivity() async {
    try {
      final descBody = '';
    var body;
    if (_paths != null && _paths!.isNotEmpty ) {
      List<Dokumen> dataDokumenList = [];
      print('path : ${_paths}');
      for (var dokumen in _paths!) {
      File file = File(dokumen.path!);
      List<int> fileBytes = await file.readAsBytes();
      base64File = base64Encode(fileBytes);
      dataDokumenList.add(Dokumen(filename: dokumen.name, base64: base64File));
      
      }
      final bodyJson = jsonEncode(dataDokumenList.map((dokumen) => dokumen.toJson()).toList());
      print('body json ${bodyJson}');
      body = MyActivityBody(
        userCreate: '${userData.getUsername7()}',
        timeStart: '${dateTimeSelected}',
        timeEnd: '${dateTimeSelectedEnd}',
        taskId: '${widget.response?.taskId ?? widget.taskId ?? 'P202300001-001'}',
        projekId: '${widget.response?.projectId ?? widget.projectId ?? 'P202300001'}',
        myactivityDesc: await getHtmlText(),
        taskTechStatus: '${widget.status}',
        dokumen:dataDokumenList,
        dateCreate: '${DateTime.now()}',
      );
    } else {
      body = MyActivityBody(
        userCreate: '${userData.getUsername7()}',
        timeStart: '${dateTimeSelected}',
        timeEnd: '${dateTimeSelectedEnd}',
        taskId: '${widget.response?.taskId ?? widget.taskId ?? 'P202300001-001'}',
        projekId: '${widget.response?.projectId ?? widget.projectId ?? 'P202300001'}',
        myactivityDesc: await getHtmlText(),
        taskTechStatus: '${widget.status}',
        dokumen: [],
        dateCreate: '${DateTime.now()}',
      );
    }
      final bodyJson = jsonEncode(body.toJson());
      print('dokumen = ${bodyJson}');
      if (_checkStatusMandatory()) {
        cubit.submitactivity(token!, body);
      } else {
        PopUpWidget(context).showPopUpWarning('Harap pilih Status Projek', 'Ok');
      }
    } catch(e) {
      print('eror $e');
    }
  }

  updateActivity() async {
    var body;
    if (_paths != null && _paths!.isNotEmpty ) {
    List<Attachment> dataDokumenListUpdate = [];
    for (var dokumen in _paths!) {
    File file = File(_paths!.first.path!);
    List<int> fileBytes = await file.readAsBytes();
    base64File = base64Encode(fileBytes);
    dataDokumenListUpdate.add(
      Attachment(filename: dokumen.name, base64: base64File),
    );
    }
    body = MyActivityUpdateBody(
      userCreate: '${userData.getUsername7()}',
      timeStart: '${dateTimeSelected}',
      timeEnd: '${dateTimeSelectedEnd}',
      taskId: '${widget.response?.taskId ?? widget.taskId ?? 'P202300001-001'}',
      projekId: '${widget.response?.projectId ?? widget.projectId ?? 'P202300001'}',
      myactivityDesc: await getHtmlText(),
      myactivity_id: widget.id,
      taskTechStatus: '${widget.status}',
      dokumen: dataDokumenListUpdate,
      dateCreate: '${DateTime.now()}');
    } else {
      body = MyActivityUpdateBody(
      userCreate: '${userData.getUsername7()}',
      timeStart: '${dateTimeSelected}',
      timeEnd: '${dateTimeSelectedEnd}',
      taskId: '${widget.response?.taskId ?? widget.taskId ?? 'P202300001-001'}',
      projekId: '${widget.response?.projectId ?? widget.projectId ?? 'P202300001'}',
      myactivityDesc: await getHtmlText(),
      myactivity_id: widget.id,
      taskTechStatus: '${widget.status}',
      dateCreate: '${DateTime.now()}');
    }
    if (_checkStatusMandatory()) {
      cubit.updateactivity(token!, body);
      final bodyJson = jsonEncode(body.toJson());
      print('dokumen = ${bodyJson}');
    } else {
      PopUpWidget(context).showPopUpWarning('Harap pilih Status Projek', 'Ok');
    }
  }

  editActivity() async {
    final body = MyActivityEditBody(
      userCreate: '${userData.getUsername7()}',
    );
    cubit.editactivity(token!,body);
    popupEdit();
  }

  Future<String> getHtmlText() async {
    String? htmlText = await descriptionController.getText();
    debugPrint('html text : $htmlText');
    return htmlText;
  }

  Future<String?> fromHtmlText(String text) async {
    return 'htmlText';
  }

  bool _checkStatusMandatory() {
    if (widget.status == null) {
      return false;
    }

    return true;
  }
}
