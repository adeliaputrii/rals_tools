import 'package:json_annotation/json_annotation.dart';

part 'myactivity_edit_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MyActivityEditBody {
     String? userModify;
     String? userCreate;
     String? timeStart;
     String? timeEnd;
     String? taskId;
     String? projekId;
     String? myactivityStatus;
     int? myactivityId;
     String? myactivityDesc;
     dynamic? dokumen;
     String? dateModify;
     String? dateCreate;

    MyActivityEditBody({
          this.userModify,
          this.userCreate,
          this.timeStart,
          this.timeEnd,
          this.taskId,
          this.projekId,
          this.myactivityStatus,
          this.myactivityId,
          this.myactivityDesc,
          this.dokumen,
          this.dateModify,
          this.dateCreate,
    });

     MyActivityEditBody.fromJson(Map<String, dynamic> json) {
        userModify: json["user_modify"];
        userCreate: json["user_create"];
        timeStart: json["time_start"];
        timeEnd: json["time_end"];
        taskId: json["task_id"];
        projekId: json["projek_id"];
        myactivityStatus: json["myactivity_status"];
        myactivityId: json["myactivity_id"];
        myactivityDesc: json["myactivity_desc"];
        dokumen: json["dokumen"];
        dateModify: json["date_modify"];
        dateCreate: json["date_create"];
  }

   Map<String, dynamic> toJson() {
     Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_modify'] = this.userModify;
    data['user_create'] = this.userCreate;
    data['time_start'] = this.timeStart;
    data['time_end'] = this.timeEnd;
    data['task_id'] = this.taskId;
    data['projek_id'] = this.projekId;
    data['myactivity_status'] = this.myactivityStatus;
    data['myactivity_id'] = this.myactivityStatus;
    data['dokumen'] = this.dokumen;
    data['date_modify'] = this.dateModify;
    data['date_create'] = this.dateCreate;
    return data;
  }

}