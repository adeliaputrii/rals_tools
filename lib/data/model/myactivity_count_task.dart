import 'package:json_annotation/json_annotation.dart';
part 'myactivity_count_task.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CountTask {
  int? status;
  String? message;
  Data? data;

  CountTask({this.status, this.message, this.data});

  CountTask.fromJson(Map<String, dynamic> json) {
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
  int? unreadTask;
  int? totalTask;

  Data({this.unreadTask, this.totalTask});

  Data.fromJson(Map<String, dynamic> json) {
    unreadTask = json['unread_task'];
    totalTask = json['total_task'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unread_task'] = this.unreadTask;
    data['total_task'] = this.totalTask;
    return data;
  }
}
