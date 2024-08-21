import 'package:json_annotation/json_annotation.dart';

part 'stock_opname_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)

class StockOpnameResponse {
  int? status;
  String? message;
  List<Data>? data;

  StockOpnameResponse({this.status, this.message, this.data});

  StockOpnameResponse.fromJson(Map<String, dynamic> json) {
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
  String? pos;
  String? lokasi;
  String? tanggal;

  Data({this.pos, this.lokasi, this.tanggal});

  Data.fromJson(Map<String, dynamic> json) {
    pos = json['pos'];
    lokasi = json['lokasi'];
    tanggal = json['tanggal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pos'] = this.pos;
    data['lokasi'] = this.lokasi;
    data['tanggal'] = this.tanggal;
    return data;
  }
}