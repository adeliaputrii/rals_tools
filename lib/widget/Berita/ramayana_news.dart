part of 'import.dart';

class RamayanaInformasi extends StatefulWidget {
  const RamayanaInformasi({super.key});

  @override
  State<RamayanaInformasi> createState() => _RamayanaInformasiState();
}

class _RamayanaInformasiState extends State<RamayanaInformasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return DefaultBottomBarController(child: Ramayana());
            }), (route) => false);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
        ),
        toolbarHeight: 75,
          title: Text('Ramayana Update',
          style: GoogleFonts.plusJakartaSans(fontSize: 23, color: Colors.white)),
          backgroundColor: Color.fromARGB(255, 210, 14, 0),
        
          
        ),
      body: 
      Stack(
        children: <Widget>[
          Container(
            child: 
            Image.asset(
              'assets/background.png',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
            
          ),
          Container(
              color: Colors.white70,
            child: ListView(
              children: [
                Container(
                 decoration: BoxDecoration(
                 
        ),
                  child: Column(
                    children: News.news.map((e) {
                      var stringHtml = '${e.berita_dtl}';
                      return
                      InkWell(
                       onTap: () {
                        News.newsDetail.clear();
                        setState(() {
                        News.newsDetail.add(e);
                        print(News.newsDetail);
                         });
                        Navigator.pushAndRemoveUntil(context, 
                        MaterialPageRoute(builder: (context){
                        return NewsDetail();
                        }), (route) => false);
                        print('navigator');
                          },
                        child: Container(
                                          margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 5,
                                                offset: Offset(1, 3)
                                              ),
                                            ]
                                          ),
                                          height: 150,
                                          child: 
                                          Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(top: 20,right: 10, bottom: 15, left: 10),
                                              width: 180,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: Image.network('${e.url_photo}',
                                                fit: BoxFit.fill),
                                              ),
                                            ),
                                             Expanded(
                                               child: Container(
                                                margin: EdgeInsets.only(top: 20,right: 10, bottom: 15, left: 10),
                                                child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                
                                                Text(
                                                  '${e.berita_hdr}',
                                                  style:GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black)
                                                ),
                                                SizedBox(
                                                height: 5,
                                                          ),
                                                Flexible(
                                                  child: Html(data: stringHtml, 
                                                 style: {
                                                  'h1': Style(
                                                  maxLines: 3,
                                                  fontFamily: GoogleFonts.plusJakartaSans(
                                                  fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black).fontFamily
                                                ),
                                                },
                                                ),
                                                ),
                                                SizedBox(
                                                height: 10,
                                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    SizedBox(),
                                                    Text('Lihat Selengkapnya>>>',
                                                    style:GoogleFonts.plusJakartaSans(fontSize: 14, color: Color.fromARGB(255, 255, 0, 0), fontWeight: FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                               
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                          ],
                                           ),
                                           ),
                      );
                     }).toList()
                  ),
                ),
              ],
            )
          )
        ]
         
        )
        
    );
  }
}