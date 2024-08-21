// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myactvitity_project_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProjectResponse _$GetProjectResponseFromJson(Map<String, dynamic> json) =>
    GetProjectResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetProjectResponseToJson(GetProjectResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      projectId: json['project_id'] as String?,
      projectDesc: json['project_desc'] as String?,
      projectStatus: json['project_status'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'project_id': instance.projectId,
      'project_desc': instance.projectDesc,
      'project_status': instance.projectStatus,
    };
