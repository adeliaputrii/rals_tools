import 'package:json_annotation/json_annotation.dart';

part 'company_card_history_year_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CompanyCardHistoryYearResponse {
  int? status;
  String? message;
  List<Data>? data;

  CompanyCardHistoryYearResponse({this.status, this.message, this.data});

  CompanyCardHistoryYearResponse.fromJson(Map<String, dynamic> json) {
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
  String? totalHarga;
  String? datePart;

  Data({this.nokartu, this.totalHarga, this.datePart});

  Data.fromJson(Map<String, dynamic> json) {
    nokartu = json['nokartu'];
    totalHarga = json['total_harga'];
    datePart = json['date_part'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nokartu'] = this.nokartu;
    data['total_harga'] = this.totalHarga;
    data['date_part'] = this.datePart;
    return data;
  }
}
