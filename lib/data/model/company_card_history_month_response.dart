import 'package:json_annotation/json_annotation.dart';

part 'company_card_history_month_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CompanyCardHistoryMonthResponse {
  int? status;
  String? message;
  List<Data>? data;

  CompanyCardHistoryMonthResponse({this.status, this.message, this.data});

  CompanyCardHistoryMonthResponse.fromJson(Map<String, dynamic> json) {
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
  String? month;

  Data({this.nokartu, this.totalHarga, this.month});

  Data.fromJson(Map<String, dynamic> json) {
    nokartu = json['nokartu'];
    totalHarga = json['total_harga'];
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nokartu'] = this.nokartu;
    data['total_harga'] = this.totalHarga;
    data['month'] = this.month;
    return data;
  }
}
