import 'package:json_annotation/json_annotation.dart';

part 'myactivity_task_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MyActivityTaskResponse {
  int? status;
  String? message;
  List<Data>? data;

  MyActivityTaskResponse({this.status, this.message, this.data});

  MyActivityTaskResponse.fromJson(Map<String, dynamic> json) {
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
  String? taskId;
  String? taskDesc;
  String? note;
  String? taskStatus;

  Data({this.taskId, this.taskDesc, this.note, this.taskStatus});

  Data.fromJson(Map<String, dynamic> json) {
    taskId = json['task_id'];
    taskDesc = json['task_desc'];
    note = json['note'];
    taskStatus = json['task_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task_id'] = this.taskId;
    data['task_desc'] = this.taskDesc;
    data['note'] = this.note;
    data['task_status'] = this.taskStatus;
    return data;
  }
}
