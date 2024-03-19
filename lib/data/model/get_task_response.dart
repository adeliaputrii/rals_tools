import 'package:json_annotation/json_annotation.dart';

part 'get_task_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GetTaskResponse {
  int? status;
  String? message;
  List<Data>? data;

  GetTaskResponse({this.status, this.message, this.data});

  GetTaskResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != String) {
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
    if (this.data != String) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Data {
  String? taskId;
  String? taskDesc;
  String? taskStatus;
  String? projectId;
  String? inCharge;
  String? loc;
  String? taskStart;
  String? taskClose;
  String? dateCreate;
  String? userCreate;
  String? dateModify;
  String? userModify;
  String? taskTechStatus;
  String? noteClose;
  String? note;

  Data(
      {this.taskId,
      this.taskDesc,
      this.taskStatus,
      this.projectId,
      this.inCharge,
      this.loc,
      this.taskStart,
      this.taskClose,
      this.dateCreate,
      this.userCreate,
      this.dateModify,
      this.userModify,
      this.taskTechStatus,
      this.noteClose,
      this.note});

  Data.fromJson(Map<String, dynamic> json) {
    taskId = json['task_id'];
    taskDesc = json['task_desc'];
    taskStatus = json['task_status'];
    projectId = json['project_id'];
    inCharge = json['in_charge'];
    loc = json['loc'];
    taskStart = json['task_start'];
    taskClose = json['task_close'];
    dateCreate = json['date_create'];
    userCreate = json['user_create'];
    dateModify = json['date_modify'];
    userModify = json['user_modify'];
    taskTechStatus = json['task_tech_status'];
    noteClose = json['note_close'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task_id'] = this.taskId;
    data['task_desc'] = this.taskDesc;
    data['task_status'] = this.taskStatus;
    data['project_id'] = this.projectId;
    data['in_charge'] = this.inCharge;
    data['loc'] = this.loc;
    data['task_start'] = this.taskStart;
    data['task_close'] = this.taskClose;
    data['date_create'] = this.dateCreate;
    data['user_create'] = this.userCreate;
    data['date_modify'] = this.dateModify;
    data['user_modify'] = this.userModify;
    data['task_tech_status'] = this.taskTechStatus;
    data['note_close'] = this.noteClose;
    data['note'] = this.note;
    return data;
  }

  void forEach(Null Function(dynamic element) param0) {}
}
