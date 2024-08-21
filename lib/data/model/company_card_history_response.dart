import 'package:json_annotation/json_annotation.dart';

part 'company_card_history_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CompanyCardHistoryResponse {
  int? status;
  String? message;
  List<DataHistory>? data;

  CompanyCardHistoryResponse({this.status, this.message, this.data});

  CompanyCardHistoryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataHistory>[];
      json['data'].forEach((v) {
        data!.add(new DataHistory.fromJson(v));
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

@JsonSerializable(fieldRename: FieldRename.snake)
class DataHistory {
  String? tanggal;
  String? toko;
  String? nokartu;
  String? nostruk;
  String? nocp;
  String? nilai;
  String? status;
  String? kasir;

  DataHistory(
      {this.tanggal,
      this.toko,
      this.nokartu,
      this.nostruk,
      this.nocp,
      this.nilai,
      this.status,
      this.kasir});

  DataHistory.fromJson(Map<String, dynamic> json) {
    tanggal = json['tanggal'];
    toko = json['toko'];
    nokartu = json['nokartu'];
    nostruk = json['nostruk'];
    nocp = json['nocp'];
    nilai = json['nilai'];
    status = json['status'];
    kasir = json['kasir'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tanggal'] = this.tanggal;
    data['toko'] = this.toko;
    data['nokartu'] = this.nokartu;
    data['nostruk'] = this.nostruk;
    data['nocp'] = this.nocp;
    data['nilai'] = this.nilai;
    data['status'] = this.status;
    data['kasir'] = this.kasir;
    return data;
  }
}
