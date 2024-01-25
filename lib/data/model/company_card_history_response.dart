import 'package:json_annotation/json_annotation.dart';

part 'company_card_history_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CompanyCardHistoryResponse {
  int? status;
  String? message;
  List<Data>? data;

  CompanyCardHistoryResponse({this.status, this.message, this.data});

  CompanyCardHistoryResponse.fromJson(Map<String, dynamic> json) {
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
  String? nokartu;
  String? notrx;
  String? kodetoko;
  String? type;
  String? poin;
  String? kodekasir;
  String? totalHarga;
  String? totalQty;
  String? tanggal;
  String? tglupd;
  String? userupd;
  String? flag;
  String? keterangan;
  Null? ambilhadiah;
  String? createdDate;
  String? createdUser;

  Data(
      {this.nokartu,
      this.notrx,
      this.kodetoko,
      this.type,
      this.poin,
      this.kodekasir,
      this.totalHarga,
      this.totalQty,
      this.tanggal,
      this.tglupd,
      this.userupd,
      this.flag,
      this.keterangan,
      this.ambilhadiah,
      this.createdDate,
      this.createdUser});

  Data.fromJson(Map<String, dynamic> json) {
    nokartu = json['nokartu'];
    notrx = json['notrx'];
    kodetoko = json['kodetoko'];
    type = json['type'];
    poin = json['poin'];
    kodekasir = json['kodekasir'];
    totalHarga = json['total_harga'];
    totalQty = json['total_qty'];
    tanggal = json['tanggal'];
    tglupd = json['tglupd'];
    userupd = json['userupd'];
    flag = json['flag'];
    keterangan = json['keterangan'];
    ambilhadiah = json['ambilhadiah'];
    createdDate = json['created_date'];
    createdUser = json['created_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nokartu'] = this.nokartu;
    data['notrx'] = this.notrx;
    data['kodetoko'] = this.kodetoko;
    data['type'] = this.type;
    data['poin'] = this.poin;
    data['kodekasir'] = this.kodekasir;
    data['total_harga'] = this.totalHarga;
    data['total_qty'] = this.totalQty;
    data['tanggal'] = this.tanggal;
    data['tglupd'] = this.tglupd;
    data['userupd'] = this.userupd;
    data['flag'] = this.flag;
    data['keterangan'] = this.keterangan;
    data['ambilhadiah'] = this.ambilhadiah;
    data['created_date'] = this.createdDate;
    data['created_user'] = this.createdUser;
    return data;
  }
}
