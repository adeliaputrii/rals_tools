part of 'import.dart';

class ReportWebview extends StatefulWidget {
  ReportSalesWebviewModel reportModel;
  ReportWebview({super.key, required this.reportModel});

  @override
  State<ReportWebview> createState() => _ReportWebviewState();
}

class _ReportWebviewState extends State<ReportWebview> with AutomaticKeepAliveClientMixin {
  late LoginCubit loginCubit;
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

    loginCubit = context.read<LoginCubit>();
    loginCubit.createLog(
        baseParam.logInfoNavigateDetailReportPage, '${baseParam.logInfoDetiailReportUrl} ${widget.reportModel.url}', '${widget.reportModel.url}');
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
