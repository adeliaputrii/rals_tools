part of 'import.dart';

class RamayanaMyActivity extends StatefulWidget {
  RamayanaMyActivity(
      {super.key,
      this.response,
      this.responseEdit,
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
  UserData userData = UserData();

  late MyActivityCubit cubit;
  late LoginCubit loginCubit;
  late PopUpWidget popUpWidget;
  final urlApi = '${tipeurl}${basePath.api_login}';

  File? file;

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

  DateTime dateTimeSelected = DateTime.now();
  DateTime dateTimeSelectedEnd = DateTime.now();

  void _openTimePickerSheet(BuildContext context) async {
    final result = await DateTimeUtils.openTimePickerSheet(context);

    if (result != null) {
      setState(() {
        dateTimeSelected = result;
      });
    }
  }

  void _openTimePickerSheetEnd(BuildContext context) async {
    final result = await DateTimeUtils.openTimePickerSheet(context);
    if (result != null) {
      setState(() {
        dateTimeSelectedEnd = result;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    cubit = context.read<MyActivityCubit>();
    loginCubit = context.read<LoginCubit>();
    setData(widget.response);
    popUpWidget = PopUpWidget(context);
    Permission.camera.request();
  }

  void setData(GetTaskResponse.Data? response) {
    if (response != null) {
      cubit.getProject();
      cubit.getTaskById(widget.response!.projectId!);
      response.forEach((element) {
        setState(() {
          resultProject.add(element.projectDesc!);
          if (element.projectId == widget.response!.projectId) {
            projectId = element.projectId!;
            widget.projectDesc = element.projectDesc!;
            debugPrint('selected is ' + projectId);
          }
        });
      });
      widget.taskDesc = widget.response!.taskDesc;
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

    myActId = result['id'].toString();
    // descriptionController.setText(result['desc']);
    // debugPrint('desc controller ${descriptionController}');
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
    });
  }

  Future<void> requestPermission() async {
    final permission = Permission.storage;
    print('permission');
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
        // Awesome
      } else {
        // Crap
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

      _fileName = _paths != null ? _paths!.map((e) => e.name).toString() : '...';
    });
  }

  _openFileExplorerQuill() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
      );

      if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files.first;
        if (file.path != null) {
          final _imagePath = file.path;
          final imageData = await File(_imagePath!).readAsBytes();
          final imageBase64 = base64Encode(imageData);
          // descriptionController!.embedImage(
          //   'data:image/png;base64,$imageBase64',
          // );
        }
      }
    } on PlatformException catch (e) {
      print("Error picking image: $e");
    }
  }

  void resetState(String info2) {
    widget.projectDesc = 'Reguler';
    widget.projectId = 'P202300001';
    widget.taskId = 'P202300001-001';
    widget.taskDesc = 'My Task';
    dateTimeSelected = DateTime.now();
    dateTimeSelectedEnd = DateTime.now();
    widget.status = 'Perbarui Status';
    // descriptionController.clear();
    uploadEdit = true;
    loginCubit.createLog(baseParam.logInfoActivityPage, info2, urlApi);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DefaultBottomBarController(child: Ramayana()),
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
          title: Text('My Activity', style: GoogleFonts.plusJakartaSans(fontSize: 23, color: Colors.white)),
          backgroundColor: baseColors.primaryColor,
          elevation: 5,
          toolbarHeight: 80,
        ),
        body: BlocListener<MyActivityCubit, MyActivityState>(
            listener: (context, state) {
              setState(() {
                widget.projectDesc;
                widget.taskDesc;
                widget.id;
                // widget.descriptionController = description;
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
                      debugPrint('selected is ' + projectId);
                    }
                  });
                  if (projectId == element.projectId) {
                    setState(() {
                      widget.projectDesc = element.projectDesc;
                      debugPrint('is triggereed');
                    });
                  }
                });
                debugPrint('result Project' + resultProject.toString());
              }

              if (state is MyActivityFailure) {
                popUpWidget.showPopUpError('Gagal Submit', state.message);
                setState(() {
                  _loadingButton = false;
                });
                loginCubit.createLog(baseParam.logInfoActivityPage, state.message, urlApi);
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
                      debugPrint('selected TASK is ' + taskId);
                    }
                  });
                  if (taskId == element.taskId) {
                    setState(() {
                      widget.taskDesc = element.taskDesc;
                      debugPrint('is triggereed task');
                    });
                  }
                });
                debugPrint('result Task' + result.toString());
              }
              if (state is MyActivitySuccessSubmit) {
                resetState(baseParam.logInfoActivityInputSucc);
                popUpWidget.showPopupSuccess();
                setState(() {
                  _loadingButton = false;
                });
              }
              if (state is MyActivitySuccessUpdate) {
                resetState(baseParam.logInfoActityEdit);
                widget.update = false;
                popUpWidget.showPopupSuccess();
                setState(() {
                  _loadingButton = false;
                });
              }
            },
            child: Stack(children: [
              Container(
                margin: EdgeInsets.only(top: 10, left: 30, right: 30),
                // height: 450,
                // width: 300,
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tanggal', style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                            height: 60,
                            decoration: BoxDecoration(color: Color(0xFFEFECF1), borderRadius: BorderRadius.circular(25)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 10),
                                  child: Image.asset('assets/calender.png'),
                                ),
                                Text(
                                  '${formattedDate}',
                                  style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Colors.black),
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
                        Text('Project', style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                            height: 60,
                            decoration: BoxDecoration(color: Color(0xFFEFECF1), borderRadius: BorderRadius.circular(25)),
                            child: MaterialButton(
                              // color: Colors.amber,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return RamayanaMyActivityProject(update: widget.update, desc: 'descriptionController.toString()', id: widget.id);
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
                                    ],
                                  ),
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

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tugas', style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500)),
                        Container(
                            margin: EdgeInsets.only(top: 5),
                            height: 60,
                            decoration: BoxDecoration(color: Color(0xFFEFECF1), borderRadius: BorderRadius.circular(25)),
                            child: MaterialButton(
                              // color: Colors.amber,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              onPressed: () {
                                if (widget.projectId == null) {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return RamayanaMyActivityTask(
                                        desc: 'descriptionController.toString()',
                                        update: widget.update,
                                        projectId: 'P202300001',
                                        projectDesc: 'Reguler',
                                        id: widget.id);
                                  }));
                                } else {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return RamayanaMyActivityTask(
                                        desc: 'descriptionController.toString()',
                                        update: widget.update,
                                        projectId: '${widget.projectId}',
                                        projectDesc: '${widget.projectDesc}',
                                        id: widget.id);
                                  }));
                                }
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
                                      Text(
                                        widget.taskDesc == null ? 'My Task' : '${widget.taskDesc}',
                                        style: GoogleFonts.plusJakartaSans(fontSize: 17, color: Colors.black),
                                      ),
                                    ],
                                  ),
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
                      height: 15,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text('Waktu Mulai', style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500)),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            width: 150,
                            height: 40,
                            child: MaterialButton(
                                onPressed: () {
                                  _openTimePickerSheet(context);
                                },
                                color: Color(0xFFEFECF1),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                        Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text('Waktu Selesai', style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500)),
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
                        Text('Status Tugas', style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500)),
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 60,
                            decoration: BoxDecoration(color: Color(0xFFEFECF1), borderRadius: BorderRadius.circular(25)),
                            child: MaterialButton(
                              // color: Colors.amber,
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
                                    ],
                                  ),
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

                    Text('Deskripsi', style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500)),
                    SizedBox(
                      height: 10,
                    ),
                    // ToolBar(
                    //   toolBarColor: baseColors.primaryColor,
                    //   padding: const EdgeInsets.all(8),
                    //   iconSize: 25,
                    //   iconColor: Colors.white,
                    //   activeIconColor: Colors.cyan,
                    //   controller: descriptionController,
                    //   crossAxisAlignment: WrapCrossAlignment.start,
                    //   direction: Axis.horizontal,
                    //   toolBarConfig: [
                    //     ToolBarStyle.bold,
                    //     ToolBarStyle.italic,
                    //     ToolBarStyle.underline,
                    //     ToolBarStyle.strike,
                    //     ToolBarStyle.size,
                    //     ToolBarStyle.color,
                    //     ToolBarStyle.listBullet,
                    //     ToolBarStyle.listOrdered,
                    //     ToolBarStyle.align,
                    //     ToolBarStyle.addTable,
                    //     // ToolBarStyle.image,
                    //     ],
                    //     customButtons: [
                    //       InkWell(onTap: () {
                    //         _openFileExplorerQuill();
                    //       },
                    //       child: const Icon(
                    //         Icons.image,
                    //         color: Colors.white,
                    //         )),
                    //     ],
                    //     ),

                    SizedBox(
                      height: 15,
                    ),

                    // QuillHtmlEditor(
                    //   text: '',
                    //   hintText: 'Masukkan Deskripsi',
                    //   controller: descriptionController,
                    //   isEnabled: true,
                    //   ensureVisible: false,
                    //   minHeight: 250,
                    //   autoFocus: false,
                    //   textStyle: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black),
                    //   hintTextStyle: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black),
                    //   hintTextAlign: TextAlign.start,
                    //   padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                    //   hintTextPadding: const EdgeInsets.only(left: 20,right: 20),
                    //   backgroundColor: Color(0xFFEFECF1),
                    //   inputAction: InputAction.newline,
                    //   onEditingComplete: (s) => debugPrint('Editing completed $s'),
                    //   loadingBuilder: (context) {
                    //     requestPermission();
                    //     return const Center(
                    //       child: SpinKitCircle(
                    //         color: Color.fromARGB(255, 255, 17, 17),
                    //         size: 60.0,
                    //         ));
                    //           },
                    //           onFocusChanged: (focus) {
                    //             debugPrint('has focus $focus');
                    //             setState(() {
                    //               debugPrint('widget text change $focus');
                    //             });
                    //           },
                    //           onTextChanged: (text) => debugPrint('widget text change $text'),
                    //           onEditorCreated: () {
                    //             debugPrint('Editor has been loaded');
                    //             // setHtmlText('Testing text on load');
                    //           },
                    //           onEditorResized: (height) =>
                    //               debugPrint('Editor resized $height'),
                    //           onSelectionChanged: (sel) =>
                    //               debugPrint('index ${sel.index}, range ${sel.length}'),
                    //         ),

                    // -------------------------------------------UPLOAD DOKUMEN ----------------------------------------------
                    SizedBox(height: 10),

                    Builder(
                        builder: (BuildContext context) => uploadEdit
                            ? ListTile(
                                title: Text(dokumen),
                              )
                            : _loadingPath
                                ? AppWidget().LoadingWidget()
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
                                              itemCount: _paths != null && _paths!.isNotEmpty ? _paths!.length : 1,
                                              itemBuilder: (BuildContext context, int index) {
                                                final bool isMultiPath = _paths != null && _paths!.isNotEmpty;
                                                nameFile = (isMultiPath ? _paths!.map((e) => e.name).toList()[index] : _fileName ?? '...');
                                                paths = _paths!.map((e) => e.path).toList()[index].toString();

                                                file = File(paths);
                                                print(file);

                                                return ListTile(
                                                  title: Text(
                                                    nameFile!,
                                                  ),
                                                  subtitle: Text(paths),
                                                );
                                              },
                                              separatorBuilder: (BuildContext context, int index) => const Divider(),
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

                    Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
                                    if (dateTimeSelected.isBefore(dateTimeSelectedEnd)) {
                                      updateActivity();
                                    } else {
                                      PopUpWidget(context).showPopUpWarning('Waktu Mulai Harus Sebelum Waktu Selesai!', 'Ok');
                                    }
                                  },
                                  child: Text(
                                    "Update",
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
                                  child: Text(
                                    "Save",
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
    final descBody = '';
    // debugPrint('descriptionController cont 1${descriptionController.toString()}');
    if (_paths != null && _paths!.isNotEmpty) {
      // Ubah PlatformFile menjadi File
      File file = File(_paths!.first.path!);
      // Baca konten file sebagai bytes
      List<int> fileBytes = await file.readAsBytes();
      // Encode bytes sebagai base64
      base64File = base64Encode(fileBytes);
      // debugPrint('descriptionController descriptionController ${descriptionController.toString()}');
      // Buat dan kirim body permintaan setelah pemilihan file selesai
      final body = MyActivityBody(
        user_create: '${userData.getUsername7()}',
        time_start: '${dateTimeSelected}',
        time_end: '${dateTimeSelectedEnd}',
        task_id: '${widget.taskId ?? 'P202300001-001'}',
        projek_id: '${widget.projectId ?? 'P202300001'}',
        myactivity_desc: await getHtmlText(),
        task_tech_status: '${widget.status}',
        dokumen: base64File,
        date_create: '${DateTime.now()}',
      );
      debugPrint('body myact ${body.toString()}');
      debugPrint('Dokumen yg dipilih : ada');
      cubit.submitactivity(body);
    } else {
      final body = MyActivityBody(
        user_create: '${userData.getUsername7()}',
        time_start: '${dateTimeSelected}',
        time_end: '${dateTimeSelectedEnd}',
        task_id: '${widget.taskId ?? 'P202300001-001'}',
        projek_id: '${widget.projectId ?? 'P202300001'}',
        myactivity_desc: await getHtmlText(),
        task_tech_status: '${widget.status}',
        dokumen: '',
        date_create: '${DateTime.now()}',
      );
      if (_checkStatusMandatory()) {
        cubit.submitactivity(body);
      } else {
        PopUpWidget(context).showPopUpWarning('Harap pilih Status Projek', 'Ok');
      }
    }
    debugPrint('Dokumen yg dipilih : tidak ada');
  }

  updateActivity() async {
    // widget.desc = descriptionController.toString();
    widget.id;
    final body = MyActivityUpdateBody(
        user_create: '${userData.getUsername7()}',
        time_start: '${dateTimeSelected}',
        time_end: '${dateTimeSelectedEnd}',
        task_id: '${widget.taskId ?? 'P202300001-001'}',
        projek_id: '${widget.projectId ?? 'P202300001'}',
        myactivity_desc: await getHtmlText(),
        myactivity_id: myActId,
        task_tech_status: '${widget.status}',
        dokumen: '',
        date_create: '${DateTime.now()}');
    debugPrint('body update' + body.toString());
    if (_checkStatusMandatory()) {
      cubit.updateactivity(body);
    } else {
      PopUpWidget(context).showPopUpWarning('Harap pilih Status Projek', 'Ok');
    }
  }

  editActivity() async {
    final body = MyActivityEditBody(
      userCreate: '${userData.getUsername7()}',
    );
    cubit.editactivity(body);
    popupEdit();
  }

  Future<String> getHtmlText() async {
    // String? htmlText = await descriptionController.getText();
    // debugPrint(htmlText);
    return 'htmlText';
  }

  Future<String?> fromHtmlText(String text) async {
    // String? htmlText = await descriptionController.setText(text);
    // debugPrint(htmlText);
    return 'htmlText';
  }

  bool _checkStatusMandatory() {
    if (widget.status == null) {
      return false;
    }

    return true;
  }
}
