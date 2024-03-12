import 'package:json_annotation/json_annotation.dart';

part 'myactivity_update_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MyActivityUpdateBody {
  String? user_create;
  String? time_start;
  String? time_end;
  String? task_id;
  String? projek_id;
  String? task_tech_status;
  String? myactivity_desc;
  String? myactivity_id;
  String? dokumen;
  String? date_create;

  MyActivityUpdateBody({this.user_create, this.time_start, this.time_end, this.task_id, this.projek_id, this.myactivity_desc, this.dokumen, this.date_create, required String task_tech_status, required this.myactivity_id});

  MyActivityUpdateBody.fromJson(Map<String, dynamic> json) {
    user_create = json['user_create'];
    time_start = json['time_start'];
    time_end = json['time_end'];
    task_id = json['task_id'];
    projek_id = json['projek_id'];
    task_tech_status = json['task_tech_status'];
    myactivity_desc = json['myactivity_desc'];
    myactivity_id = json['myactivity_id'];
    dokumen = json['dokumen'];
    date_create = json['date_create'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_create'] = this.user_create;
    data['time_start'] = this.time_start;
    data['time_end'] = this.time_end;
    data['task_id'] = this.task_id;
    data['projek_id'] = this.projek_id;
    data['myactivity_desc'] = this.myactivity_desc;
    data['task_tech_status'] = this.task_tech_status;
    data['myactivity_id'] = this.myactivity_id;
    data['dokumen'] = this.dokumen;
    data['date_create'] = this.date_create;
    return data;
  }
}