// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myactivity_task_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyActivityTaskResponse _$MyActivityTaskResponseFromJson(
        Map<String, dynamic> json) =>
    MyActivityTaskResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MyActivityTaskResponseToJson(
        MyActivityTaskResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
