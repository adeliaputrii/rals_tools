import 'package:json_annotation/json_annotation.dart';

part 'company_card_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CompanyCardResponse {
  int? status;
  String? message;
  List<DataCompany>? data;

  CompanyCardResponse({this.status, this.message, this.data});

  CompanyCardResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataCompany>[];
      json['data'].forEach((v) {
        data!.add(new DataCompany.fromJson(v));
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
class DataCompany {
  String? nokartu;
  String? nama;
  String? poin;
  int? status;
  String? saldo;
  String? rmyId;
  int? typeMc;
  String? tglinaktif;

  DataCompany(
      {this.nokartu,
      this.nama,
      this.poin,
      this.status,
      this.saldo,
      this.rmyId,
      this.typeMc,
      this.tglinaktif});

  DataCompany.fromJson(Map<String, dynamic> json) {
    nokartu = json['nokartu'];
    nama = json['nama'];
    poin = json['poin'];
    status = json['status'];
    saldo = json['saldo'];
    rmyId = json['rmy_id'];
    typeMc = json['type_mc'];
    tglinaktif = json['tglinaktif'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nokartu'] = this.nokartu;
    data['nama'] = this.nama;
    data['poin'] = this.poin;
    data['status'] = this.status;
    data['saldo'] = this.saldo;
    data['rmy_id'] = this.rmyId;
    data['type_mc'] = this.typeMc;
    data['tglinaktif'] = this.tglinaktif;
    return data;
  }
}
