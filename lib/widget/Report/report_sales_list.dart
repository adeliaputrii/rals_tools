part of 'import.dart';

class ReportSalesList extends StatefulWidget {
  const ReportSalesList({super.key});
  @override
  State<ReportSalesList> createState() => _ReportSalesListState();
}

class _ReportSalesListState extends State<ReportSalesList>
    with AutomaticKeepAliveClientMixin {
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
  String? toko;

  String? _chosenValue = 'All';
  UserData userData = UserData();

  int progressBar = 0;
  final scrollController = ScrollController();
  Timer? _debounceTimer;
  String selectedStore = 'S135';
  DateTimeRange? selectedDateRange;
  @override
  void initState() {
    reportCubit = context.read<ReportCubit>();
    popUpWidget = PopUpWidget(context);
    loginCubit = context.read<LoginCubit>(); // Initialize loginCubit here
    _debounceTimer?.cancel();
    refreshPage();
    super.initState();
  }

  refreshPage() async {
    toko = await SharedPref.getUserToko();
    token = await SharedPref.getToken();
    initDataReport();
    scrollListener();
    searchController.clear();
  }

  void initDataReport() {
    reportCubit.getListReportPagination(token ?? '', "", "", "", "");
    loginCubit.createLog(
        baseParam.logInfoReportPage,
        baseParam.logInfoNavigateReportPage,
        basePath.api_report_list_pagination);
  }

  void scrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
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
      reportCubit.getListReportPagination(
          token ?? '', nextUrlCursor, title, "", "");
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
      child: DefaultTabController(
        length: 2,
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
            bottom: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
              tabs: [
                Tab(text: 'Tab 1'),
                Tab(text: 'Tab 2'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // Existing content for Tab 1
              Stack(
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
                  BlocBuilder<ReportCubit, ReportState>(
                      builder: (context, state) {
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
                          bool headerExists = listDataPaging.any(
                              (existingElement) =>
                                  existingElement.header1 == element.header1);
                          if (!headerExists) {
                            listDataPaging.add(element);
                          }
                        });
                        if (listDataPaging.isNotEmpty) {
                          debugPrint('data length ${listDataPaging.length}');
                          return searchEmpty();
                        } else {
                          return Center(
                              child: AppWidget().EmptyHandler(
                                  baseParam.emptyDataReportMessage));
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
                          bool headerExists = listDataPaging.any(
                              (existingElement) =>
                                  existingElement.header1 == element.header1);
                          if (!headerExists) {
                            listDataPaging.add(element);
                          }
                        });
                        if (listDataPaging.isNotEmpty) {
                          return searchEmpty();
                        } else {
                          return Center(
                              child: AppWidget().EmptyHandler(
                                  baseParam.emptyDataReportMessage));
                        }
                      }
                    }
                    if (state is ReportFailure) {
                      return AppWidget().ErrorHandler(
                          baseParam.errorReportMessage, getListReport);
                    }
                    return searchEmpty();
                  }),
                ],
              ),
              // Content for Tab 2
              Stack(
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
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          child: Text(
                            "Sales Report",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize:
                                  28, 
                              fontWeight: FontWeight.bold,
                              color: baseColors
                                  .primaryColor, 
                              shadows: [
                                Shadow(
                                  offset: Offset(
                                      2.0, 2.0), 
                                  blurRadius: 3.0,
                                  color: Colors.black26,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: baseColors.primaryColor,
                            minimumSize: Size(double.infinity, 50),
                          ),
                          onPressed: () async {
                            final pickedRange = await showDateRangePicker(
                              context: context,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: baseColors.primaryColor,
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );

                            if (pickedRange != null) {
                              setState(() {
                                selectedDateRange = pickedRange;
                              });
                            }
                          },
                          child: Text(
                            selectedDateRange != null
                                ? '${DateFormat('yyyy-MM-dd').format(selectedDateRange!.start)} - ${DateFormat('yyyy-MM-dd').format(selectedDateRange!.end)}'
                                : 'Select Date Range',
                            style: GoogleFonts.plusJakartaSans( color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 24),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: baseColors.primaryColor,
                            minimumSize: Size(double.infinity, 50),
                          ),
                          onPressed: () async {
                            if (selectedDateRange != null) {
                              final reportBody = ReportSalesBody(
                                startDate: DateFormat('yyyy-MM-dd')
                                    .format(selectedDateRange!.start),
                                endDate: DateFormat('yyyy-MM-dd')
                                    .format(selectedDateRange!.end),
                                storeCode: userData.getUserToko(),
                              );
                              reportCubit.getSalesReport(token ?? '', reportBody);
                          
                            } else {
                              popUpWidget.showToastMessage(
                                  'Please select date range first');
                            }
                          },
                          child: Text(
                            'Generate Report',
                            style: GoogleFonts.plusJakartaSans(
                                color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 24),
                       BlocBuilder<ReportCubit, ReportState>(
                          builder: (context, state) {
                            if (state is ReportLoading) {
                              return Center(child: AppWidget().LoadingWidget());
                            }

                            if (state is ReportSalesSuccess) {
                              if (state.data.isEmpty) {
                                return Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom:
                                                50.0), 
                                        child: Container(
                                          
                                          child: Text(
                                            'No data available',
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: baseColors.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }

                              return Expanded(
                                child: ListView.builder(
                                  itemCount: state.data.length,
                                  itemBuilder: (context, index) {
                                    final item = state.data[index];
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailPage(item: item),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(20, 0, 20, 10),
                                        decoration: BoxDecoration(
                                          color: baseColor.cardReportColor,
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(2, 3),
                                              color: Colors.grey,
                                              blurRadius: 3,
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        height: screenSize.height / 10,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: baseColor
                                                      .cardImageBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Image(
                                                  width: 40,
                                                  height: 40,
                                                  image: AssetImage(
                                                      baseAsset.icReportList),
                                                ),
                                              ),
                                              Container(
                                                width: screenSize.width / 1.5,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  'Toko: ${item.toko}',
                                                                  style: GoogleFonts
                                                                      .plusJakartaSans(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: baseColor
                                                                        .graySecondary,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'MD: ${item.md}',
                                                                  style: GoogleFonts
                                                                      .plusJakartaSans(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: baseColor
                                                                        .graySecondary,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  item.tanggal ??
                                                                      "",
                                                                  style: GoogleFonts
                                                                      .plusJakartaSans(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w200,
                                                                    color: baseColor
                                                                        .graySecondary,
                                                                  ),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ],
                                                            ),
                                                            Text(
                                                              'Net: ${item.net}',
                                                              style: GoogleFonts
                                                                  .plusJakartaSans(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                color: baseColor
                                                                    .grayPrimary,
                                                                wordSpacing: 2,
                                                              ),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Image(
                                                            width: 40,
                                                            height: 40,
                                                            image: AssetImage(
                                                                baseAsset
                                                                    .icReportArrow),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }

                            if (state is ReportFailure) {
                              return Center(
                                child: Text(
                                  state.message.toString(),
                                  style: GoogleFonts.plusJakartaSans(
                                      color: Colors.red),
                                ),
                              );
                            }

                            return Container();
                          },
                        )


                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget searchEmpty() {
    final filteredList = _chosenValue != 'All'
        ? listDataPaging
            .where((item) => item.category!.contains(_chosenValue!))
            .toList()
        : listDataPaging;
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(bottom: 40, top: 1),
            color: baseColors.primaryColor,
            width: 500,
            height: 100,
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
                Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                  ),
                  child: Container(
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.only(right: 20, bottom: 40),
                    child: Center(
                      child: DropdownButton<String>(
                        value: _chosenValue,
                        style: GoogleFonts.plusJakartaSans(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        iconEnabledColor: Colors.black,
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
                            child: Text(
                              value,
                              style: GoogleFonts.plusJakartaSans(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
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
                ),
              ],
            )),
        Expanded(
          child: listDataPaging.isEmpty || filteredList.isEmpty
              ? Center(
                  child: Text(
                  'No Data Available',
                  style: GoogleFonts.plusJakartaSans(
                      color: baseColor.primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ))
              : ListView.builder(
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: loading()),
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
