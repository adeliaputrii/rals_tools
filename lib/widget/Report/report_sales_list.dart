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
  final NumberFormat formatter = NumberFormat("#,###", "id_ID");

  String searchQuery = '';
  String title = "";
  String? nextUrlCursor;
  String urlDetail = 'https://www.youtube.com/';
  String? token;
  String? toko;
  String? username;
  String? role;
  bool isTab1Selected = true;
  var selectStore = false;
  String? _chosenValue = 'All';
  UserData userData = UserData();
  String? inputReportId = "";
  String? selectedReportId; // Menyimpan ID report yang dipilih
  List<ReportDynamic> reportList = []; // List laporan untuk dropdown
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
    cekSemuaSharedPreferences();
  }

  void cekSemuaSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Set<String> keys = prefs.getKeys();
    log("Semua data SharedPreferences:");

    for (String key in keys) {
      log("$key: ${prefs.get(key)}");
    }
  }

  refreshPage() async {
    toko = await SharedPref.getUserToko();
    token = await SharedPref.getToken();
    username = await SharedPref.getUserId();
    role = await SharedPref.getRoleNew();
    initDataReport();
    scrollListener();
    initReportDyanmic();
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

  void initSalesReport() {
    reportCubit.getStore(
      token ?? '',
      SalesDataStore(
        idKorem: username,
        storeCode: toko,
      ),
    );
  }

  void initReportDyanmic() {
    log("CEK TOKO ${toko.toString()}");
    log("CEK ROLE ${role.toString()}");

    reportCubit.getReportdynamicHeader(
      token ?? '',
    );
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

  // Future<void> generatePdf(List<ReportData> valueReport) async {
  //   final pdf = pw.Document();

  //   try {
  //     // Load custom font
  //     final ByteData data = await rootBundle.load("assets/fonts/Noto_Sans.ttf");
  //     final pw.Font font = pw.Font.ttf(data);
  //     pdf.addPage(
  //       pw.Page(
  //         pageFormat: PdfPageFormat.a4,
  //         build: (pw.Context context) {
  //           return pw.Column(
  //             crossAxisAlignment: pw.CrossAxisAlignment.start,
  //             children: [
  //               pw.Text(
  //                 "Laporan Data",
  //                 style: pw.TextStyle(font: font, fontSize: 20),
  //               ),
  //               pw.SizedBox(height: 10),
  //               valueReport.isNotEmpty
  //                   ? pw.Table.fromTextArray(
  //                       headers: [
  //                         "ID",
  //                         "Periode",
  //                         "Line",
  //                         "C1",
  //                         "C2",
  //                         "C3",
  //                         "C4",
  //                         "C5"
  //                       ],
  //                       data: valueReport
  //                           .map((data) => [
  //                                 data.reportId ?? "-",
  //                                 data.periode ?? "-",
  //                                 data.line ?? "-",
  //                                 data.c1 ?? "-",
  //                                 data.c2 ?? "-",
  //                                 data.c3 ?? "-",
  //                                 data.c4 ?? "-",
  //                                 data.c5 ?? "-",
  //                               ])
  //                           .toList(),
  //                       border: pw.TableBorder.all(width: 1),
  //                       cellAlignment: pw.Alignment.centerLeft,
  //                       headerStyle: pw.TextStyle(font: font, fontSize: 14),
  //                       cellStyle: pw.TextStyle(font: font, fontSize: 12),
  //                     )
  //                   : pw.Text("Tidak ada data.",
  //                       style: pw.TextStyle(font: font, fontSize: 14)),
  //             ],
  //           );
  //         },
  //       ),
  //     );

  //     // Simpan file PDF ke storage sementara
  //     final output = await getTemporaryDirectory();
  //     final file = File("${output.path}/laporan.pdf");
  //     await file.writeAsBytes(await pdf.save());
  //     // Buka file PDF setelah dibuat
  //     OpenFile.open(file.path);
  //   } catch (e) {
  //     print("Error saat membuat PDF: $e");
  //   }
  // }

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
                'Info',
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
              onPressed: () async {
                final listAccess = await SharedPref.getUserAccess() ?? '';
                if (listAccess.contains(baseParam.reportCek)) {
                  setState(() {
                    initReportDyanmic();
                    isTab1Selected = false;
                  });
                } else {
                  showRestrictMessenger(context);
                }
              },
              child: Text(
                'Report ',
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(right: 30, left: 30, top: 20),
          child: DropdownButtonFormField<String>(
            value:
                reportList.any((report) => report.reportId == selectedReportId)
                    ? selectedReportId
                    : null,
            decoration: InputDecoration(
              labelText: "Selected Report",
              border: OutlineInputBorder(),
            ),
            items: reportList
                .fold<Map<String, ReportDynamic>>({}, (map, report) {
                  map[report.namaReport] = report;
                  return map;
                })
                .values
                .map((report) => DropdownMenuItem(
                      value: report.reportId,
                      child: Text(report.namaReport),
                    ))
                .toList(),
            onChanged: (newValue) {
              setState(() {
                selectedReportId = newValue;
              });

              if (token != null) {
                reportCubit.getReportdynamic(token!, selectedReportId!);
                log("Mengambil data report dengan ID: $selectedReportId");
              }
            },
          ),
        ),
        BlocListener<ReportCubit, ReportState>(
          listener: (context, state) {
            if (state is ReportgetDynamicHeaderSuccess) {
              log("sukses menerima data dari state");

              if (mounted) {
                setState(() {
                  reportList = state.response;
                  log("Report list setelah filter: ${reportList.length} items");
                });
              }
            }
          },
          child: BlocBuilder<ReportCubit, ReportState>(
            builder: (context, state) {
              if (state is ReportInitial || state is ReportLoading) {
                return SizedBox.shrink();
              } else if (state is ReportFailure) {
                return Center(
                  child: Text(
                    "Error: ${state.message}",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                );
              } else if (state is ReportgetDynamicHeaderSuccess &&
                  reportList.isEmpty) {
                return Center(child: Text("Data tidak ditemukan"));
              }
              return SizedBox.shrink();
            },
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: BlocBuilder<ReportCubit, ReportState>(
            builder: (context, state) {
              if (state is ReportInitial || state is ReportLoading) {
                return loadingSales();
              } else if (state is ReportFailure) {
                return Center(
                  child: Text(
                    "Error: ${state.message}",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                );
              } else if (state is ReportgetDynamicSuccess) {
                final reportResponse = state.response;
                final List<ReportData> valueReport = reportResponse;
                final String reportTitle = reportResponse.isNotEmpty
                    ? reportResponse.first.namaReport
                    : "Laporan Tidak Tersedia";

                if (valueReport.isEmpty) {
                  print(
                      "valueReport kosong, tidak ada data untuk ditampilkan.");
                } else {
                  print(
                      "valueReport memiliki data, jumlah: ${valueReport.length}");
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20, left: 10),
                          child: Text(
                            reportTitle,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, right: 10),
                          child: ElevatedButton.icon(
                              icon: Icon(Icons.picture_as_pdf,
                                  color: Colors.white),
                              label: Text(
                                "Download PDF",
                                style: TextStyle(color: Colors.yellow),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: baseColor.primaryColor,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                              ),
                              onPressed: () {
                                log(" pdf");
                                if (selectedReportId != null) {
                                  reportCubit.fetchAndSavePdf(
                                      selectedReportId!, token.toString());
                                       ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Tunggu Sebentar")),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Pilih report terlebih dahulu")),
                                  );
                                }
                              } // Fungsi untuk generate PDF

                              ),
                        ),
                      ],
                    ),
                    const Divider(thickness: 2),
                    Expanded(
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: SingleChildScrollView(
                          child: FittedBox(
                            alignment: Alignment.topLeft,
                            child: DataTable(
                              columnSpacing: 10,
                              border: TableBorder.all(
                                  width: 1.5, color: Colors.grey),
                              headingRowHeight: 35,
                              dataRowMinHeight: 30,
                              columns: _buildColumns(valueReport),
                              rows: valueReport
                                  .where((data) => data.line != "1")
                                  .map((data) => _buildRow(data))
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ],
    );

    // Container(
    //   margin: EdgeInsets.only(bottom: 10, top: 1),
    //   color: baseColors.primaryColor,
    //   width: 500,
    //   height: 100,
    //   child: Center(
    //     child: Container(
    //       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    //       decoration: BoxDecoration(
    //         color: Colors.white,
    //         borderRadius: BorderRadius.circular(12),
    //         border: Border.all(color: Colors.grey.shade300, width: 2),
    //       ),
    //       child: DropdownButton<String>(
    //         value: selectedValue,
    //         icon: Icon(Icons.arrow_drop_down, color: Colors.black),
    //         dropdownColor: Colors.white,
    //         style: GoogleFonts.plusJakartaSans(
    //           fontSize: 15,
    //           fontWeight: FontWeight.bold,
    //           color: Colors.black,
    //         ),
    //         onChanged: (String? newValue) {
    //           setState(() {
    //             selectedValue = newValue!;
    //           });

    //           if (newValue == 'Report Dynamic') {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(builder: (context) {
    //                 return MemberReport();
    //               }),
    //             );
    //           }
    //         },
    //         items: ['Select Report', 'Report Dynamic']
    //             .map<DropdownMenuItem<String>>((String value) {
    //           return DropdownMenuItem<String>(
    //             value: value,
    //             child: Text(value),
    //           );
    //         }).toList(),
    //       ),
    //     ),
    //   ),
    // ),
    // Padding(
    //   padding: const EdgeInsets.all(10),
    //   child: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [

    //         BlocBuilder<ReportCubit, ReportState>(
    //           builder: (context, state) {
    //             if (state is ReportInitial) {
    //               return loadingSales();
    //             }

    //             if (state is getStoreSuccess) {
    //               final storeData = state.data;

    //               return Container(
    //                 padding: EdgeInsets.only(right: 40, left: 40),
    //                 child: DropdownSearch<String>(
    //                   popupProps: PopupProps.menu(
    //                     showSearchBox: true,
    //                     searchFieldProps: TextFieldProps(
    //                       decoration: InputDecoration(
    //                         hintText: "Cari Store...",
    //                         border: OutlineInputBorder(),
    //                       ),
    //                     ),
    //                   ),
    //                   items: storeData
    //                       .map((store) => store.storeCode ?? "")
    //                       .toList(),
    //                   dropdownDecoratorProps: DropDownDecoratorProps(
    //                     dropdownSearchDecoration: InputDecoration(
    //                       labelText: 'Select Store',
    //                       border: OutlineInputBorder(
    //                         borderRadius: BorderRadius.circular(10.0),
    //                         borderSide: BorderSide(
    //                           color: Colors.grey,
    //                           width: 0.5,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   selectedItem:
    //                       selectedStore.isNotEmpty ? selectedStore : toko,
    //                   onChanged: (String? newValue) {
    //                     setState(() {
    //                       selectedStore = newValue!;
    //                     });
    //                   },
    //                 ),
    //               );
    //             }

    //             return SizedBox.shrink();
    //           },
    //         ),
    //       ],
    //     ),
    //   ),
    // ),
    // SizedBox(height: 10),
    // Center(
    //   child: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       ElevatedButton(
    //         style: ElevatedButton.styleFrom(
    //           backgroundColor: baseColors.primaryColor,
    //         ),
    //         onPressed: () async {
    //           final pickedRange = await showDateRangePicker(
    //             context: context,
    //             firstDate: DateTime(2000),
    //             lastDate: DateTime(2100),
    //             builder: (context, child) {
    //               return Theme(
    //                 data: Theme.of(context).copyWith(
    //                   colorScheme: ColorScheme.light(
    //                     primary: baseColors.primaryColor,
    //                   ),
    //                 ),
    //                 child: child!,
    //               );
    //             },
    //           );

    //           if (pickedRange != null) {
    //             setState(() {
    //               selectedDateRange = pickedRange;
    //             });
    //           }
    //         },
    //         child: Text(
    //           selectedDateRange != null
    //               ? '${DateFormat('dd-MM-yyyy').format(selectedDateRange!.start)} - ${DateFormat('dd-MM-yyyy').format(selectedDateRange!.end)}'
    //               : 'Select Date Range',
    //           style: GoogleFonts.plusJakartaSans(color: Colors.white),
    //         ),
    //       ),
    //       SizedBox(height: 10),
    //       ElevatedButton(
    //         style: ElevatedButton.styleFrom(
    //           backgroundColor: baseColors.primaryColor,
    //         ),
    //         onPressed: () async {

    //           if (selectedDateRange != null) {
    //             final reportBody = ReportSalesBody(
    //               startDate: DateFormat('yyyy-MM-dd')
    //                   .format(selectedDateRange!.start),
    //               endDate: DateFormat('yyyy-MM-dd')
    //                   .format(selectedDateRange!.end),
    //               storeCode: selectedStore.isEmpty
    //                   ? toko.toString()
    //                   : selectedStore,
    //             );
    //             reportCubit.getSalesReport(token ?? '', reportBody);
    //           } else {
    //             popUpWidget
    //                 .showToastMessage('Please select date range first');
    //           }
    //         },
    //         child: Text(
    //           'Generate Report',
    //           style: GoogleFonts.plusJakartaSans(color: Colors.white),
    //         ),
    //       ),
    //     ],
    //   ),
    // ),
    // SizedBox(height: 24),
    // BlocBuilder<ReportCubit, ReportState>(
    //   builder: (context, state) {
    //     if (state is ReportInitial) {
    //       return loadingSales();
    //     }

    //     if (state is ReportLoading) {
    //       if (listDataPaging.isEmpty) {
    //         return Center(
    //           child: Text(
    //             "Tidak ada data untuk ditampilkan.",
    //             style: GoogleFonts.plusJakartaSans(
    //               fontSize: 16,
    //               fontWeight: FontWeight.bold,
    //               color: Colors.grey,
    //             ),
    //           ),
    //         );
    //       } else {
    //         return loadingSales();
    //       }
    //     }

    //     if (state is ReportSalesSuccess) {
    //       final filteredList = state.response;
    //       if (filteredList.isEmpty) {
    //         return Center(
    //           child: Text(
    //             "Data tidak ditemukan.",
    //             style: GoogleFonts.plusJakartaSans(
    //               fontSize: 16,
    //               fontWeight: FontWeight.bold,
    //               color: Colors.grey,
    //             ),
    //           ),
    //         );
    //       }
    //       Map<String, Map<String, double>> groupedData = {};

    //       for (var item in filteredList) {
    //         String dateKey = item.tanggal.toString();

    //         double netValue =
    //             double.tryParse(item.net?.toString() ?? "0.0") ?? 0.0;
    //         double grossValue =
    //             double.tryParse(item.gross?.toString() ?? "0.0") ?? 0.0;
    //         double qtyValue =
    //             double.tryParse(item.qty?.toString() ?? "0.0") ?? 0.0;
    //         double targetValue =
    //             double.tryParse(item.target?.toString() ?? "0.0") ?? 0.0;
    //         double discountValue =
    //             double.tryParse(item.discount?.toString() ?? "0.0") ?? 0.0;

    //         groupedData.putIfAbsent(
    //             dateKey,
    //             () => {
    //                   "net": 0.0,
    //                   "gross": 0.0,
    //                   "qty": 0.0,
    //                   "target": 0.0,
    //                   "discount": 0.0,
    //                 });

    //         groupedData[dateKey]!["net"] =
    //             groupedData[dateKey]!["net"]! + netValue;
    //         groupedData[dateKey]!["gross"] =
    //             groupedData[dateKey]!["gross"]! + grossValue;
    //         groupedData[dateKey]!["qty"] =
    //             groupedData[dateKey]!["qty"]! + qtyValue;
    //         groupedData[dateKey]!["target"] =
    //             groupedData[dateKey]!["target"]! + targetValue;
    //         groupedData[dateKey]!["discount"] =
    //             groupedData[dateKey]!["discount"]! + discountValue;
    //       }

    //       double calculateTotal(List<SalesData> list, String key) {
    //         return list.fold(0.0, (sum, item) {
    //           switch (key) {
    //             case "net":
    //               return sum +
    //                   (double.tryParse(item.net?.toString() ?? "0.0") ??
    //                       0.0);
    //             case "gross":
    //               return sum +
    //                   (double.tryParse(item.gross?.toString() ?? "0.0") ??
    //                       0.0);
    //             case "qty":
    //               return sum +
    //                   (double.tryParse(item.qty?.toString() ?? "0.0") ??
    //                       0.0);
    //             case "target":
    //               return sum +
    //                   (double.tryParse(item.target?.toString() ?? "0.0") ??
    //                       0.0);
    //             case "discount":
    //               return sum +
    //                   (double.tryParse(
    //                           item.discount?.toString() ?? "0.0") ??
    //                       0.0);
    //             default:
    //               return sum;
    //           }
    //         });
    //       }

    //       double totalNet = calculateTotal(filteredList, "net");
    //       double totalGross = calculateTotal(filteredList, "gross");
    //       double totalQty = calculateTotal(filteredList, "qty");
    //       double totalTarget = calculateTotal(filteredList, "target");
    //       double totalDiscount = calculateTotal(filteredList, "discount");

    //       final item = filteredList.isNotEmpty ? filteredList[0] : null;

    //       return Expanded(
    //         child: Column(
    //           children: [
    //             Expanded(
    //               child: SingleChildScrollView(
    //                 child: Column(
    //                   children: [
    //                     InkWell(
    //                       onTap: () {
    //                         Navigator.push(
    //                           context,
    //                           MaterialPageRoute(
    //                             builder: (context) => DetailPage(
    //                               item: item!,
    //                               totalGross: totalGross,
    //                               totalNet: totalNet,
    //                               totalDiscount: totalDiscount,
    //                               totalQty: totalQty,
    //                               totalTarget: totalTarget,
    //                               selectedDateRange: selectedDateRange!,
    //                             ),
    //                           ),
    //                         );
    //                       },
    //                       child: Container(
    //                         margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
    //                         decoration: BoxDecoration(
    //                           color: baseColor.cardReportColor,
    //                           boxShadow: [
    //                             BoxShadow(
    //                               offset: Offset(2, 3),
    //                               color: Colors.grey,
    //                               blurRadius: 3,
    //                             ),
    //                           ],
    //                           borderRadius: BorderRadius.circular(20),
    //                         ),
    //                         height: MediaQuery.of(context).size.height / 10,
    //                         child: Padding(
    //                           padding: const EdgeInsets.all(8.0),
    //                           child: Row(
    //                             children: [
    //                               Container(
    //                                 decoration: BoxDecoration(
    //                                   color: baseColor.cardImageBackground,
    //                                   borderRadius:
    //                                       BorderRadius.circular(10),
    //                                 ),
    //                                 child: Image(
    //                                   width: 40,
    //                                   height: 40,
    //                                   image: AssetImage(
    //                                       baseAsset.icReportList),
    //                                 ),
    //                               ),
    //                               SizedBox(width: 10),
    //                               Expanded(
    //                                 child: Column(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.spaceEvenly,
    //                                   crossAxisAlignment:
    //                                       CrossAxisAlignment.start,
    //                                   children: [
    //                                     Row(
    //                                       children: [
    //                                         Text(
    //                                           'Gross : ${formatAmount(totalGross)}',
    //                                           style: GoogleFonts
    //                                               .plusJakartaSans(
    //                                             fontSize: 15,
    //                                             fontWeight: FontWeight.w900,
    //                                             color:
    //                                                 baseColor.grayPrimary,
    //                                             wordSpacing: 2,
    //                                           ),
    //                                           maxLines: 1,
    //                                           overflow:
    //                                               TextOverflow.ellipsis,
    //                                         ),

    //                                         // Padding(
    //                                         //   padding: const EdgeInsets.only(left: 50),
    //                                         //   child: Text(
    //                                         //     selectedDateRange != null
    //                                         //         ? '${DateFormat('dd-MM-yyyy').format(selectedDateRange!.start)} - ${DateFormat('dd-MM-yyyy').format(selectedDateRange!.end)}'
    //                                         //         : 'Pilih Tanggal',
    //                                         //     style: GoogleFonts
    //                                         //         .plusJakartaSans(
    //                                         //       fontSize: 7,
    //                                         //       fontWeight: FontWeight.w600,

    //                                         //     ),
    //                                         //     maxLines: 1,
    //                                         //     overflow:
    //                                         //         TextOverflow.ellipsis,
    //                                         //   ),
    //                                         // ),
    //                                       ],
    //                                     ),
    //                                     Padding(
    //                                       padding: const EdgeInsets.only(
    //                                           left: 5),
    //                                       child: Text(
    //                                         'Net     :  ${formatAmount(totalNet)}',
    //                                         style:
    //                                             GoogleFonts.plusJakartaSans(
    //                                           fontSize: 15,
    //                                           fontWeight: FontWeight.w900,
    //                                           color: baseColor.grayPrimary,
    //                                           wordSpacing: 2,
    //                                         ),
    //                                         maxLines: 1,
    //                                         overflow: TextOverflow.ellipsis,
    //                                       ),
    //                                     ),
    //                                   ],
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       );
    //     }

    //     return Container();
    //   },
    // ),
  }

  List<DataColumn> _buildColumns(List<ReportData> reports) {
    if (reports.isEmpty) return [];

    var firstData = reports.first;
    int jumlahKolom = int.tryParse(firstData.jumlahKolom) ?? 0;

    List<DataColumn> columns = [
      DataColumn(label: Text("ID", style: _headerStyle())),
      DataColumn(label: Text("Periode", style: _headerStyle())),
      DataColumn(label: Text("Line", style: _headerStyle())),
    ];

    for (int i = 1; i <= jumlahKolom; i++) {
      String? columnName = firstData.toJson()["c$i"];
      columns.add(DataColumn(
        label: Text(columnName ?? "-", style: _headerStyle()),
      ));
    }

    return columns;
  }

  DataRow _buildRow(ReportData data) {
    int jumlahKolom = int.tryParse(data.jumlahKolom) ?? 0;
    log("Jumlah Kolom: $jumlahKolom");

    // Cek apakah ada kata "TOTAL" di salah satu kolom (c1, c2, ..., cn)
    bool isTotalRow = false;
    Map<String, dynamic> jsonData = data.toJson();

    for (int i = 1; i <= jumlahKolom; i++) {
      String columnKey = "c$i";
      String? columnValue = jsonData[columnKey] as String?;
      if (columnValue != null && columnValue.contains("TOTAL")) {
        isTotalRow = true;
        break;
      }
    }

    return DataRow(
      cells: [
        DataCell(Text(data.reportId ?? "-",
            style: TextStyle(
                fontSize: 12,
                fontWeight: isTotalRow ? FontWeight.bold : FontWeight.normal))),
        DataCell(Text(data.periode ?? "-",
            style: TextStyle(
                fontSize: 12,
                fontWeight: isTotalRow ? FontWeight.bold : FontWeight.normal))),
        DataCell(Text(data.line ?? "-",
            style: TextStyle(
                fontSize: 12,
                fontWeight: isTotalRow ? FontWeight.bold : FontWeight.normal))),

        // Kolom C1
        DataCell(
          Text(
            data.c1 ?? "",
            style: TextStyle(
              fontSize: 12,
              fontWeight: isTotalRow ? FontWeight.bold : FontWeight.normal,
              backgroundColor: isTotalRow
                  ? Colors.blueAccent.withOpacity(0.3)
                  : Colors.transparent,
            ),
          ),
        ),

        // Kolom C2 hingga Cn
        ...List.generate(jumlahKolom - 1, (index) {
          String columnKey = "c${index + 2}";
          String? columnValue = jsonData.containsKey(columnKey)
              ? jsonData[columnKey] as String?
              : null;

          return DataCell(
            Text(
              formatNumber(columnValue),
              style: TextStyle(
                fontSize: 12,
                fontWeight: isTotalRow ? FontWeight.bold : FontWeight.normal,
                backgroundColor: isTotalRow
                    ? Colors.blueAccent.withOpacity(0.3)
                    : Colors.transparent,
              ),
            ),
          );
        }),
      ],
    );
  }

  String extractNumbers(String? value) {
    if (value == null || value.isEmpty) return "-";
    String cleaned = value.replaceAll(RegExp(r'[^0-9]'), '');
    return cleaned.isEmpty ? "-" : cleaned;
  }

  String formatNumber(String? value) {
    String cleanedValue = extractNumbers(value);

    int? number = int.tryParse(cleanedValue);
    if (number != null) {
      String formattedNumber = formatter.format(number);
      return formattedNumber;
    }

    return value ?? "-";
  }

  TextStyle _headerStyle() {
    return TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.bold,
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

  String formatAmount(double amount) {
    final format =
        NumberFormat.currency(locale: "id_ID", symbol: "Rp", decimalDigits: 2);
    return format.format(amount);
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

  void showRestrictMessenger(BuildContext context) {
    PopUpWidget(context)
        .showPopUpWarning('Anda tidak mempunyai akses', 'Ok');
  }
}
