// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lspb_form_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LspbFormResponse _$LspbFormResponseFromJson(Map<String, dynamic> json) =>
    LspbFormResponse(
      status: json['status'] as int?,
      message: json['message'],
    );

Map<String, dynamic> _$LspbFormResponseToJson(LspbFormResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
