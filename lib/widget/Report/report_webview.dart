import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../data/model/report_webview_model.dart';
import '../../utils/app_widgets.dart';

class ReportWebview extends StatefulWidget {
  ReportSalesWebviewModel reportModel;
  ReportWebview({super.key, required this.reportModel});

  @override
  State<ReportWebview> createState() => _ReportWebviewState();
}

class _ReportWebviewState extends State<ReportWebview> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    widget.reportModel.webController = WebViewController();
    widget.reportModel.webController!.setJavaScriptMode(JavaScriptMode.unrestricted);
    widget.reportModel.webController!.setBackgroundColor(Colors.white);
    widget.reportModel.webController!.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          setState(() {
            widget.reportModel.isLoading = true;
            widget.reportModel.progressBar = progress;
          });
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {
          debugPrint('url finish ${url}');
          setState(() {
            widget.reportModel.isLoading = false;
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
    );
    widget.reportModel.webController!.loadRequest(Uri.parse(widget.reportModel.url.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.reportModel.isLoading ?? true
        ? AppWidget().LoadingWidget()
        : WebViewWidget(
            controller: widget.reportModel.webController!,
          );
  }

  @override
  bool get wantKeepAlive => true;
}
