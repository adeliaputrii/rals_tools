part of 'import.dart';

class ReportSalesDetailPager extends StatefulWidget {
  String? url;
  String title;
  ReportSalesDetailPager({super.key, required this.url, required this.title});

  @override
  State<ReportSalesDetailPager> createState() => _ReportSalesDetailPagerState();
}

class _ReportSalesDetailPagerState extends State<ReportSalesDetailPager> {
  late LoginCubit loginCubit;

  @override
  void initState() {
    super.initState();
  }

  void _onBackPressed() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.title}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
        ),
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
      ),
      body: ReportViewPager(url: widget.url),
    );
  }
}

class ReportViewPager extends StatefulWidget {
  String? url;
  ReportViewPager({super.key, required this.url});

  @override
  State<ReportViewPager> createState() => _ReportViewPagerState();
}

class _ReportViewPagerState extends State<ReportViewPager> with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  late final WebViewController _controller;
  late List<bool> _isUrlLoaded = [];

  List<ReportSalesWebviewModel> reportWebviewModel = [];
  List<WebViewController> _webController = [];
  List<String> urlList = [];

  int _currentPageIndex = 0;
  int indexPage = 0;
  int progressBar = 0;

  bool isLoading = true;

  @override
  void initState() {
    initUrl();
    initController();
    super.initState();
  }

  void initController() {
    _pageViewController = PageController();
    _tabController = TabController(length: reportWebviewModel.length, vsync: this);
  }

  void initUrl() {
    _isUrlLoaded = List.generate(urlList.length, (_) => false);
    if (widget.url != null || widget.url!.isNotEmpty) {
      urlList = widget.url!.split('|');
      debugPrint('list url ${urlList}');
    }
    urlList.forEach((element) {
      final WebViewController _initController = WebViewController();

      _webController.add(_initController);
      final reportModel = ReportSalesWebviewModel(url: element, isFinish: false, isLoading: false, webController: _webController[0], progressBar: 0);
      reportWebviewModel.add(reportModel);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final screenSize = MediaQuery.of(context).size;
    return reportWebviewModel.isNotEmpty
        ? Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              PageView(
                controller: _pageViewController,
                onPageChanged: _handlePageViewChanged,
                children: <Widget>[
                  for (var data in reportWebviewModel) Center(child: ReportWebview(reportModel: data)),
                ],
              ),
              reportWebviewModel.length > 1
                  ? Positioned(
                      bottom: 15,
                      left: 0,
                      right: 0,
                      child: Container(
                        // Wrap SmoothPageIndicator with Container to center it
                        width: screenSize.width, // Set width to screen width
                        child: Center(
                          child: SmoothPageIndicator(
                            controller: _pageViewController,
                            count: reportWebviewModel.length,
                            effect: const WormEffect(
                              dotHeight: 12,
                              dotWidth: 12,
                              activeDotColor: baseColor.primaryColor,
                              dotColor: baseColor.graySecondary,
                              type: WormType.thinUnderground,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          )
        : Center(child: AppWidget().EmptyHandler(baseParam.emptyDataReportMessage));
  }

  void _handlePageViewChanged(int currentPageIndex) {
    setState(() {
      _currentPageIndex = currentPageIndex;
      _tabController.index = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}
