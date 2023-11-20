part of 'import.dart';

class NewsDetail extends StatefulWidget {
  const NewsDetail({super.key});

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Container(color: Colors.white,),
              Container(
              margin: EdgeInsets.only(left: 10),
              child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(context, 
                       MaterialPageRoute(builder: (context){
                       return DefaultBottomBarController(child: Ramayana());
                       }), (route) => false);
                    },
                    icon: Icon(Icons.arrow_back_ios,
                    color: Color.fromARGB(255, 210, 14, 0),
                    ),
                    ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text('Breaking News',
                    style: GoogleFonts.mukta(
                      fontSize: 37,
                      color:Color.fromARGB(255, 199, 0, 0),
                      fontWeight: FontWeight.w500
                    ), 
                    ),
                  ),
                  Column(
                    children: News.newsDetail.map((e) {
                      return
                      Container(
                        margin: EdgeInsets.only(left: 10, top: 10, right: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(e.url_photo)),
                      );
                    }).toList()
                  ),
                  Column(
                    children: News.newsDetail.map((e) {
                      return
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Text('${e.berita_hdr}',
                        style: GoogleFonts.mukta(
                          fontSize: 25,
                          color:Colors.black,
                          fontWeight: FontWeight.w500
                        ), 
                         )
                        );
                    }).toList()
                  ),
                   Column(
                    children: News.newsDetail.map((e) {
                      var stringHtml = '${e.berita_dtl}';
                      return
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                        child: 
                        Row(children: [
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/ramay.png')),
                            SizedBox(width: 10,),
                          Text('Ramayana Information System',
                          style: GoogleFonts.rubik(fontSize: 17, color: Color.fromARGB(255, 123, 122, 122)),
                          )
                        ],)
                        );
                    }).toList()
                  ),
                   Column(
                    children: News.newsDetail.map((e) {
                      var stringHtml = '${e.berita_dtl}';
                      return
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                        child: 
                        Html(data: stringHtml, 
                        style: {
                        'p': Style(
                         fontSize: FontSize(20.0) ,
                         fontFamily: GoogleFonts.mukta(
                         color: Colors.black).fontFamily
                          ),
                          },
                          ),
                        );
                    }).toList()
                  )
                ],
              ),)
          ]),
        ],
      ),
    );
  }
}