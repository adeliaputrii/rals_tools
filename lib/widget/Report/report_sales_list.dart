part of 'import.dart';

class ReportSalesList extends StatefulWidget {
  const ReportSalesList({super.key});
  @override
  State<ReportSalesList> createState() => _ReportSalesListState();
}

class _ReportSalesListState extends State<ReportSalesList> with AutomaticKeepAliveClientMixin {
  TransformationController controller = TransformationController();
  TextEditingController searchController = TextEditingController();

  List<ReportListResponse> listReport = [];
  List<ReportListResponse> listReportSearch = [];
  List<PagingResponse.Data> listDataSearch = [];
  List<PagingResponse.Data> listDataPaging = [];

  bool isLoaded = false;
  bool isLoading = true;
  bool isSearch = false;

  late ReportCubit reportCubit;
  late LoginCubit loginCubit;
  late PopUpWidget popUpWidget;

  String searchQuery = '';
  String title = "";
  String? nextUrlCursor;
  String urlDetail = 'https://www.youtube.com/';
  String? token;
  String? _chosenValue = 'All';

  int progressBar = 0;
  final scrollController = ScrollController();
  Timer? _debounceTimer;

  @override
  void initState() {
    reportCubit = context.read<ReportCubit>();
    popUpWidget = PopUpWidget(context);
    _debounceTimer?.cancel();
    refreshPage();
    super.initState();
  }

  refreshPage() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    token = await SharedPref.getToken();
    initDataReport();
    scrollListener();
    searchController.clear();
  }

  void initDataReport() {
    reportCubit.getListReportPagination(token ?? '',"", "", "", "");
    loginCubit.createLog(baseParam.logInfoReportPage, baseParam.logInfoNavigateReportPage, basePath.api_report_list_pagination);
  }

  void scrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        getListReport();
      }
    });
  }

  void search(String text) {
    listDataPaging.clear();
    isLoaded = false;
    setState(() {
      nextUrlCursor = "null";
      title = text;
    });

    getListReport();
  }

  void getListReport() {
    if (isLoaded) {
      return;
    }
    if (nextUrlCursor != null) {
      reportCubit.getListReportPagination(token ?? '', nextUrlCursor, title, "", "");
    } else {
      popUpWidget.showToastMessage('Tidak ada data lagi..');
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
  @override
  void dispose() {
    searchController.dispose();
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void _onBackPressed() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: () async {
          if (true) {
            _onBackPressed();

            return true;
          }
        },
        child: Scaffold(
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
            centerTitle: true,
            title: Text('Laporan',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 23, color: Colors.white)),
            backgroundColor: baseColors.primaryColor,
          ),
            body: Stack(
              children: [
                Container(
                child: Image.asset(
                  'assets/reportBackground.png',
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                ),
              ),
                BlocBuilder<ReportCubit, ReportState>(builder: (context, state) {
                  if (state is ReportInitial) {
                    return loading();
                  }
                
                  if (state is ReportLoading) {
                    if (listDataPaging.isEmpty) {
                      return loading();
                    } else {
                      return searchEmpty();
                    }
                  }
                
                  if (state is ReportPaginationSuccess) {
                    String? url = state.response.nextPageUrl;
                
                    if (url != null) {
                      Uri uri = Uri.parse(url);
                      Map<String, dynamic> queryParams = uri.queryParameters;
                      String cursorValue = queryParams['cursor'];
                      nextUrlCursor = cursorValue;
                    } else {
                      nextUrlCursor = null;
                      isLoaded = true;
                    }
                
                    if (state.response.data?.isNotEmpty ?? false) {
                      state.response.data?.forEach((element) {
                        bool headerExists = listDataPaging.any((existingElement) => existingElement.header1 == element.header1);
                        if (!headerExists) {
                          listDataPaging.add(element);
                        }
                        // listDataPaging.add(element);
                      });
                      if (listDataPaging.isNotEmpty) {
                        debugPrint('data length ${listDataPaging.length}');
                        return searchEmpty();
                      } else {
                        return Center(child: AppWidget().EmptyHandler(baseParam.emptyDataReportMessage));
                      }
                    }
                  }
                
                  if (state is ReportInsertViewerSuccess) {
                    listDataPaging.clear();
                    String? url = state.response.nextPageUrl;
                
                    if (url != null) {
                      isLoaded = false;
                      Uri uri = Uri.parse(url);
                      Map<String, dynamic> queryParams = uri.queryParameters;
                      String cursorValue = queryParams['cursor'];
                      nextUrlCursor = cursorValue;
                    } else {
                      nextUrlCursor = null;
                      isLoaded = true;
                    }
                
                    if (state.response.data?.isNotEmpty ?? false) {
                      state.response.data?.forEach((element) {
                        bool headerExists = listDataPaging.any((existingElement) => existingElement.header1 == element.header1);
                        if (!headerExists) {
                          listDataPaging.add(element);
                        }
                        // listDataPaging.add(element);
                      });
                      if (listDataPaging.isNotEmpty) {
                        return searchEmpty();
                      } else {
                        return Center(child: AppWidget().EmptyHandler(baseParam.emptyDataReportMessage));
                      }
                    }
                  }
                
                  if (state is ReportFailure) {
                    return AppWidget().ErrorHandler(baseParam.errorReportMessage, getListReport);
                  }
                  return searchEmpty();
                }),
              ],
            )));
  }

  Widget searchEmpty() {
    final filteredList = _chosenValue != 'All'
    ? listDataPaging.where((item) => item.category!.contains(_chosenValue!)).toList()
    : listDataPaging;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          color: baseColors.primaryColor,
          width: 500,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 350,
                child: SearchInputReport(
                  controller: searchController,
                    onSelectedCallback: (value) {
                      _debounceTimer?.cancel();
                      _debounceTimer = Timer(Duration(seconds: 1), () {
                      search(value);
                    });
                  },
                ),
              ),
              Container(
                width: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                margin: EdgeInsets.only(right: 20, bottom: 20),
                child: Center(
                  child: DropdownButton<String>(
                    value: _chosenValue,
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                    iconEnabledColor:Colors.black,
                    items: <String>[
                      'All',
                      'MAN',
                      'INFO',
                      'LAP',
                      'SOP',
                      'SRK'
                     ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,style: GoogleFonts.plusJakartaSans(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                        setState(() {
                       _chosenValue = value!;
                      });
                    },
                  ),
                ),
              ),
            ],
          )
        ),
        Expanded(
          child: 
          listDataPaging.isEmpty || filteredList.isEmpty
          ?
          Center(child: Text('No Data Available',
            style: GoogleFonts.plusJakartaSans(
              color: baseColor.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w600),
            )
          )
          :
          ListView.builder(
              controller: scrollController,
              itemCount: listDataPaging.length,
              itemBuilder: (builder, index) {
                if (index < filteredList.length) {
                  final item = filteredList[index];
                  return CardReport(response: item);
                } else {
                  return Center(
                    child: isLoaded
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: loading()
                          ),
                  );
                }
              }),
        ),
      ],
    );
  }
  Widget loading() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          color: baseColors.primaryColor,
          height: 65,
          child: SearchInputReport(
            controller: searchController,
              onSelectedCallback: (value) {
                _debounceTimer?.cancel();
                _debounceTimer = Timer(Duration(seconds: 1), () {
                search(value);
              });
            },
          ),
        ),
       Center(child: AppWidget().LoadingWidget())
      ],
    );
  }
}


