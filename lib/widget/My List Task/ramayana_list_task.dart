part of 'import.dart';

class RamayanaMyListTask extends StatefulWidget {
  const RamayanaMyListTask({super.key});
  static const route = '/ramayana-list-screen';
  @override
  State<RamayanaMyListTask> createState() => _RamayanaMyListTaskState();
}

class _RamayanaMyListTaskState extends State<RamayanaMyListTask> {
  var token = '';
  bool isLoading = false;
  bool isMounted = true;
  late HomeCubit homeCubit;
  late LoginCubit loginCubit;
  final urlApi = '${tipeurl}${basePath.api_login}';
  @override
  void initState() {
    super.initState();
    homeCubit = context.read<HomeCubit>();
    homeCubit.getTaskUser();
    Future.delayed(const Duration(seconds: 1), () async {
      await fetchDataListUser();
      loadData();
      print('delayed execution');
    });
  }

  @override
  void dispose() {
    isMounted = false;
    super.dispose();
  }

  loadData() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
      try {
        await Future.delayed(const Duration(seconds: 3));
        await fetchDataListUser();
        print('delayed execution');
      } finally {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }

  _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserData userData = UserData();
    print('token ${prefs.getString('token')}');
    if (isMounted) {
      setState(() {
        token = userData.getUserToken();
      });
    }

    return token;
  }

  fetchDataListUser() async {
    _loadToken();
    TaskHome2.taskhome2.clear();
    final responseku = await http
        .get(Uri.parse('${tipeurl}v1/activity/task/get-task'), headers: {
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
        TaskHome2.taskhome2.add(TaskHome2.fromjson(data['data'][i]));
      }
      final Map<String, TaskHome2> profileMap = new Map();
      TaskHome2.taskhome2.forEach((element) {
        profileMap[element.task_id] = element;

        TaskHome2.taskhome2 = profileMap.values.toList();
      });
      print('check length ${TaskHome2.taskhome2.length}');
      print(data['data'].toString());
    } else {
      print(data['status']);
      print('NO DATA');
    }
  }

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
            //   return DefaultBottomBarController(child: Ramayana());
            // }));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(255, 230, 0, 0),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        elevation: 0,
      ),
      body: Stack(children: [
        Container(
          color: Color.fromARGB(255, 242, 242, 242),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
          // color: Colors.green,
          height: 100,
          child: Text('Tugas saya',
              style: GoogleFonts.rubik(
                  fontSize: 35,
                  color: Color.fromARGB(255, 230, 0, 0),
                  fontWeight: FontWeight.w500)),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(20, 80, 20, 0),
          child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
            if (state is HomeLoading) {
              return SpinKitThreeBounce(
                color: Color.fromARGB(255, 230, 0, 0),
                size: 50.0,
              );
            }
            if (state is HomeSuccess) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.response.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return RamayanaMyActivity(
                            update: false,
                            response: state.response.data?[index]);
                      }));
                    },
                    child: Container(
                      height: 90,
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Color.fromARGB(255, 197, 197, 197),
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: Offset(2, 2))
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return RamayanaMyActivity(
                                update: false,
                                response: state.response.data?[index]);
                          }));
                          loginCubit.createLog(
                              logInfoActivityPage,
                              '${state.response.data?[index].taskDesc}' +
                                  '-' +
                                  '${state.response.data?[index].projectId}',
                              urlApi);
                        },
                        leading: CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 210, 14, 0),
                            radius: 30,
                            backgroundImage: AssetImage('assets/todolist.png')),
                        // title: Text('${e.task_desc}', style: GoogleFonts.plusJakartaSans(
                        //   fontSize: 18, color: Colors.black
                        // ),),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 3),
                              child: Text(
                                '${state.response.data?[index].taskDesc}',
                                style: GoogleFonts.plusJakartaSans(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 80,
                                  child: Text('Status',
                                      style: GoogleFonts.plusJakartaSans(
                                          fontSize: 15, color: Colors.grey),overflow: TextOverflow.ellipsis),
                                ),
                                Text(
                                    '${state.response.data?[index].taskStatus}',
                                    style: GoogleFonts.plusJakartaSans(
                                        fontSize: 15, color: Colors.grey),overflow: TextOverflow.ellipsis),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 80,
                                  child: Text('Project ID',
                                      style: GoogleFonts.plusJakartaSans(
                                          fontSize: 15, color: Colors.grey)),
                                ),
                                Text(
                                    ': ${state.response.data?[index].projectId}',
                                    style: GoogleFonts.plusJakartaSans(
                                        fontSize: 15, color: Colors.grey),overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return Container();
          }),
        )
      ]),
    );
  }
}
