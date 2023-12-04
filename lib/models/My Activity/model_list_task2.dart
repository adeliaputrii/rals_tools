import 'package:flutter/cupertino.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';

class TaskHome2 {
  TaskHome2(
      {required this.task_id,
      required this.task_desc,
      required this.task_status,
      required this.project_id,
      required this.in_charge,
      required this.loc,
      required this.task_start,
      required this.task_close,
      required this.date_create,
      required this.user_create,
      required this.date_modify,
      required this.user_modify,
      required this.task_tech_status});

  var task_id,
      task_desc,
      task_status,
      project_id,
      in_charge,
      loc,
      task_start,
      task_close,
      date_create,
      user_create,
      date_modify,
      user_modify,
      task_tech_status;

  factory TaskHome2.fromjson(
    Map<String, dynamic> json1,
  ) =>
      TaskHome2(
        task_id: json1["task_id"],
        task_desc: json1["task_desc"],
        task_status: json1["task_status"],
        project_id: json1["project_id"],
        in_charge: json1["in_charge"],
        loc: json1["loc"],
        task_start: json1["task_start"],
        task_close: json1["task_close"],
        date_create: json1["date_create"],
        user_create: json1["user_create"],
        date_modify: json1["date_modify"],
        user_modify: json1["user_modify"],
        task_tech_status: json1["task_tech_status"],
      );

  static List<TaskHome2> taskhome2 = [];
}
