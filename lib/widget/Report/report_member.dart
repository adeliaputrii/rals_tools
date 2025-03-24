// import 'dart:developer';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:myactivity_project/base/base_colors.dart' as baseColor;
// import 'package:myactivity_project/cubit/report/report_cubit.dart';
// import 'package:myactivity_project/data/model/response_report_dynamic.dart';
// import 'package:myactivity_project/data/model/response_report_dynamic_header.dart';
// import 'package:myactivity_project/utils/app_shared_pref.dart';
// import 'package:myactivity_project/utils/app_widgets.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

// class MemberReport extends StatefulWidget {
//   const MemberReport({super.key});

//   @override
//   State<MemberReport> createState() => _MemberReportState();
// }

// class _MemberReportState extends State<MemberReport> {
//   late ReportCubit reportCubit;
//   String? token;
//   String? toko;
//   String? username;


//   @override
//   void initState() {
//     super.initState();
//     refreshPage();
//     reportCubit = context.read<ReportCubit>();
//     log("kesini1");
//   }

//   Future<void> refreshPage() async {
//     token = await SharedPref.getToken();
//     toko = await SharedPref.getUserToko();
//     username = await SharedPref.getUserId();
//   }

//   Future<void> generatePdf(List<ReportData> valueReport) async {
//     final pdf = pw.Document();

//     try {
//       // Load custom font dengan pengecekan
//       final ByteData data =
//           await rootBundle.load("assets/fonts/Roboto-Regular.ttf");
//       final Uint8List fontData = data.buffer.asUint8List();
//       final pw.Font font = pw.Font.ttf(ByteData.sublistView(fontData));
//       pdf.addPage(
//         pw.Page(
//           pageFormat: PdfPageFormat.a4,
//           build: (pw.Context context) {
//             return pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 pw.Text(
//                   "Laporan Data",
//                   style: pw.TextStyle(font: font, fontSize: 20),
//                 ),
//                 pw.SizedBox(height: 10),
//                 valueReport.isNotEmpty
//                     ? pw.Table.fromTextArray(
//                         headers: [
//                           "ID",
//                           "Periode",
//                           "Line",
//                           "C1",
//                           "C2",
//                           "C3",
//                           "C4",
//                           "C5",
//                         ],
//                         data: valueReport
//                             .map((data) => [
//                                   data.reportId ?? "-",
//                                   data.periode ?? "-",
//                                   data.line ?? "-",
//                                   data.c1 ?? "-",
//                                   data.c2 ?? "-",
//                                   data.c3 ?? "-",
//                                   data.c4 ?? "-",
//                                   data.c5 ?? "-",
//                                 ])
//                             .toList(),
//                         border: pw.TableBorder.all(width: 1),
//                         cellAlignment: pw.Alignment.centerLeft,
//                         headerStyle: pw.TextStyle(font: font, fontSize: 14),
//                         cellStyle: pw.TextStyle(font: font, fontSize: 12),
//                       )
//                     : pw.Text("Tidak ada data.",
//                         style: pw.TextStyle(font: font, fontSize: 14)),
//               ],
//             );
//           },
//         ),
//       );

//       // Simpan file PDF ke storage sementara
//       final output = await getTemporaryDirectory();
//       final file = File("${output.path}/laporan.pdf");
//       await file.writeAsBytes(await pdf.save());
//     } catch (e) {
//       print("Error saat membuat PDF: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Report Dynamic',
//           style: GoogleFonts.plusJakartaSans(
//             fontSize: 20,
//             fontWeight: FontWeight.w500,
//             color: Colors.white,
//           ),
//         ),
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//         ),
//         backgroundColor: baseColor.primaryColor,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//       ),
//     );
//   }

//   Widget loadingReportDynamic() {
//     return Column(
//       children: [Center(child: AppWidget().LoadingWidget())],
//     );
//   }

//   TextStyle _headerStyle() {
//     return TextStyle(
//       fontSize: 13,
//       fontWeight: FontWeight.bold,
//     );
//   }
// }
