import 'package:json_annotation/json_annotation.dart';

part 'get_news_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GetNewsResponse {
  int? status;
  String? message;
  List<Data>? data;

  GetNewsResponse({this.status, this.message, this.data});

  GetNewsResponse.fromJson(Map<String, dynamic> json) {
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
  String? beritaHdr;
  String? beritaDtl;
  String? urlPhoto;
  String? date;

  Data({this.beritaHdr, this.beritaDtl, this.urlPhoto, this.date});

  Data.fromJson(Map<String, dynamic> json) {
    beritaHdr = json['berita_hdr'];
    beritaDtl = json['berita_dtl'];
    urlPhoto = json['url_photo'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['berita_hdr'] = this.beritaHdr;
    data['berita_dtl'] = this.beritaDtl;
    data['url_photo'] = this.urlPhoto;
    data['date'] = this.date;
    return data;
  }
}
