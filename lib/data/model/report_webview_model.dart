import 'package:webview_flutter/webview_flutter.dart';

class ReportSalesWebviewModel {
  WebViewController? webController;
  String? url;
  bool? isLoading;
  bool? isFinish;
  int? progressBar;

  ReportSalesWebviewModel({this.url, this.isLoading, this.isFinish, this.webController, this.progressBar});

  @override
  String toString() {
    return 'ReportSalesWebviewModel{'
        'webController: $webController, '
        'url: $url, '
        'isLoading: $isLoading, '
        'isFinish: $isFinish, '
        'progressBar: $progressBar}';
  }
}
