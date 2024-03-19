// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myactivity_update_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyActivityUpdateBody _$MyActivityUpdateBodyFromJson(
        Map<String, dynamic> json) =>
    MyActivityUpdateBody(
      user_create: json['user_create'] as String?,
      time_start: json['time_start'] as String?,
      time_end: json['time_end'] as String?,
      task_id: json['task_id'] as String?,
      projek_id: json['projek_id'] as String?,
      myactivity_desc: json['myactivity_desc'] as String?,
      dokumen: json['dokumen'] as String?,
      date_create: json['date_create'] as String?,
      task_tech_status: json['task_tech_status'] as String?,
      myactivity_id: json['myactivity_id'] as String?,
    );

Map<String, dynamic> _$MyActivityUpdateBodyToJson(
        MyActivityUpdateBody instance) =>
    <String, dynamic>{
      'user_create': instance.user_create,
      'time_start': instance.time_start,
      'time_end': instance.time_end,
      'task_id': instance.task_id,
      'projek_id': instance.projek_id,
      'task_tech_status': instance.task_tech_status,
      'myactivity_desc': instance.myactivity_desc,
      'myactivity_id': instance.myactivity_id,
      'dokumen': instance.dokumen,
      'date_create': instance.date_create,
    };
