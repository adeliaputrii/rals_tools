import 'package:json_annotation/json_annotation.dart';

part 'stock_opname_submit_reponse.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)

class StockOpnameSubmitResponse {
  int? status;
  String? message;

  StockOpnameSubmitResponse({this.status, this.message});

  StockOpnameSubmitResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}