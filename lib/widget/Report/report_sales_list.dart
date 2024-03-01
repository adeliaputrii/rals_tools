import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myactivity_project/utils/app_navigator.dart';
import 'package:myactivity_project/utils/app_widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:myactivity_project/base/base_colors.dart' as baseColor;
import 'package:myactivity_project/base/base_assets.dart' as baseAsset;
import 'package:myactivity_project/base/base_params.dart' as baseParam;
import '../../cubit/report/report_cubit.dart';
import '../../data/model/report_list_response.dart';

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
  String searchQuery = '';

  @override
  void initState() {
    reportCubit = context.read<ReportCubit>();

    getListReport();
    super.initState();
  }

  void getListReport() {
    reportCubit.getListReport();
  }

  void search(String text) {
    setState(
      () {
        searchQuery = text;
        listReportSearch = listReport
            .where(
              (item) => (item.header1?.toLowerCase() ?? '').contains(
                text.toLowerCase(),
              ),
            )
            .toList();
      },
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: () async {
          if (true) {
            Navigator.pop(context);

            return true;
          }
        },
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: baseColor.primaryColor,
              title: isSearch
                  ? SearchInputReport(
                      controller: searchController,
                      onSelectedCallback: (value) {
                        search(value);
                      },
                    )
                  : Text('Laporan'),
              centerTitle: true,
              actions: [
                IconButton(
                    icon: !isSearch ? Icon(Icons.search) : Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        isSearch = !isSearch;
                      });
                      if (!isSearch) {
                        setState(() {
                          searchController.clear();
                          listReportSearch.clear();
                        });
                      }
                    })
              ],
            ),
            body: BlocBuilder<ReportCubit, ReportState>(builder: (context, state) {
              if (state is ReportLoading) {
                return Center(child: AppWidget().LoadingWidget());
              }
              if (state is ReportSuccess) {
                if (state.response.isNotEmpty) {
                  state.response.forEach((element) {
                    listReport.add(element);
                  });
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: listReportSearch.isEmpty ? searchEmpty() : searchResult(),
                  );
                } else {
                  AppWidget().ErrorHandler(baseParam.emptyDataReportMessage, getListReport);
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
        itemCount: listReportSearch.length,
        itemBuilder: (context, index) {
          return CardReport(response: listReportSearch[index]);
        });
  }

  Widget searchEmpty() {
    return ListView.builder(
        itemCount: listReport.length,
        itemBuilder: (builder, index) {
          return CardReport(response: listReport[index]);
        });
  }
}

class CardReport extends StatelessWidget {
  ReportListResponse response;
  CardReport({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => AppNavigator.navigateToReportSalesDetail(context, response.properties!),
      child: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
          decoration: BoxDecoration(color: baseColor.cardReportColor, borderRadius: BorderRadius.circular(20)),
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(color: baseColor.cardImageBackground, borderRadius: BorderRadius.circular(10)),
                  child: Image(
                    width: 40,
                    height: 40,
                    image: AssetImage(baseAsset.icReportList),
                  ),
                ),
                Container(
                  width: screenSize.width / 1.3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Laporan',
                              style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w500, color: baseColor.graySecondary),
                            ),
                            Text(
                              '${response.header1}',
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 18, fontWeight: FontWeight.w900, color: baseColor.grayPrimary, wordSpacing: 2),
                            ),
                            Text('${response.createDate}',
                                style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w400, color: baseColor.graySecondary))
                          ],
                        ),
                        Image(
                          width: 40,
                          height: 40,
                          image: AssetImage(baseAsset.icReportArrow),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
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
          debugPrint('text' + text);
          onSelectedCallback(text);
        },
      ),
    );
  }
}
