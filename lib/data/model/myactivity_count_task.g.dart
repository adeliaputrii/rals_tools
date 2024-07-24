// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myactivity_count_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountTask _$CountTaskFromJson(Map<String, dynamic> json) => CountTask(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CountTaskToJson(CountTask instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
