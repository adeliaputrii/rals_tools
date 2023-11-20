part of'import.dart';

class RamayanaMyListTask extends StatefulWidget {
  const RamayanaMyListTask({super.key});

  @override
  State<RamayanaMyListTask> createState() => _RamayanaMyListTaskState();
}

class _RamayanaMyListTaskState extends State<RamayanaMyListTask> {
  
  var token  = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    
    Future.delayed(const Duration(seconds: 1), () async{
      await fetchDataListUser();
      loadData();
      print('delayed execution');
    });
  }

  loadData() async {
    setState(() {   
     isLoading=true;
       });
     await Future.delayed(const Duration(seconds: 3));
     await fetchDataListUser();
      print('delayed execution');
       setState(() {
        isLoading=false;
        });
  }

   _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print('token ${prefs.getString('token')}');
    setState(() {
      token = (prefs.getString('token') ?? '');
    });
    return token;
  }

  fetchDataListUser() async {
    _loadToken();
    TaskHome2.taskhome2.clear();
    final responseku = await http.get(
        Uri.parse('${tipeurl}v1/activity/task/get-task'),
        headers: 
        {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }
        );

    var data = jsonDecode(responseku.body);

    if (data['status'] == 200) {
      print("API Success oooo");
      print(data);
      int count = data['data'].length;
        
      for (int i = 0; i < count; i++) {
        TaskHome2.taskhome2
            .add(TaskHome2.fromjson(data['data'][i]));
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

    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      
       appBar: AppBar(
        leading: IconButton(
          onPressed: (
          ) {
             Navigator.pushReplacement(context,  MaterialPageRoute(builder: (_) {
      return DefaultBottomBarController(child: Ramayana());
    }));
          },
          icon: Icon(Icons.arrow_back_ios, color: Color.fromARGB(255, 230, 0, 0),),
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
          child: Text('My List Task', style:GoogleFonts.rubik(fontSize: 35, color: Color.fromARGB(255, 230, 0, 0), fontWeight: FontWeight.w500)),
        ), 
        Container(
          margin: EdgeInsets.fromLTRB(20, 80, 20, 0),
          // color: Colors.green,
          child: 
          isLoading ? SpinKitThreeBounce(
            color: Color.fromARGB(255, 230, 0, 0),
                    size: 50.0,
          ) :
          ListView(
            children: TaskHome2.taskhome2.map((e) {
              List dateCreate = [e.date_create];
              
              return
              Container(
                                height: 90,
                                margin: EdgeInsets.only(bottom: 15),
                                 decoration: BoxDecoration(
                                  
                      //        boxShadow: <BoxShadow>[
                      //   BoxShadow(
                      //       color: Color.fromARGB(255, 197, 197, 197),
                      //       blurRadius: 1,
                      //       spreadRadius: 1,
                      //       offset: Offset(2, 2))
                      // ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                          ),
                                
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Color.fromARGB(255, 255, 17, 17),
                                    radius: 30,
                                    backgroundImage: AssetImage('assets/todolist.png')),
                                   
                                    
                                    subtitle: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                      Container(
                                        child: Text('${e.task_desc}', style: GoogleFonts.plusJakartaSans(
                                        fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500
                                        ),),
                                      ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 80,
                                              child: Text('Status', style: GoogleFonts.plusJakartaSans(
                                                fontSize: 15, color: Colors.grey
                                              )),
                                            ),
                                            Text(': ${e.task_status}', style: GoogleFonts.plusJakartaSans(
                                              fontSize: 15, color: Colors.grey
                                            )),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 80,
                                              child: Text('Project ID', style: GoogleFonts.plusJakartaSans(
                                                fontSize: 15, color: Colors.grey
                                              )),
                                            ),
                                            Text(': ${e.project_id}', style: GoogleFonts.plusJakartaSans(
                                              fontSize: 15, color: Colors.grey
                                            )),
                                          ],
                                        ),
                                      ],
                                    ),
                                ),
                              );
                              
                             
                            }).toList()
            ),
        )
      ]),
    );
  }
}