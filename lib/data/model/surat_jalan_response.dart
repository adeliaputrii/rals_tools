import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'surat_jalan_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SuratJalanResponse {
  int? status;
  String? message;
  Data? data;

  SuratJalanResponse({this.status, this.message, this.data});

  SuratJalanResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Data {
  TrackingStatus? trackingStatus;
  Button? button;

  Data({this.trackingStatus, this.button});

  Data.fromJson(Map<String, dynamic> json) {
    trackingStatus = json['tracking_status'] != null
        ? new TrackingStatus.fromJson(json['tracking_status'])
        : null;
    button =
        json['button'] != null ? new Button.fromJson(json['button']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.trackingStatus != null) {
      data['tracking_status'] = this.trackingStatus!.toJson();
    }
    if (this.button != null) {
      data['button'] = this.button!.toJson();
    }
    return data;
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class TrackingStatus {
  String? noSj;
  String? site;
  String? description;
  String? createdDate;
  String? statusBarang;

  TrackingStatus(
      {this.noSj,
      this.site,
      this.description,
      this.createdDate,
      this.statusBarang});

  TrackingStatus.fromJson(Map<String, dynamic> json) {
    noSj = json['no_sj'];
    site = json['site'];
    description = json['description'];
    createdDate = json['created_date'];
    statusBarang = json['status_barang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no_sj'] = this.noSj;
    data['site'] = this.site;
    data['description'] = this.description;
    data['created_date'] = this.createdDate;
    data['status_barang'] = this.statusBarang;
    return data;
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Button {
  bool? receivedBySupplier;
  bool? regular;
  bool? storeline;

  Button({this.receivedBySupplier, this.regular, this.storeline});

  Button.fromJson(Map<String, dynamic> json) {
    receivedBySupplier = json['received_by_supplier'];
    regular = json['default'];
    storeline = json['storeline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['received_by_supplier'] = this.receivedBySupplier;
    data['regular'] = this.regular;
    data['storeline'] = this.storeline;
    return data;
  }
}
