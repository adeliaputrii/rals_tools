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
  DetailSj? detailSj;
  Button? button;

  Data({this.detailSj, this.button});

  Data.fromJson(Map<String, dynamic> json) {
    detailSj = json['detail_sj'] != null
        ? new DetailSj.fromJson(json['detail_sj'])
        : null;
    button =
        json['button'] != null ? new Button.fromJson(json['button']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.detailSj != null) {
      data['detail_sj'] = this.detailSj!.toJson();
    }
    if (this.button != null) {
      data['button'] = this.button!.toJson();
    }
    return data;
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class DetailSj {
  String? noSj;
  String? destination;
  String? documentType;
  String? noVehicle;
  String? driverName;
  String? origin;
  String? trackingStatus;

  DetailSj(
      {this.noSj,
      this.destination,
      this.documentType,
      this.noVehicle,
      this.driverName,
      this.origin,
      this.trackingStatus});

  DetailSj.fromJson(Map<String, dynamic> json) {
    noSj = json['no_sj'];
    destination = json['destination'];
    documentType = json['document_type'];
    noVehicle = json['no_vehicle'];
    driverName = json['driver_name'];
    origin = json['origin'];
    trackingStatus = json['tracking_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no_sj'] = this.noSj;
    data['destination'] = this.destination;
    data['document_type'] = this.documentType;
    data['no_vehicle'] = this.noVehicle;
    data['driver_name'] = this.driverName;
    data['origin'] = this.origin;
    data['tracking_status'] = this.trackingStatus;
    return data;
  }
}

class Button {
  bool? receivedBySupplier;
  bool? regular;
  bool? storeline;

  Button({this.receivedBySupplier, this.regular, this.storeline});

  Button.fromJson(Map<String, dynamic> json) {
    receivedBySupplier = json['received_by_supplier'];
    regular = json['regular'];
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
