import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myactivity_project/utils/app_widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:myactivity_project/base/base_colors.dart' as baseColor;

import '../../cubit/report/report_cubit.dart';
import '../../data/model/report_list_response.dart';

class ReportSalesDetail extends StatefulWidget {
  String? url;
  ReportSalesDetail({super.key, required this.url});
  @override
  State<ReportSalesDetail> createState() => _ReportSalesDetailState();
}

class _ReportSalesDetailState extends State<ReportSalesDetail> {
  TransformationController controller = TransformationController();
  late final WebViewController _controller;
  bool isLoading = true;
  int progressBar = 0;
  String urlDetail = 'https://www.youtube.com/';
  bool isSearch = false;
  late ReportCubit reportCubit;
  List<ReportListResponse> listReport = [];

  @override
  void initState() {
    reportCubit = context.read<ReportCubit>();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    // reportCubit.getListReport();
    setContentWebView();
    super.initState();
  }

  void setContentWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              progressBar = progress;
            });
          },
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url == 'https://m.youtube.com/') {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url ?? urlDetail));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (true) {
            Navigator.pop(context);

            return true;
          }
        },
        child: BlocListener<ReportCubit, ReportState>(
          listener: (context, state) {
            if (state is ReportSuccess) {
              state.response.forEach((element) {
                debugPrint('lsit report${element.properties}');
                listReport.add(element);
              });
              if (state.response.length == listReport.length) {
                setState(() {
                  isLoading = false;
                });
              } else {
                setState(() {
                  isLoading = true;
                });
              }
            }
          },
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: baseColor.primaryColor,
                title: Text('Laporan Detail'),
                centerTitle: true,
              ),
              body: !isLoading ? WebViewWidget(controller: _controller) : Center(child: AppWidget().LoadingWidget())),
        ));
  }
}
