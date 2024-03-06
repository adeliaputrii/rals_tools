// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myactivity_edit_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyActivityEditBody _$MyActivityEditBodyFromJson(Map<String, dynamic> json) =>
    MyActivityEditBody(
      userModify: json['user_modify'] as String?,
      userCreate: json['user_create'] as String?,
      timeStart: json['time_start'] as String?,
      timeEnd: json['time_end'] as String?,
      taskId: json['task_id'] as String?,
      projekId: json['projek_id'] as String?,
      myactivityStatus: json['myactivity_status'] as String?,
      myactivityId: json['myactivity_id'] as int?,
      myactivityDesc: json['myactivity_desc'] as String?,
      dokumen: json['dokumen'],
      dateModify: json['date_modify'] as String?,
      dateCreate: json['date_create'] as String?,
    );

Map<String, dynamic> _$MyActivityEditBodyToJson(MyActivityEditBody instance) =>
    <String, dynamic>{
      'user_modify': instance.userModify,
      'user_create': instance.userCreate,
      'time_start': instance.timeStart,
      'time_end': instance.timeEnd,
      'task_id': instance.taskId,
      'projek_id': instance.projekId,
      'myactivity_status': instance.myactivityStatus,
      'myactivity_id': instance.myactivityId,
      'myactivity_desc': instance.myactivityDesc,
      'dokumen': instance.dokumen,
      'date_modify': instance.dateModify,
      'date_create': instance.dateCreate,
    };
