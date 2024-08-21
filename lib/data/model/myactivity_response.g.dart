// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myactivity_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyActivityResponse _$MyActivityResponseFromJson(Map<String, dynamic> json) =>
    MyActivityResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$MyActivityResponseToJson(MyActivityResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
