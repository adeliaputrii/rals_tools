import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:myactivity_project/base/base_colors.dart' as baseColor;
import 'package:myactivity_project/cubit/login/login_cubit.dart';
import 'package:myactivity_project/cubit/report/report_cubit.dart';
import 'package:myactivity_project/data/model/report_sales_response.dart';
import 'package:myactivity_project/utils/popup_widget.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class DetailPage extends StatefulWidget {
=======
import 'package:myactivity_project/data/model/report_sales_response.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class DetailPage extends StatelessWidget {
>>>>>>> ca9c5a6f5632931b67b809aa0513fce3d27c6e6a
  final SalesData item;

  DetailPage({required this.item});

<<<<<<< HEAD
  @override
  State<DetailPage> createState() => _DetailPageState();
}

late ReportCubit reportCubit;
late LoginCubit loginCubit;
late PopUpWidget popUpWidget;
double totalNet = 0.0;
double totalTarget = 0.0;
double totalGross = 0.0;
double totalDiscount = 0.0;

class _DetailPageState extends State<DetailPage> {
  Future<void> _downloadPDF(BuildContext context) async {
    log('Downloading PDF...');

    var status = await Permission.storage.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Izin penyimpanan ditolak!')),
      );
=======
  Future<void> _downloadPDF(BuildContext context) async {
    log('Downloading PDF...');
    var status = await Permission.storage.request();
    if (!status.isGranted) {
      print('Storage permission denied');
>>>>>>> ca9c5a6f5632931b67b809aa0513fce3d27c6e6a
      return;
    }

    if (await Permission.manageExternalStorage.isDenied) {
      var manageStatus = await Permission.manageExternalStorage.request();
      if (!manageStatus.isGranted) {
<<<<<<< HEAD
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Izin pengelolaan penyimpanan ditolak!')),
        );
=======
        print('Manage storage permission denied');
>>>>>>> ca9c5a6f5632931b67b809aa0513fce3d27c6e6a
        return;
      }
    }

<<<<<<< HEAD
    log('Storage permission granted');
=======
    print('Storage permission granted');
>>>>>>> ca9c5a6f5632931b67b809aa0513fce3d27c6e6a

    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
<<<<<<< HEAD
        build: (context) => pw.Container(
          padding: pw.EdgeInsets.all(16),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Detail Laporan Penjualan',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.Divider(),
              _buildPdfText('Toko', widget.item.toko),
              _buildPdfText('MD', widget.item.md),
              _buildPdfText('Tanggal', widget.item.tanggal),
              _buildPdfText('Net', widget.item.net),
              _buildPdfText('Target', widget.item.target),
            ],
          ),
=======
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Toko: ${item.toko}',
                style:
                    pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            pw.Text('MD: ${item.md}'),
            pw.Text('Net: ${item.net}'),
            pw.Text('Target: ${item.target}'),
            pw.Text('Tanggal: ${item.tanggal}'),
          ],
>>>>>>> ca9c5a6f5632931b67b809aa0513fce3d27c6e6a
        ),
      ),
    );

    final directory = Directory('/storage/emulated/0/Download');
    if (!await directory.exists()) {
      directory.create(recursive: true);
    }

<<<<<<< HEAD
    final file = File(
        '${directory.path}/sales_report_${widget.item.toko}_${widget.item.tanggal}.pdf');
    await file.writeAsBytes(await pdf.save());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'PDF berhasil disimpan: ${file.path}',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: baseColor.primaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        duration: Duration(seconds: 3),
        margin: EdgeInsets.all(16),
      ),
    );
  }

  pw.Widget _buildPdfText(String label, String? value) {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(vertical: 4),
      child:
          pw.Text('$label: ${value ?? "-"}', style: pw.TextStyle(fontSize: 14)),
    );
  }

  @override
  void initState() {
    super.initState();
    reportCubit = context.read<ReportCubit>();
    popUpWidget = PopUpWidget(context);
    loginCubit = context.read<LoginCubit>();
    // _debounceTimer?.cancel();
    // refreshPage();
  }

  // refreshPage() async {
  //   toko = await SharedPref.getUserToko();
  //   token = await SharedPref.getToken();
  //   username = await SharedPref.getUserId();
  //   initDataReport();
  //   scrollListener();
  //   searchController.clear();
  // }

  // void initDataReport() {
  //   reportCubit.getListReportPagination(token ?? '', "", "", "", "");

  //   loginCubit.createLog(
  //       baseParam.logInfoReportPage,
  //       baseParam.logInfoNavigateReportPage,
  //       basePath.api_report_list_pagination);
  // }

  // void scrollListener() {
  //   scrollController.addListener(() {
  //     if (scrollController.position.maxScrollExtent ==
  //         scrollController.offset) {
  //       getListReport();
  //     }
  //   });
  // }
=======
    final file =
        File('${directory.path}/sales_report_${item.toko}_${item.tanggal}.pdf');
    await file.writeAsBytes(await pdf.save());

    // Show notification to the user
    print('PDF saved to: ${file.path}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('PDF saved to: ${file.path}')),
    );
  }

>>>>>>> ca9c5a6f5632931b67b809aa0513fce3d27c6e6a
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        title: Text(
          'Detail report',
          style: GoogleFonts.plusJakartaSans(
              fontSize: 23, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(255, 131, 113, 113),
          ),
        ),
        backgroundColor: baseColor.primaryColor,
=======
        title: Text('Detail Report'),
>>>>>>> ca9c5a6f5632931b67b809aa0513fce3d27c6e6a
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
<<<<<<< HEAD
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildDetailItem(Icons.store, 'Toko', widget.item.toko),
                    _buildDetailItem(Icons.person, 'MD', widget.item.md),
                    _buildDetailItem(
                        Icons.date_range, 'Tanggal', widget.item.tanggal),
                    _buildDetailItem(
                        Icons.network_check, 'Net', widget.item.net),
                    _buildDetailItem(Icons.flag, 'Target', widget.item.target),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "All Report Sales",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10,),
                ElevatedButton.icon(
                  onPressed: () {
                    _downloadPDF(context);
                  },
                  icon: Icon(Icons.download),
                  label: Text('Download PDF'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
                Padding(
                  padding: const EdgeInsets.only(right: 250),
                  child: Divider(thickness: 2, color: Colors.grey),
                ),

            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),
                child: BlocBuilder<ReportCubit, ReportState>(
                  builder: (context, state) {
                    if (state is ReportLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is ReportSalesSuccess) {
                      return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Table(
                              border: TableBorder.all(
                                color: Colors.grey.withOpacity(0.3),
                                width: 1,
                              ),
                              columnWidths: const {
                                0: IntrinsicColumnWidth(),
                                1: IntrinsicColumnWidth(),
                                2: IntrinsicColumnWidth(),
                                3: IntrinsicColumnWidth(),
                                4: IntrinsicColumnWidth(),
                                5: IntrinsicColumnWidth(),
                                6: IntrinsicColumnWidth(),
                                7: IntrinsicColumnWidth(),
                              },
                              children: [
                                TableRow(
                                  decoration: BoxDecoration(
                                      color: baseColor.cardReportColor),
                                  children: [
                                    _tableCell('Store', bold: true),
                                    _tableCell('MD', bold: true),
                                    _tableCell('Date', bold: true),
                                    _tableCell('Net', bold: true),
                                    _tableCell('Target', bold: true),
                                    _tableCell('Qty', bold: true),
                                    _tableCell('Gross', bold: true),
                                    _tableCell('Discount', bold: true),
                                  ],
                                ),
                                ...List.generate(state.response.length,
                                    (index) {
                                  final item = state.response[index];

                                  // Update totals
                                  totalNet +=
                                      double.tryParse(item.net ?? "0.00") ??
                                          0.0;
                                  totalTarget +=
                                      double.tryParse(item.target ?? "0.00") ??
                                          0.0;
                                  totalGross +=
                                      double.tryParse(item.gross ?? "0.00") ??
                                          0.0;
                                  totalDiscount += double.tryParse(
                                          item.discount ?? "0.00") ??
                                      0.0;

                                  return TableRow(
                                    children: [
                                      _tableCell('${item.toko ?? "-"}'),
                                      _tableCell('${item.md ?? "-"}'),
                                      _tableCell(
                                        formatTanggal(item.tanggal),
                                      ),
                                      _tableCell(
                                          '${item.net != "0.00" ? formatAmount(double.tryParse(item.net ?? "0.00") ?? 0.00) : item.net}'),
                                      _tableCell(
                                          '${item.target != "0.00" ? formatAmount(double.tryParse(item.target ?? "0.00") ?? 0.00) : item.target}'),
                                      _tableCell('${item.qty ?? "0"}'),
                                      _tableCell(
                                          '${item.gross != "0.00" ? formatAmount(double.tryParse(item.gross ?? "0.00") ?? 0.00) : item.gross}'),
                                      _tableCell(
                                          '${item.discount != "0.00" ? formatAmount(double.tryParse(item.discount ?? "0.00") ?? 0.00) : item.discount}'),
                                    ],
                                  );
                                }),

                                // Row for totals
                                TableRow(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1)),
                                  children: [
                                    _tableCell('Total', bold: true),
                                    _tableCell(''),
                                    _tableCell(''),
                                    _tableCell('${formatAmount(totalNet)}'),
                                    _tableCell('${formatAmount(totalTarget)}'),
                                    _tableCell(''),
                                    _tableCell('${formatAmount(totalGross)}'),
                                    _tableCell(
                                        '${formatAmount(totalDiscount)}'),
                                  ],
                                ),
                              ],
                            ),
                          ));
                    } else if (state is ReportFailure) {
                      return Center(
                        child: Text("Terjadi kesalahan: ${state.message}"),
                      );
                    }
                    return Center(child: Text("Tidak ada data"));
                  },
                ),
              ),
=======
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Table(
              border: TableBorder.all(),
              columnWidths: {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(2),
              },
              children: [
                _buildTableRow('Toko', item.toko ?? ''),
                _buildTableRow('MD', item.md ?? ''),
                _buildTableRow('Tanggal', item.tanggal ?? ''),
                _buildTableRow('Net', item.net ?? ''),
                _buildTableRow('Target', item.target ?? ''),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _downloadPDF(context), // Corrected line
              child: Text('Download PDF'),
>>>>>>> ca9c5a6f5632931b67b809aa0513fce3d27c6e6a
            ),
          ],
        ),
      ),
    );
  }
<<<<<<< HEAD
}

String formatTanggal(String? tanggal) {
  if (tanggal == null || tanggal.isEmpty) return "-";
  print(tanggal);
  try {
    DateTime date = DateTime.parse(tanggal);
    return DateFormat('dd-MM-yyyy', "id_ID").format(date);
  } catch (e) {
    print("object $e");
    return "-";
  }
}

String formatAmount(double amount) {
  final format = NumberFormat("#,##0.00", "en_US");
  return format.format(amount);
}

Widget _tableCell(String text, {bool bold = false}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      text,
      textAlign: TextAlign.center, // Pusatkan teks
      style: TextStyle(
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      ),
    ),
  );
}

Widget _buildDetailItem(IconData icon, String label, String? value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Icon(icon, color: Colors.blueGrey, size: 28),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700])),
              SizedBox(height: 2),
              Text(value ?? '-',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    ),
  );
=======

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value),
        ),
      ],
    );
  }
>>>>>>> ca9c5a6f5632931b67b809aa0513fce3d27c6e6a
}
