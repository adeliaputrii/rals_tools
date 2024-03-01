part of 'import.dart';

class NewsDetail extends StatefulWidget {
  const NewsDetail({super.key, required this.newsUrl, required this.fromHome});
  final String newsUrl;
  final bool fromHome;

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  TransformationController controller = TransformationController();
  late final WebViewController _controller;
  bool isLoading = false;
  int progressBar = 0;
  String urlDetail = "";

  @override
  void initState() {
    super.initState();
    urlDetail = widget.newsUrl;
    if (urlDetail != "") {
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
              if (request.url.startsWith('https://www.youtube.com/')) {
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse(urlDetail));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (true) {
          if (!widget.fromHome) {
            Navigator.pop(context);
          } else {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
              return DefaultBottomBarController(child: Ramayana());
            }), (route) => false);
          }
          return true;
        }
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                if (!widget.fromHome) {
                  Navigator.pop(context);
                } else {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                    return DefaultBottomBarController(child: Ramayana());
                  }), (route) => false);
                }
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            title: Text(
              'Berita',
              style: GoogleFonts.plusJakartaSans(textStyle: TextStyle(fontSize: 23, color: Colors.white, fontWeight: FontWeight.w500)),
            ),
            backgroundColor: Color.fromARGB(255, 210, 14, 0),
            elevation: 5,
            toolbarHeight: 90,
          ),
          body: !isLoading ? WebViewWidget(controller: _controller) : Center(child: Text('${progressBar}%'))),
    );
  }
}
