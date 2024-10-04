// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lspb_type_doc_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LspbTypeDocResponse _$LspbTypeDocResponseFromJson(Map<String, dynamic> json) =>
    LspbTypeDocResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LspbTypeDocResponseToJson(
        LspbTypeDocResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
