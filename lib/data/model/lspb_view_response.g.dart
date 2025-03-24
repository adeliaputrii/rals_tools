// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lspb_view_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LspbViewRequestResponse _$LspbViewRequestResponseFromJson(
        Map<String, dynamic> json) =>
    LspbViewRequestResponse(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LspbViewRequestResponseToJson(
        LspbViewRequestResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
