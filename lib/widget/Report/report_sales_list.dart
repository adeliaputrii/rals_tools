part of 'import.dart';

class ReportSalesList extends StatefulWidget {
  const ReportSalesList({super.key});
  @override
  State<ReportSalesList> createState() => _ReportSalesListState();
}

class _ReportSalesListState extends State<ReportSalesList> {
  TransformationController controller = TransformationController();
  TextEditingController searchController = TextEditingController();
  bool isLoading = true;
  int progressBar = 0;
  String urlDetail = 'https://www.youtube.com/';
  bool isSearch = false;
  late ReportCubit reportCubit;
  List<ReportListResponse> listReport = [];
  List<ReportListResponse> listReportSearch = [];
  List<PagingResponse.Data> listDataSearch = [];
  List<PagingResponse.Data> listDataPaging = [];
  String searchQuery = '';
  String title = "";
  String? nextUrlCursor;
  bool isLoaded = false;
  final scrollController = ScrollController();
  late PopUpWidget popUpWidget;
  Timer? _debounceTimer;

  @override
  void initState() {
    reportCubit = context.read<ReportCubit>();
    popUpWidget = PopUpWidget(context);
    _debounceTimer?.cancel();
    initDataReport();
    scrollListener();

    super.initState();
  }

  void initDataReport() {
    reportCubit.getListReportPagination("", "", "", "");
  }

  void scrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        debugPrint('on bottom scroll');
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
    // KeyboardUtils().dissmissKeyboard(context);
    getListReport();
  }

  void getListReport() {
    if (isLoaded) {
      return;
    }
    if (nextUrlCursor != null) {
      reportCubit.getListReportPagination(nextUrlCursor, title, "", "");
    } else {
      popUpWidget.showToastMessage('Tidak ada data lagi..');
      setState(() {
        isLoaded = true;
      });
    }
  }

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
                onPressed: () async {
                  _onBackPressed();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              backgroundColor: baseColor.primaryColor,
              title: isSearch
                  ? SearchInputReport(
                      controller: searchController,
                      onSelectedCallback: (value) {
                        _debounceTimer?.cancel();

                        _debounceTimer = Timer(Duration(seconds: 1), () {
                          search(value);
                        });
                      },
                    )
                  : Text(
                      'Laporan',
                      style: TextStyle(color: Colors.white),
                    ),
              centerTitle: true,
              actions: [
                IconButton(
                    icon: !isSearch
                        ? Icon(
                            Icons.search,
                            color: Colors.white,
                          )
                        : Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                    onPressed: () {
                      setState(() {
                        isSearch = !isSearch;
                      });
                      if (!isSearch) {
                        isLoaded = false;
                        reportCubit.getListReportPagination("", "", "", "");
                        setState(() {
                          title = "";
                          nextUrlCursor = null;
                          listDataPaging.clear();
                          searchController.clear();
                          listReportSearch.clear();
                        });
                      }
                    })
              ],
            ),
            body: BlocBuilder<ReportCubit, ReportState>(builder: (context, state) {
              if (state is ReportInitial) {
                return Center(child: AppWidget().LoadingWidget());
              }

              if (state is ReportLoading) {
                if (listDataPaging.isEmpty) {
                  return Center(child: AppWidget().LoadingWidget());
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: searchEmpty(),
                  );
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
                  debugPrint('here?');

                  state.response.data?.forEach((element) {
                    bool headerExists = listDataPaging.any((existingElement) => existingElement.header1 == element.header1);
                    if (!headerExists) {
                      listDataPaging.add(element);
                    }
                    // listDataPaging.add(element);
                  });
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: searchEmpty(),
                  );
                } else {
                  return Center(child: AppWidget().EmptyHandler(baseParam.emptyDataReportMessage));
                }
              }
              if (state is ReportFailure) {
                return AppWidget().ErrorHandler(baseParam.errorReportMessage, getListReport);
              }
              return AppWidget().ErrorHandler(baseParam.errorReportMessage, getListReport);
            })));
  }

  Widget searchResult() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: listDataSearch.length,
        itemBuilder: (context, index) {
          return CardReport(response: listDataSearch[index]);
        });
  }

  Widget searchEmpty() {
    return ListView.builder(
        controller: scrollController,
        itemCount: listDataPaging.length + 1,
        itemBuilder: (builder, index) {
          if (index < listDataPaging.length) {
            final item = listDataPaging[index];
            return CardReport(response: item);
          } else {
            return Center(
              child: isLoaded
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: AppWidget().LoadingWidget(),
                    ),
            );
          }
        });
  }
}

class SearchInputReport extends StatelessWidget {
  TextEditingController controller;
  final void Function(String) onSelectedCallback;
  SearchInputReport({super.key, required this.controller, required this.onSelectedCallback});

  List<String> titleReport = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 0),
      height: MediaQuery.of(context).size.height / 25,
      child: TextField(
        readOnly: false,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(255, 236, 236, 236),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromARGB(255, 236, 236, 236),
            ), //<-- SEE HERE
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromARGB(255, 236, 236, 236),
            ), //<-- SEE HERE
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        onChanged: (text) {
          onSelectedCallback(text);
        },
      ),
    );
  }
}
