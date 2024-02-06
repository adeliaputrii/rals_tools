// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval_return_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApprovalReturnResponse _$ApprovalReturnResponseFromJson(
        Map<String, dynamic> json) =>
    ApprovalReturnResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ApprovalReturnResponseToJson(
        ApprovalReturnResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
