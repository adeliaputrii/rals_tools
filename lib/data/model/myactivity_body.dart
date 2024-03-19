import 'package:file_picker/file_picker.dart';
import 'package:json_annotation/json_annotation.dart';

part 'myactivity_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MyActivityBody {
  String? user_create;
  String? time_start;
  String? time_end;
  String? task_id;
  String? projek_id;
  String? task_tech_status;
  String? myactivity_desc;
  var dokumen;
  String? date_create;

  MyActivityBody({this.user_create, this.time_start, this.time_end, this.task_id, this.projek_id, required this.myactivity_desc, required this.dokumen, this.date_create, required this.task_tech_status});

  MyActivityBody.fromJson(Map<String, dynamic> json) {
    user_create = json['user_create'];
    time_start = json['time_start'];
    time_end = json['time_end'];
    task_id = json['task_id'];
    projek_id = json['projek_id'];
    task_tech_status = json['task_tech_status'];
    myactivity_desc = json['myactivity_desc'];
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
    data['dokumen'] = this.dokumen;
    data['date_create'] = this.date_create;
    return data;
  }

  @override
  String toString() {
    return 'MyActivityBody{'
        'user_create: $user_create, '
        'time_start: $time_start, '
        'time_end: $time_end, '
        'task_id: $task_id, '
        'projek_id: $projek_id, '
        'myactivity_desc: $myactivity_desc, '
        'task_tech_status: $task_tech_status, '
        'dokumen: $dokumen, '
        'date_create: $date_create'
        '}';
  }
}