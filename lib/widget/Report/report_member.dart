import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:myactivity_project/utils/app_widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myactivity_project/base/base_colors.dart' as baseColor;
import 'package:myactivity_project/cubit/report/report_cubit.dart';
import 'package:myactivity_project/data/model/response_report_dynamic.dart';
import 'package:myactivity_project/data/model/response_report_dynamic_header.dart';
import 'package:myactivity_project/utils/app_shared_pref.dart';

import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

class MemberReport extends StatefulWidget {
  const MemberReport({super.key});

  @override
  State<MemberReport> createState() => _MemberReportState();
}

class _MemberReportState extends State<MemberReport> {
  late ReportCubit reportCubit;
  String? token;
  String? toko;
  String? username;
  String? inputReportId = "";
  String? selectedReportId; // Menyimpan ID report yang dipilih
  List<ReportDynamic> reportList = []; // List laporan untuk dropdown

  @override
  void initState() {
    super.initState();
    refreshPage();
    reportCubit = context.read<ReportCubit>();
    reportCubit.getReportdynamicHeader(token ?? '');
    log("kesini1");
  }

  Future<void> refreshPage() async {
    token = await SharedPref.getToken();
    toko = await SharedPref.getUserToko();
    username = await SharedPref.getUserId();
  }

  Future<void> generatePdf(List<ReportData> valueReport) async {
    final pdf = pw.Document();

    try {
      // Load custom font dengan pengecekan
      final ByteData data =
          await rootBundle.load("assets/fonts/Roboto-Regular.ttf");
      final Uint8List fontData = data.buffer.asUint8List();
      final pw.Font font = pw.Font.ttf(ByteData.sublistView(fontData));
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  "Laporan Data",
                  style: pw.TextStyle(font: font, fontSize: 20),
                ),
                pw.SizedBox(height: 10),
                valueReport.isNotEmpty
                    ? pw.Table.fromTextArray(
                        headers: [
                          "ID",
                          "Periode",
                          "Line",
                          "C1",
                          "C2",
                          "C3",
                          "C4",
                          "C5",
                        ],
                        data: valueReport
                            .map((data) => [
                                  data.reportId ?? "-",
                                  data.periode ?? "-",
                                  data.line ?? "-",
                                  data.c1 ?? "-",
                                  data.c2 ?? "-",
                                  data.c3 ?? "-",
                                  data.c4 ?? "-",
                                  data.c5 ?? "-",
                                ])
                            .toList(),
                        border: pw.TableBorder.all(width: 1),
                        cellAlignment: pw.Alignment.centerLeft,
                        headerStyle: pw.TextStyle(font: font, fontSize: 14),
                        cellStyle: pw.TextStyle(font: font, fontSize: 12),
                      )
                    : pw.Text("Tidak ada data.",
                        style: pw.TextStyle(font: font, fontSize: 14)),
              ],
            );
          },
        ),
      );

      // Simpan file PDF ke storage sementara
      final output = await getTemporaryDirectory();
      final file = File("${output.path}/laporan.pdf");
      await file.writeAsBytes(await pdf.save());
    } catch (e) {
      print("Error saat membuat PDF: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Report Dynamic',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        backgroundColor: baseColor.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: reportList
                      .any((report) => report.reportId == selectedReportId)
                  ? selectedReportId
                  : null, // Hindari nilai yang tidak valid
              decoration: InputDecoration(
                labelText: "Selected Report",
                border: OutlineInputBorder(),
              ),
              items: reportList
                  .fold<Map<String, ReportDynamic>>({}, (map, report) {
                    // Simpan hanya satu item per nama report
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
            BlocBuilder<ReportCubit, ReportState>(builder: (context, state) {
              if (state is ReportInitial || state is ReportLoading) {
                return SizedBox.shrink();
              } else if (state is ReportFailure) {
                log("kesini ERROR");

                return Center(
                  child: Text(
                    "Error: ${state.message}",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                );
              } else if (state is ReportgetDynamicHeaderSuccess) {
                log("kesini - menerima data dari state");

                final List<ReportDynamic> reportData = state.response;

                if (reportData.isEmpty) {
                  log("Data report kosong");
                  return const Center(child: Text("Data tidak ditemukan"));
                }

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    setState(() {
                      reportList = reportData;
                      log("Report list setelah filter: ${reportList.length} items");
                    });
                  }
                });
              }
              return SizedBox.shrink();
            }),
            SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<ReportCubit, ReportState>(
                builder: (context, state) {
                  if (state is ReportInitial || state is ReportLoading) {
                    return loadingReportDynamic();
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

                    final int indexTarget = 0;
                    final bool hasData = valueReport.isNotEmpty &&
                        indexTarget < valueReport.length;

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
                                onPressed: () => generatePdf(
                                    valueReport), // Fungsi untuk generate PDF
                                icon: Icon(Icons.picture_as_pdf,
                                    color: Colors.white),
                                label: Text("Download PDF"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                ),
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
                                  columns: [
                                    DataColumn(
                                        label: Text(
                                      "ID",
                                      style: _headerStyle(),
                                      textAlign: TextAlign.center,
                                    )),
                                    DataColumn(
                                        label: Text("Periode",
                                            style: _headerStyle(),
                                            textAlign: TextAlign.center)),
                                    DataColumn(
                                        label: Text("Line",
                                            style: _headerStyle(),
                                            textAlign: TextAlign.center)),
                                    DataColumn(
                                        label: Text(
                                            hasData
                                                ? valueReport[indexTarget]
                                                    .c1
                                                    .toString()
                                                : "-",
                                            style: _headerStyle(),
                                            textAlign: TextAlign.center)),
                                    DataColumn(
                                        label: Text(
                                            hasData
                                                ? valueReport[indexTarget]
                                                    .c2
                                                    .toString()
                                                : "-",
                                            style: _headerStyle(),
                                            textAlign: TextAlign.center)),
                                    DataColumn(
                                        label: Text(
                                            hasData
                                                ? valueReport[indexTarget]
                                                    .c3
                                                    .toString()
                                                : "-",
                                            style: _headerStyle(),
                                            textAlign: TextAlign.center)),
                                    DataColumn(
                                        label: Text("C4",
                                            style: _headerStyle(),
                                            textAlign: TextAlign.center)),
                                    DataColumn(
                                        label: Text(
                                            hasData
                                                ? valueReport[indexTarget]
                                                    .c4
                                                    .toString()
                                                : "-",
                                            style: _headerStyle(),
                                            textAlign: TextAlign.center)),
                                  ],
                                  rows: valueReport.map((data) {
                                    return DataRow(cells: [
                                      DataCell(Text(data.reportId ?? "-",
                                          style: TextStyle(fontSize: 12))),
                                      DataCell(Text(data.periode ?? "-",
                                          style: TextStyle(fontSize: 12))),
                                      DataCell(Text(data.line ?? "-",
                                          style: TextStyle(fontSize: 12))),
                                      DataCell(Text(data.c1 ?? "-",
                                          style: TextStyle(fontSize: 12))),
                                      DataCell(Text(data.c2 ?? "-",
                                          style: TextStyle(fontSize: 12))),
                                      DataCell(Text(data.c3 ?? "-",
                                          style: TextStyle(fontSize: 12))),
                                      DataCell(Text(data.c4 ?? "-",
                                          style: TextStyle(fontSize: 12))),
                                      DataCell(Text(data.c5 ?? "-",
                                          style: TextStyle(fontSize: 12))),
                                    ]);
                                  }).toList(),
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
        ),
      ),
    );
  }

  Widget loadingReportDynamic() {
    return Column(
      children: [Center(child: AppWidget().LoadingWidget())],
    );
  }

  TextStyle _headerStyle() {
    return TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.bold,
    );
  }
}
