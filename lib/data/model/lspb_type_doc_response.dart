import 'package:json_annotation/json_annotation.dart';
part 'lspb_type_doc_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LspbTypeDocResponse {
  int? status;
  String? message;
  Data? data;

  LspbTypeDocResponse({this.status, this.message, this.data});

  LspbTypeDocResponse.fromJson(Map<String, dynamic> json) {
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

class Data {
  List<DataGoldDn>? dataGoldDn;
  List<User>? userData;

  Data({this.dataGoldDn, this.userData});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['dataGoldDn'] != null) {
      dataGoldDn = <DataGoldDn>[];
      json['dataGoldDn'].forEach((v) {
        dataGoldDn!.add(new DataGoldDn.fromJson(v));
      });
    }
    if (json['userData'] != null) {
      userData = <User>[];
      json['userData'].forEach((v) {
        userData!.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dataGoldDn != null) {
      data['dataGoldDn'] = this.dataGoldDn!.map((v) => v.toJson()).toList();
    }
    if (this.userData != null) {
      data['userData'] = this.userData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataGoldDn {
  String? site;
  String? tujuan;
  String? noDokumen;
  String? tanggal;
  String? tipe;
  String? lastProcess;

  DataGoldDn(
      {this.site,
      this.tujuan,
      this.noDokumen,
      this.tanggal,
      this.tipe,
      this.lastProcess});

  DataGoldDn.fromJson(Map<String, dynamic> json) {
    site = json['site'];
    tujuan = json['tujuan'];
    noDokumen = json['no_dokumen'];
    tanggal = json['tanggal'];
    tipe = json['tipe'];
    lastProcess = json['last_process'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['site'] = this.site;
    data['tujuan'] = this.tujuan;
    data['no_dokumen'] = this.noDokumen;
    data['tanggal'] = this.tanggal;
    data['tipe'] = this.tipe;
    data['last_process'] = this.lastProcess;
    return data;
  }
}

class User {
  String? sitecode;
  String? rolloutDate;
  String? marisStore;

  User({this.sitecode, this.rolloutDate, this.marisStore});

  User.fromJson(Map<String, dynamic> json) {
    sitecode = json['sitecode'];
    rolloutDate = json['rollout_date'];
    marisStore = json['maris_store'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sitecode'] = this.sitecode;
    data['rollout_date'] = this.rolloutDate;
    data['maris_store'] = this.marisStore;
    return data;
  }
}
