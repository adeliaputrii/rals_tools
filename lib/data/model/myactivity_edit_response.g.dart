// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myactivity_edit_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyActivityEditResponse _$MyActivityEditResponseFromJson(
        Map<String, dynamic> json) =>
    MyActivityEditResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MyActivityEditResponseToJson(
        MyActivityEditResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
