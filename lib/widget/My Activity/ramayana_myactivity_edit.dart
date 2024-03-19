part of 'import.dart';

class MyActivityEdit extends StatefulWidget {
  MyActivityEdit({super.key, this.project, this.task});

  List? project;
  List? task;

  @override
  State<MyActivityEdit> createState() => _MyActivityEditState();
}

class _MyActivityEditState extends State<MyActivityEdit> {
  late MyActivityCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
    cubit = context.read<MyActivityCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
        child: Builder(builder: (context) {
          return Column(
            children: [
              Container(
                  padding: const EdgeInsets.only(
                    top: 20,
                  ),
                  height: 220,
                  child: FadeInImageWidget(
                    imageUrl: 'assets/edit.png',
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text('Pilih Tugas', style: GoogleFonts.plusJakartaSans(fontSize: 20, color: Color.fromARGB(255, 135, 11, 2))),
              ),
              Container(
                height: 300,
                // color: Colors.amber,
                child: BlocBuilder<MyActivityCubit, MyActivityState>(builder: (context, state) {
                  if (state is MyActivityLoading) {
                    return SpinKitThreeBounce(
                      color: Color.fromARGB(255, 230, 0, 0),
                      size: 50.0,
                    );
                  }
                  if (state is MyActivitySuccessGetTask) {
                    print('task successss');
                    for (var projectData in state.response.data!) {}
                  }

                  if (state is MyActivitySuccess) {
                    print('task successss');
                    for (var projectData in state.response.data!) {}
                  }
                  if (state is MyActivityEditSuccess) {
                    if (state.response.data!.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 50),
                          child: Text("${state.response.data!.length}", style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.black)),
                        ),
                      );
                    } else {
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
                                child: MaterialButton(
                                  onPressed: () async {
                                    cubit.getProject();
                                    cubit.getTaskUser();
                                    Navigator.pop(context, {
                                      'projectId': state.response.data?[index].projekId,
                                      'taskId': state.response.data?[index].taskId,
                                      'update': true,
                                      'status': state.response.data?[index].myactivityStatus,
                                      'timeStart': state.response.data?[index].timeStart,
                                      'timeEnd': state.response.data?[index].timeEnd,
                                      'desc': state.response.data?[index].myactivityDesc,
                                      'id': state.response.data?[index].myactivityId
                                    });
                                    debugPrint('ID PROJECT ${state.response.data?[index].myactivityId}');
                                  },
                                  child: ListTile(
                                    leading: Container(
                                      // color: Colors.amber,
                                      child: FadeInImageWidget(
                                        imageUrl: 'assets/tasklist.png',
                                      ),
                                      height: 50,
                                      width: 50,
                                    ),
                                    title: Text(
                                      '${state.response.data?[index].myactivityDesc}',
                                      style: GoogleFonts.plusJakartaSans(fontSize: 15, color: Colors.black),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    subtitle: Text(
                                      '${state.response.data?[index].timeStart} s/d ${state.response.data?[index].timeEnd}',
                                      style: GoogleFonts.plusJakartaSans(fontSize: 13, color: Colors.grey),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ));
                          });
                    }
                  }
                  return Container();
                }),
              )
            ],
          );
        }),
      ),

      actionsAlignment: MainAxisAlignment.start,
      actionsPadding: EdgeInsets.only(bottom: 20),
    );
  }
}
