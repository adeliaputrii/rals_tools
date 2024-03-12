// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myactivity_update_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyActivityUpdateResponse _$MyActivityUpdateResponseFromJson(
        Map<String, dynamic> json) =>
    MyActivityUpdateResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$MyActivityUpdateResponseToJson(
        MyActivityUpdateResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
