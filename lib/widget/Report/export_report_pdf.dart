

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myactivity_project/base/base_colors.dart' as baseColors;
import 'package:myactivity_project/cubit/report/report_cubit.dart';

class PdfDownloadButton extends StatefulWidget {
  final int? selectedReportId;

  const PdfDownloadButton({Key? key, required this.selectedReportId})
      : super(key: key);

  @override
  _PdfDownloadButtonState createState() => _PdfDownloadButtonState();
}

class _PdfDownloadButtonState extends State<PdfDownloadButton> {
  bool _isDownloading = false;
  late ReportCubit reportCubit;
  String? token;

  @override
  void initState() {
    super.initState();
    reportCubit = context.read<ReportCubit>();
  }


  Future<void> _downloadPdf() async {
    if (widget.selectedReportId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Pilih report terlebih dahulu")),
      );
      return;
    }

    setState(() => _isDownloading = true);

    try {
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal mengunduh PDF: $e")),
      );
    } finally {
      setState(() => _isDownloading = false);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, right: 10),
      child: ElevatedButton.icon(
        icon: _isDownloading
            ? CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
            : Icon(Icons.picture_as_pdf, color: Colors.white),
        label: Text("Download PDF", style: TextStyle(color: Colors.yellow)),
        style: ElevatedButton.styleFrom(
          backgroundColor: baseColors.primaryColor,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        onPressed: _isDownloading ? null : _downloadPdf,
      ),
    );
  }
}
