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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchMd = TextEditingController();

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
  String? username;
  bool isTab1Selected = true;

  String? _chosenValue = 'All';
  UserData userData = UserData();

  int progressBar = 0;
  final scrollController = ScrollController();
  Timer? _debounceTimer;
  String? apiResponse;

  DateTimeRange? selectedDateRange;
  List<SalesDataStoreResponse> storeData = [];
  String selectedStore = '';

  @override
  void initState() {
    super.initState();
    reportCubit = context.read<ReportCubit>();
    popUpWidget = PopUpWidget(context);
    loginCubit = context.read<LoginCubit>();
    _debounceTimer?.cancel();
    refreshPage();
  }

  List<SalesData> filterByMd(List<SalesData> list, String md) {
    if (md.isEmpty) {
      return list;
    }
    return list
        .where((item) => item.md!.toLowerCase().contains(md.toLowerCase()))
        .toList();
  }

  refreshPage() async {
    toko = await SharedPref.getUserToko();
    token = await SharedPref.getToken();
    username = await SharedPref.getUserId();
    initDataReport();
    scrollListener();
    searchController.clear();
    searchMd.clear();
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
    searchMd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _onBackPressed();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) {
                  return Ramayana();
                }),
                (route) => false,
              );
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color.fromARGB(255, 131, 113, 113),
            ),
          ),
          toolbarHeight: 75,
          centerTitle: true,
          title: Text('Report',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 23, color: Colors.white)),
          backgroundColor: baseColors.primaryColor,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                child: Image.asset(
                  'assets/reportBackground.png',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                ),
              ),
              _buildTabBar(),
              _buildMainContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(color: baseColors.primaryColor),
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              color: isTab1Selected ? Colors.red : Colors.white,
            ),
            child: TextButton(
              onPressed: () {
                setState(() {
                  isTab1Selected = true;
                });
              },
              child: Text(
                'Notification',
                style: TextStyle(
                  color: isTab1Selected ? Colors.white : Colors.red,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          Container(
            width: 120,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red),
              color: isTab1Selected ? Colors.white : Colors.red,
            ),
            child: TextButton(
              onPressed: () {
                setState(() {
                  isTab1Selected = false;
                });
              },
              child: Text(
                'Report Sales',
                style: TextStyle(
                  color: isTab1Selected ? Colors.red : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Padding(
      padding: const EdgeInsets.only(top: 35),
      child: Column(
        children: [
          Container(
            child: Expanded(
              child: isTab1Selected ? _buildTab1Content() : _buildTab2Content(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab1Content() {
    return BlocBuilder<ReportCubit, ReportState>(
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
              bool headerExists = listDataPaging.any((existingElement) =>
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
                  child: AppWidget()
                      .EmptyHandler(baseParam.emptyDataReportMessage));
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
              bool headerExists = listDataPaging.any((existingElement) =>
                  existingElement.header1 == element.header1);
              if (!headerExists) {
                listDataPaging.add(element);
              }
            });
            if (listDataPaging.isNotEmpty) {
              return searchEmpty();
            } else {
              return Center(
                  child: AppWidget()
                      .EmptyHandler(baseParam.emptyDataReportMessage));
            }
          }
        }

        if (state is ReportFailure) {
          return AppWidget()
              .ErrorHandler(baseParam.errorReportMessage, getListReport);
        }

        return searchEmpty();
      },
    );
  }

  Widget _buildTab2Content() {
    String selectedValue = 'Sales Report';
    final screenSize = MediaQuery.of(context).size;
    final response =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>? ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10, top: 1),
          color: baseColors.primaryColor,
          width: 500,
          height: 100,
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300, width: 2),
              ),
              child: DropdownButton<String>(
                value: selectedValue,
                icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                dropdownColor: Colors.white,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue!;
                  });

                  if (newValue == 'Member') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return MemberReport();
                      }),
                    );
                  }
                },
                items: ['Sales Report', 'Member']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(right: 20, left: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      reportCubit.getStore(
                        token ?? '',
                        SalesDataStore(
                          idKorem: username,
                          storeCode: toko,
                        ),
                      );
                    },
                    child: Text("Select Data Store"),
                  ),
                ),
                BlocBuilder<ReportCubit, ReportState>(
                  builder: (context, state) {
                    if (state is ReportInitial) {
                      return loadingSales();
                    }

                    if (state is getStoreSuccess) {
                      final storeData = state.data;
                      if (state is ReportFailure) {
                        SizedBox.shrink();
                      }
                      return Container(
                        padding: EdgeInsets.only(right: 20, left: 20),
                        child: DropdownSearch<String>(
                          popupProps: PopupProps.menu(
                            showSearchBox: true,
                            searchFieldProps: TextFieldProps(
                              decoration: InputDecoration(
                                hintText: "Cari Store...",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          items: storeData
                              .map((store) => store.storeCode ?? "")
                              .toList(),
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: 'Select Store',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 0.5,
                                ),
                              ),
                            ),
                          ),
                          selectedItem:
                              selectedStore.isNotEmpty ? selectedStore : null,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedStore = newValue!;
                            });
                          },
                        ),
                      );
                    }

                    return SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: baseColors.primaryColor,
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
                      ? '${DateFormat('dd-MM-yyyy').format(selectedDateRange!.start)} - ${DateFormat('dd-MM-yyyy').format(selectedDateRange!.end)}'
                      : 'Select Date Range',
                  style: GoogleFonts.plusJakartaSans(color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: baseColors.primaryColor,
                ),
                onPressed: () async {
                  if (selectedDateRange != null) {
                    final reportBody = ReportSalesBody(
                      startDate: DateFormat('yyyy-MM-dd')
                          .format(selectedDateRange!.start),
                      endDate: DateFormat('yyyy-MM-dd')
                          .format(selectedDateRange!.end),
                      storeCode: selectedStore,
                    );
                    reportCubit.getSalesReport(token ?? '', reportBody);
                  } else {
                    popUpWidget
                        .showToastMessage('Please select date range first');
                  }
                },
                child: Text(
                  'Generate Report',
                  style: GoogleFonts.plusJakartaSans(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
        BlocBuilder<ReportCubit, ReportState>(
          builder: (context, state) {
            if (state is ReportInitial) {
              return loadingSales();
            }

            if (state is ReportLoading) {
              if (listDataPaging.isEmpty) {
                return Center(
                  child: Text(
                    "Tidak ada data untuk ditampilkan.",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                );
              } else {
                return loadingSales();
              }
            }

            if (state is ReportFailure) {
              return Center(
                child: Text(
                  "Terjadi kesalahan. Silakan coba lagi.",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              );
            }

            if (state is ReportSalesSuccess) {
              final filteredList = filterByMd(state.response, searchMd.text);

              if (state.response.isEmpty) {
                return Center(
                  child: Text(
                    "Data tidak ditemukan.",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                );
              }
// Mengelompokkan data berdasarkan tanggal
              Map<String, double> groupedData = {};

// Loop untuk menjumlahkan Net per tanggal
              for (var item in filteredList) {
                String dateKey = item.tanggal.toString(); // Ubah sesuai format tanggal
                double netValue = double.tryParse(item.net.toString()) ?? 0;

                if (groupedData.containsKey(dateKey)) {
                  groupedData[dateKey] = groupedData[dateKey]! + netValue;
                } else {
                  groupedData[dateKey] = netValue;
                }
              }

// Konversi ke List agar bisa digunakan di ListView.builder
              List<MapEntry<String, double>> groupedList =
                  groupedData.entries.toList();

              return Expanded(
                child: Column(
                  children: [
                    // SingleChildScrollView(
                    //   keyboardDismissBehavior:
                    //       ScrollViewKeyboardDismissBehavior.onDrag,
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    //     child: TextField(
                    //       controller: searchMd,
                    //       onChanged: (value) {
                    //         setState(() {});
                    //       },
                    //       decoration: InputDecoration(
                    //         labelText: 'Search by MD',
                    //         prefixIcon: Icon(Icons.search),
                    //         border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(10),
                    //           borderSide: BorderSide(color: Colors.grey),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          final item = filteredList[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(item: item),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                              decoration: BoxDecoration(
                                color: baseColor.cardReportColor,
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(2, 3),
                                    color: Colors.grey,
                                    blurRadius: 3,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: screenSize.height / 10,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: baseColor.cardImageBackground,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Image(
                                        width: 40,
                                        height: 40,
                                        image:
                                            AssetImage(baseAsset.icReportList),
                                      ),
                                    ),
                                    Container(
                                      width: screenSize.width / 1.3,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        formatTanggal(
                                                            item.tanggal),
                                                        style: GoogleFonts
                                                            .plusJakartaSans(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w200,
                                                          color: baseColor
                                                              .graySecondary,
                                                        ),
                                                        overflow: TextOverflow
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
                                                          FontWeight.w900,
                                                      color:
                                                          baseColor.grayPrimary,
                                                      wordSpacing: 2,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Image(
                                                    width: 40,
                                                    height: 40,
                                                    image: AssetImage(baseAsset
                                                        .icReportArrow),
                                                  ),
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
                    ),
                  ],
                ),
              );
            }

            return Container();
          },
        ),
      ],
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

  String formatTanggal(String? tanggal) {
    if (tanggal == null || tanggal.isEmpty) return "-";
    try {
      DateTime date = DateTime.parse(tanggal);
      return DateFormat('dd-MM-yyyy', "id_ID").format(date);
    } catch (e) {
      print("object $e");
      return "-";
    }
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

  Widget loadingSales() {
    return Column(
      children: [Center(child: AppWidget().LoadingWidget())],
    );
  }

  void _onBackPressed() {
    Navigator.of(context).pop();
  }
}
