
part of 'import.dart';

class RamayanaInformasi extends StatefulWidget {
  const RamayanaInformasi({super.key});

  @override
  State<RamayanaInformasi> createState() => _RamayanaInformasiState();
}

class _RamayanaInformasiState extends State<RamayanaInformasi> {
  TextEditingController searchController = TextEditingController();
  late HomeCubit cubit;
  late LoginCubit loginCubit;
  late PopUpWidget popUpWidget;
  Timer? _debounceTimer;
  AppWidget appWidget = AppWidget();
  List<NewsListResponse.Data> listDataPaging = [];

  String? nextUrlCursor;
  String? token;
  int count = 0;

  bool isLoaded = false;
  bool? arsipButton;
  bool arsipPage = false;
  String title = "";

  @override
  void initState() {
    super.initState();
    cubit = context.read<HomeCubit>();
    popUpWidget = PopUpWidget(context);
    refreshpage();
  }

  refreshpage() async {
    token = await SharedPref.getToken();
    cubit.getNewsList(token!);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void search(String text) {
    listDataPaging.clear();
    isLoaded = false;
    setState(() {
      nextUrlCursor = "null";
      title = text;
    });
    if (isLoaded) {
      return;
    }
    cubit.searchNewsList(token ?? '', query: title);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) {
                return Ramayana();
              }), (route) => false);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          toolbarHeight: 75,
          title: Text('Arsip Berita',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 23, color: Colors.white)),
          backgroundColor: baseColors.primaryColor,
        ),
        body: Stack(children: [
          Container(
            child: Image.asset(
              'assets/newsBackground.png',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
          ),
          ListView(
            children: [
              arsipPage
                  ? SizedBox()
                  : Container(
                      margin: EdgeInsets.only(bottom: 10),
                      color: baseColors.primaryColor,
                      width: screenWidth,
                      height: 65,
                      child: SearchInputReport(
                        controller: searchController,
                        onSelectedCallback: (value) {
                          _debounceTimer?.cancel();
                          _debounceTimer = Timer(Duration(seconds: 1), () {
                            search(value);
                          });
                        },
                      )),
              BlocListener<HomeCubit, HomeState>(
                listener: (context, state) {
                  if (state is HomeNewsSuccess) {
                    if (state.response.data!.length < 16) {
                      setState(() {
                      count = state.response.data!.length;
                      arsipButton = false;
                      });
                      
                    } else {
                      setState(() {
                      count = 15;
                      arsipButton = true;
                      });
                      
                    }
                  }
                },
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                  if(state is HomeNewsFailure) {
                    return Center(
                      child: Text(
                        'Tidak tersedia arsip berita',
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    );
                  }
                  if (state is HomeNewsSuccess) {
                    if (state.response.data!.isNotEmpty) {
                      return ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount:
                              arsipPage ? state.response.data?.length : count,
                          itemBuilder: (build, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return NewsDetail(
                                      newsUrl:
                                          state.response.data?[index].newsUrl ??
                                              '',
                                      fromHome: false);
                                }));
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: 10, right: 10, left: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 5,
                                          offset: Offset(1, 3)),
                                    ]),
                                height: 150,
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 20,
                                          right: 10,
                                          bottom: 15,
                                          left: 10),
                                      width: 180,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                            '${state.response.data?[index].urlPhoto}',
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: 30,
                                            right: 10,
                                            bottom: 15,
                                            left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15),
                                              child: Text(
                                                '${state.response.data?[index].beritaHdr}',
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(),
                                                Text(
                                                  'Lihat Selengkapnya>>>',
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                          fontSize: 14,
                                                          color: Color.fromARGB(
                                                              255, 255, 0, 0),
                                                          fontWeight:
                                                              FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      return Center(
                        child: Text(
                          'Tidak tersedia arsip berita',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      );
                    }
                  }

                  return appWidget.LoadingWidget();
                }),
              ),
              arsipPage
              ?
              SizedBox()
              :
              arsipButton == true
              ?
              Container(
                margin: EdgeInsets.all(20),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  color: baseColors.primaryColor,
                  onPressed: () {
                    setState(() {
                      arsipPage = true;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Lihat semua arsip berita',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                      ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(IconlyLight.arrowRightCircle,
                      color: Colors.white,
                      size: 20,
                      )
                    ],
                  )
                  ),
              )
              :
              SizedBox()
            ],
          )
        ]));
  }
}
