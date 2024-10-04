// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myactivity_update_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyActivityUpdateBody _$MyActivityUpdateBodyFromJson(
        Map<String, dynamic> json) =>
    MyActivityUpdateBody(
      userCreate: json['user_create'] as String?,
      timeStart: json['time_start'] as String?,
      timeEnd: json['time_end'] as String?,
      taskId: json['task_id'] as String?,
      projekId: json['projek_id'] as String?,
      taskTechStatus: json['task_tech_status'] as String?,
      myactivityDesc: json['myactivity_desc'] as String?,
      myactivity_id: json['myactivity_id'] as String?,
      dokumen: (json['dokumen'] as List<dynamic>?)
          ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
          .toList(),
      dateCreate: json['date_create'] as String?,
    );

Map<String, dynamic> _$MyActivityUpdateBodyToJson(
        MyActivityUpdateBody instance) =>
    <String, dynamic>{
      'user_create': instance.userCreate,
      'time_start': instance.timeStart,
      'time_end': instance.timeEnd,
      'task_id': instance.taskId,
      'projek_id': instance.projekId,
      'task_tech_status': instance.taskTechStatus,
      'myactivity_desc': instance.myactivityDesc,
      'myactivity_id': instance.myactivity_id,
      'dokumen': instance.dokumen,
      'date_create': instance.dateCreate,
    };
