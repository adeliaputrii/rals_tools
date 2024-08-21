import 'package:flutter/cupertino.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';

class News {
  News({
    required this.berita_hdr,
    required this.berita_dtl,
    required this.url_photo,
    // required this.date,
  });

  final String berita_hdr, berita_dtl, url_photo;
  // date;

  factory News.fromjson(
    Map<String, dynamic> json1,
  ) =>
      News(
        berita_hdr: json1["berita_hdr"],
        berita_dtl: json1["news_url"],
        url_photo: json1["url_photo"],
        // date: json1["date"],
      );

  static List<News> news = [];
  static List<News> news3 = [];
  static List<News> newsDetail = [];
}
