import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'myactivity_edit_response.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake)
class MyActivityEditResponse {
  int? status;
  String? message;
  List<Data>? data;

  MyActivityEditResponse({this.status, this.message, this.data});

  MyActivityEditResponse.fromJson(Map<String, dynamic> json) {
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
  String? userModify;
  String? userCreate;
  String? timeStart;
  String? timeEnd;
  String? taskId;
  String? projekId;
  String? myactivityStatus;
  int? myactivityId;
  String? myactivityDesc;
  String? dateModify;
  String? dateCreate;
  List<Attachments>? attachments;

  Data(
      {this.userModify,
      this.userCreate,
      this.timeStart,
      this.timeEnd,
      this.taskId,
      this.projekId,
      this.myactivityStatus,
      this.myactivityId,
      this.myactivityDesc,
      this.dateModify,
      this.dateCreate,
      this.attachments});

  Data.fromJson(Map<String, dynamic> json) {
    userModify = json['user_modify'];
    userCreate = json['user_create'];
    timeStart = json['time_start'];
    timeEnd = json['time_end'];
    taskId = json['task_id'];
    projekId = json['projek_id'];
    myactivityStatus = json['myactivity_status'];
    myactivityId = json['myactivity_id'];
    myactivityDesc = json['myactivity_desc'];
    dateModify = json['date_modify'];
    dateCreate = json['date_create'];
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(new Attachments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_modify'] = this.userModify;
    data['user_create'] = this.userCreate;
    data['time_start'] = this.timeStart;
    data['time_end'] = this.timeEnd;
    data['task_id'] = this.taskId;
    data['projek_id'] = this.projekId;
    data['myactivity_status'] = this.myactivityStatus;
    data['myactivity_id'] = this.myactivityId;
    data['myactivity_desc'] = this.myactivityDesc;
    data['date_modify'] = this.dateModify;
    data['date_create'] = this.dateCreate;
    if (this.attachments != null) {
      data['attachments'] = this.attachments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attachments {
  int? id;
  int? activityId;
  String? attachment;

  Attachments({this.id, this.activityId, this.attachment});

  Attachments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    activityId = json['activity_id'];
    attachment = json['attachment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['activity_id'] = this.activityId;
    data['attachment'] = this.attachment;
    return data;
  }
}
