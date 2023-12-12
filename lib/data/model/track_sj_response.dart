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
  String? noSj;
  String? site;
  Null? remark;
  String? description;
  String? status;
  String? date;
  String? pic;

  Data(
      {this.noSj,
      this.site,
      this.remark,
      this.description,
      this.status,
      this.date,
      this.pic});

  Data.fromJson(Map<String, dynamic> json) {
    noSj = json['no_sj'];
    site = json['site'];
    remark = json['remark'];
    description = json['description'];
    status = json['status'];
    date = json['date'];
    pic = json['pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no_sj'] = this.noSj;
    data['site'] = this.site;
    data['remark'] = this.remark;
    data['description'] = this.description;
    data['status'] = this.status;
    data['date'] = this.date;
    data['pic'] = this.pic;
    return data;
  }
}
