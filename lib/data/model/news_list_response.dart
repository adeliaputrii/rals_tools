import 'package:json_annotation/json_annotation.dart';

part 'news_list_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class NewsListResponse {
  int? status;
  String? message;
  List<Data>? data;

  NewsListResponse({this.status, this.message, this.data});

  NewsListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? beritaHdr;
  String? urlPhoto;
  String? newsUrl;

  Data({this.id, this.beritaHdr, this.urlPhoto, this.newsUrl});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    beritaHdr = json['berita_hdr'];
    urlPhoto = json['url_photo'];
    newsUrl = json['news_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['berita_hdr'] = this.beritaHdr;
    data['url_photo'] = this.urlPhoto;
    data['news_url'] = this.newsUrl;
    return data;
  }
}
