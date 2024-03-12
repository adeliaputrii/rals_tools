// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myactivity_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyActivityBody _$MyActivityBodyFromJson(Map<String, dynamic> json) =>
    MyActivityBody(
      user_create: json['user_create'] as String?,
      time_start: json['time_start'] as String?,
      time_end: json['time_end'] as String?,
      task_id: json['task_id'] as String?,
      projek_id: json['projek_id'] as String?,
      myactivity_desc: json['myactivity_desc'] as String?,
      dokumen: json['dokumen'] as String?,
      date_create: json['date_create'] as String?,
      myactivity_status: json['myactivity_status'] as String,
    );

Map<String, dynamic> _$MyActivityBodyToJson(MyActivityBody instance) =>
    <String, dynamic>{
      'user_create': instance.user_create,
      'time_start': instance.time_start,
      'time_end': instance.time_end,
      'task_id': instance.task_id,
      'projek_id': instance.projek_id,
      'myactivity_status': instance.myactivity_status,
      'myactivity_desc': instance.myactivity_desc,
      'dokumen': instance.dokumen,
      'date_create': instance.date_create,
    };
