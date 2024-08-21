import 'package:json_annotation/json_annotation.dart';

part 'scan_sj_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ScanSJResponse {
  int? status;
  String? message;

  ScanSJResponse({this.status, this.message});

  ScanSJResponse.fromJson(Map<String, dynamic> json) {
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
