// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lspb_form_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LspbFormBody _$LspbFormBodyFromJson(Map<String, dynamic> json) => LspbFormBody(
      scan_dokumen: json['scan_dokumen'] as String?,
      user: json['user'] as String?,
      store: json['store'] as String?,
      error_qty: json['error_qty'] as String?,
    );

Map<String, dynamic> _$LspbFormBodyToJson(LspbFormBody instance) =>
    <String, dynamic>{
      'scan_dokumen': instance.scan_dokumen,
      'user': instance.user,
      'store': instance.store,
      'error_qty': instance.error_qty,
    };
