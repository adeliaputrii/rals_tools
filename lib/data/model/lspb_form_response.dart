import 'package:json_annotation/json_annotation.dart';
part 'lspb_form_response.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake)
class LspbFormResponse {
  int? status;
  dynamic? message;

  LspbFormResponse({this.status, this.message});

  LspbFormResponse.fromJson(Map<String, dynamic> json) {
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