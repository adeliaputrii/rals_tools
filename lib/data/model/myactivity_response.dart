import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'myactivity_response.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake)
class MyActivityResponse {
  int? status;
  String? message;

  MyActivityResponse({this.status, this.message});

  MyActivityResponse.fromJson(Map<String, dynamic> json) {
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