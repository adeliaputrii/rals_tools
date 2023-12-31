import 'package:json_annotation/json_annotation.dart';

part 'error_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ErrorResponse {
  int? status;
  String? message;

  ErrorResponse({this.status, this.message});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
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
