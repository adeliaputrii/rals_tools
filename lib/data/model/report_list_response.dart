import 'package:json_annotation/json_annotation.dart';

part 'report_list_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ReportListResponse {
  String? header1;
  String? header2;
  String? tipe;
  String? properties;
  String? createDate;

  ReportListResponse({this.header1, this.header2, this.tipe, this.properties, this.createDate});

  ReportListResponse.fromJson(Map<String, dynamic> json) {
    header1 = json['header1'];
    header2 = json['header2'];
    tipe = json['tipe'];
    properties = json['properties'];
    createDate = json['create_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['header1'] = this.header1;
    data['header2'] = this.header2;
    data['tipe'] = this.tipe;
    data['properties'] = this.properties;
    data['create_date'] = this.createDate;
    return data;
  }
}
