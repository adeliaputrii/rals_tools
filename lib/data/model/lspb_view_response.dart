import 'package:json_annotation/json_annotation.dart';
part 'lspb_view_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LspbViewRequestResponse {
  int? status;
  String? message;
  List<Data>? data;

  LspbViewRequestResponse({this.status, this.message, this.data});

  LspbViewRequestResponse.fromJson(Map<String, dynamic> json) {
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
  String? toko;
  String? typeDoc;
  String? noDoc;
  String? jmlSku;
  String? tglRcv;
  String? lspbNo;
  String? tglRcvLspb;
  String? status;
  String? tglExpired;
  String? dateInsert;
  String? userCreated;
  String? dateModify;
  String? userModify;

  Data(
      {this.toko,
      this.typeDoc,
      this.noDoc,
      this.jmlSku,
      this.tglRcv,
      this.lspbNo,
      this.tglRcvLspb,
      this.status,
      this.tglExpired,
      this.dateInsert,
      this.userCreated,
      this.dateModify,
      this.userModify});

  Data.fromJson(Map<String, dynamic> json) {
    toko = json['toko'];
    typeDoc = json['type_doc'];
    noDoc = json['no_doc'];
    jmlSku = json['jml_sku'];
    tglRcv = json['tgl_rcv'];
    lspbNo = json['lspb_no'];
    tglRcvLspb = json['tgl_rcv_lspb'];
    status = json['status'];
    tglExpired = json['tgl_expired'];
    dateInsert = json['date_insert'];
    userCreated = json['user_created'];
    dateModify = json['date_modify'];
    userModify = json['user_modify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['toko'] = this.toko;
    data['type_doc'] = this.typeDoc;
    data['no_doc'] = this.noDoc;
    data['jml_sku'] = this.jmlSku;
    data['tgl_rcv'] = this.tglRcv;
    data['lspb_no'] = this.lspbNo;
    data['tgl_rcv_lspb'] = this.tglRcvLspb;
    data['status'] = this.status;
    data['tgl_expired'] = this.tglExpired;
    data['date_insert'] = this.dateInsert;
    data['user_created'] = this.userCreated;
    data['date_modify'] = this.dateModify;
    data['user_modify'] = this.userModify;
    return data;
  }
}
