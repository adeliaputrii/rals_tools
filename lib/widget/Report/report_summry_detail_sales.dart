import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myactivity_project/data/model/report_sales_response.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class DetailPage extends StatelessWidget {
  final SalesData item;

  DetailPage({required this.item});

  Future<void> _downloadPDF(BuildContext context) async {
    log('Downloading PDF...');
    var status = await Permission.storage.request();
    if (!status.isGranted) {
      print('Storage permission denied');
      return;
    }

    if (await Permission.manageExternalStorage.isDenied) {
      var manageStatus = await Permission.manageExternalStorage.request();
      if (!manageStatus.isGranted) {
        print('Manage storage permission denied');
        return;
      }
    }

    print('Storage permission granted');

    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
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
        ),
      ),
    );

    final directory = Directory('/storage/emulated/0/Download');
    if (!await directory.exists()) {
      directory.create(recursive: true);
    }

    final file =
        File('${directory.path}/sales_report_${item.toko}_${item.tanggal}.pdf');
    await file.writeAsBytes(await pdf.save());

    // Show notification to the user
    print('PDF saved to: ${file.path}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('PDF saved to: ${file.path}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
            ),
          ],
        ),
      ),
    );
  }

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
}
