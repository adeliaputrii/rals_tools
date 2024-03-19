part of 'import.dart';

class RamayanaMyActivityProject extends StatefulWidget {
  RamayanaMyActivityProject({super.key, this.update = false, this.desc, this.timeStart, this.timeEnd, this.id});

  bool update;
  String? desc;
  String? timeStart;
  String? timeEnd;
  String? id;

  @override
  State<RamayanaMyActivityProject> createState() => _RamayanaMyActivityProjectState();
}

class _RamayanaMyActivityProjectState extends State<RamayanaMyActivityProject> {
  late MyActivityCubit myactivityCubit;
  @override
  void initState() {
    super.initState();
    myactivityCubit = context.read<MyActivityCubit>();
    myactivityCubit.getProject();
    print('widget update ${widget.update}');
  }

  void _navigateToListTask(String projectId, String projectDesc) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return RamayanaMyActivityTask(
        update: widget.update,
        desc: widget.desc,
        id: widget.id,
        projectId: projectId,
        projectDesc: projectDesc,
      );
    })).then((_) {
      myactivityCubit.getProject();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => RamayanaMyActivity(update: widget.update, desc: widget.desc, id: widget.id)),
              (Route<dynamic> route) => false,
            );
            // Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 23,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: Text('List Project', style: GoogleFonts.plusJakartaSans(fontSize: 23, color: Colors.white)),
        backgroundColor: baseColors.primaryColor,
        elevation: 5,
        toolbarHeight: 80,
      ),
      body: Stack(
        children: [
          Container(
            child: BlocBuilder<MyActivityCubit, MyActivityState>(builder: (context, state) {
              if (state is MyActivityLoading) {
                return SpinKitThreeBounce(
                  color: Color.fromARGB(255, 230, 0, 0),
                  size: 50.0,
                );
              }
              if (state is MyActivitySuccess) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.response.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [BoxShadow(offset: Offset(2, 4), color: Colors.grey, blurRadius: 5)]),
                        child: MaterialButton(
                          onPressed: () {
                            _navigateToListTask(state.response.data?[index].projectId ?? '', state.response.data?[index].projectDesc ?? '');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 10),
                                // color: Colors.amber,
                                width: MediaQuery.of(context).size.width / 2,
                                child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Text('${state.response.data?[index].projectId}',
                                      style: GoogleFonts.plusJakartaSans(fontSize: 18, color: baseColors.primaryColor)),
                                  Text('${state.response.data?[index].projectDesc}',
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.plusJakartaSans(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500)),
                                ]),
                              ),
                              MaterialButton(
                                padding: const EdgeInsets.only(right: 10),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return RamayanaMyActivityTask(
                                      update: widget.update,
                                      desc: widget.desc,
                                      id: widget.id,
                                      projectId: '${state.response.data?[index].projectId}',
                                      projectDesc: '${state.response.data?[index].projectDesc}',
                                    );
                                  }));
                                },
                                child: Row(
                                  children: [
                                    Text('Pilih Task', style: GoogleFonts.plusJakartaSans(fontSize: 18, color: Colors.grey)),
                                    Image.asset('assets/dropdown.png'),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              }
              if (state is MyActivityFailure) {
                Center(
                  child: Text(
                    state.message,
                    style: GoogleFonts.plusJakartaSans(fontSize: 20, color: Colors.black),
                  ),
                );
              }
              return Container();
            }),
          ),
        ],
      ),
    );
  }
}
