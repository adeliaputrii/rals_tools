part of 'import.dart';

class ReportSalesDetail extends StatefulWidget {
  String? url;
  String? title;
  ReportSalesDetail({super.key, required this.url, required this.title});
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
              PopUpWidget(context).showToastMessage('Gagal memuat URL ${widget.title}');
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url ?? urlDetail));
  }

  void _onBackPressed() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (true) {
            _onBackPressed();
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
                leading: IconButton(
                  onPressed: () async {
                    _onBackPressed();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: baseColor.primaryColor,
                title: Text(
                  widget.title ?? 'Laporan Detail',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
              ),
              body: !isLoading ? WebViewWidget(controller: _controller) : Center(child: AppWidget().LoadingWidget())),
        ));
  }
}
