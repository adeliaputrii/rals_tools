import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'track_sj_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TrackingSJResponse {
  int? status;
  String? message;
  List<Data>? data;

  TrackingSJResponse({this.status, this.message, this.data});

  TrackingSJResponse.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? noSj;
  String? site;
  String? remark;
  String? description;
  String? status;
  String? date;
  String? pic;
  int? rcvKoli;
  int? actualKoli;
  String? missingKoli;
  int? lspb;

  Data(
      {this.id,
      this.noSj,
      this.site,
      this.remark,
      this.description,
      this.status,
      this.date,
      this.pic,
      this.rcvKoli,
      this.actualKoli,
      this.missingKoli,
      this.lspb});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    noSj = json['no_sj'];
    site = json['site'];
    remark = json['remark'];
    description = json['description'];
    status = json['status'];
    date = json['date'];
    pic = json['pic'];
    rcvKoli = json['rcv_koli'];
    actualKoli = json['actual_koli'];
    missingKoli = json['missing_koli'];
    lspb = json['lspb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['no_sj'] = this.noSj;
    data['site'] = this.site;
    data['remark'] = this.remark;
    data['description'] = this.description;
    data['status'] = this.status;
    data['date'] = this.date;
    data['pic'] = this.pic;
    data['rcv_koli'] = this.rcvKoli;
    data['actual_koli'] = this.actualKoli;
    data['missing_koli'] = this.missingKoli;
    data['lspb'] = this.lspb;
    return data;
  }
}
