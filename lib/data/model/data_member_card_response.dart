import 'package:json_annotation/json_annotation.dart';

part 'data_member_card_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DataMemberCardResponse {
  int? status;
  String? message;
  List<Data>? data;

  DataMemberCardResponse({this.status, this.message, this.data});

  DataMemberCardResponse.fromJson(Map<String, dynamic> json) {
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

@JsonSerializable(fieldRename: FieldRename.snake)
class Data {
  String? nokartu;
  String? nama;
  String? nohp;
  String? email;
  String? saldo;
  int? saldoPemakaian;

  Data(
      {this.nokartu,
      this.nama,
      this.nohp,
      this.email,
      this.saldo,
      this.saldoPemakaian});

  Data.fromJson(Map<String, dynamic> json) {
    nokartu = json['nokartu'];
    nama = json['nama'];
    nohp = json['nohp'];
    email = json['email'];
    saldo = json['saldo'];
    saldoPemakaian = json['saldo_pemakaian'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nokartu'] = this.nokartu;
    data['nama'] = this.nama;
    data['nohp'] = this.nohp;
    data['email'] = this.email;
    data['saldo'] = this.saldo;
    data['saldo_pemakaian'] = this.saldoPemakaian;
    return data;
  }
}
