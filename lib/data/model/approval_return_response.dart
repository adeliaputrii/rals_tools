import 'package:json_annotation/json_annotation.dart';

part 'approval_return_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)

class ApprovalReturnResponse {
  int? status;
  String? message;
  List<Data>? data;

  ApprovalReturnResponse({this.status, this.message, this.data});

  ApprovalReturnResponse.fromJson(Map<String, dynamic> json) {
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
    DateTime? tanggal;
    String? toko;
    String? noTrx;
    String? nocp;
    String? amaount;
    String? status;
    DateTime? dateCr;
    DateTime? dateUpd;
    String? idKasir;
    String? namaKasir;

    Data({
      this.tanggal,
      this.toko,
      this.noTrx,
      this.nocp,
      this.amaount,
      this.status,
      this.dateCr,
      this.dateUpd,
      this.idKasir,
      this.namaKasir,
    });

    Data.fromJson(Map<String, dynamic> json) {
    tanggal = json['tanggal'];
    toko = json['toko'];
    noTrx = json['no_trx'];
    nocp = json['nocp'];
    amaount = json['amaount'];
    status = json['status'];
    dateCr = json['date_cr'];
    dateUpd = json['date_upd'];
    idKasir = json['id_kasir'];
    namaKasir = json['nama_kasir'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tanggal'] = this.tanggal;
    data['toko'] = this.toko;
    data['no_trx'] = this.noTrx;
    data['nocp'] = this.nocp;
    data['amaount'] = this.amaount;
    data['status'] = this.status;
    data['date_cr'] = this.dateCr;
    data['date_upd'] = this.dateUpd;
    data['id_kasir'] = this.idKasir;
    data['nama_kasir'] = this.namaKasir;
    return data;
  }

}