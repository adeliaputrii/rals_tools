// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_task_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTaskResponse _$GetTaskResponseFromJson(Map<String, dynamic> json) =>
    GetTaskResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetTaskResponseToJson(GetTaskResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      taskId: json['task_id'] as String?,
      taskDesc: json['task_desc'] as String?,
      taskStatus: json['task_status'] as String?,
      projectId: json['project_id'] as String?,
      inCharge: json['in_charge'] as String?,
      loc: json['loc'] as String?,
      taskStart: json['task_start'] as String?,
      taskClose: json['task_close'] as String?,
      dateCreate: json['date_create'] as String?,
      userCreate: json['user_create'] as String?,
      dateModify: json['date_modify'] as String?,
      userModify: json['user_modify'] as String?,
      taskTechStatus: json['task_tech_status'] as String?,
      noteClose: json['note_close'] as String?,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'task_id': instance.taskId,
      'task_desc': instance.taskDesc,
      'task_status': instance.taskStatus,
      'project_id': instance.projectId,
      'in_charge': instance.inCharge,
      'loc': instance.loc,
      'task_start': instance.taskStart,
      'task_close': instance.taskClose,
      'date_create': instance.dateCreate,
      'user_create': instance.userCreate,
      'date_modify': instance.dateModify,
      'user_modify': instance.userModify,
      'task_tech_status': instance.taskTechStatus,
      'note_close': instance.noteClose,
      'note': instance.note,
    };
