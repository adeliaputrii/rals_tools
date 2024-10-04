import 'package:json_annotation/json_annotation.dart';

part 'myactivity_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MyActivityBody {
  String? userCreate;
  String? timeStart;
  String? timeEnd;
  String? taskId;
  String? projekId;
  String? taskTechStatus;
  String? myactivityDesc;
  List<Dokumen>? dokumen;
  String? dateCreate;

  MyActivityBody(
      {this.userCreate,
      this.timeStart,
      this.timeEnd,
      this.taskId,
      this.projekId,
      this.taskTechStatus,
      this.myactivityDesc,
      this.dokumen,
      this.dateCreate,});

  MyActivityBody.fromJson(Map<String, dynamic> json) {
    userCreate = json['user_create'];
    timeStart = json['time_start'];
    timeEnd = json['time_end'];
    taskId = json['task_id'];
    projekId = json['projek_id'];
    taskTechStatus = json['task_tech_status'];
    myactivityDesc = json['myactivity_desc'];
    if (json['dokumen'] != null) {
      dokumen = <Dokumen>[];
      json['dokumen'].forEach((v) {
        dokumen!.add(new Dokumen.fromJson(v));
      });
    }
    dateCreate = json['date_create'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_create'] = this.userCreate;
    data['time_start'] = this.timeStart;
    data['time_end'] = this.timeEnd;
    data['task_id'] = this.taskId;
    data['projek_id'] = this.projekId;
    data['task_tech_status'] = this.taskTechStatus;
    data['myactivity_desc'] = this.myactivityDesc;
    if (this.dokumen != null) {
      data['dokumen'] = this.dokumen!.map((v) => v.toJson()).toList();
    }
    data['date_create'] = this.dateCreate;
    return data;
  }
}

class Dokumen {
  String? filename;
  String? base64;

  Dokumen({this.filename, this.base64});

  Dokumen.fromJson(Map<String, dynamic> json) {
    filename = json['filename'];
    base64 = json['base64'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filename'] = this.filename;
    data['base64'] = this.base64;
    return data;
  }
}