// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval_return_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApprovalReturnBody _$ApprovalReturnBodyFromJson(Map<String, dynamic> json) =>
    ApprovalReturnBody(
      tipe: json['tipe'] as String?,
      tanggal: json['tanggal'] as String?,
      store_code: json['store_code'] as String?,
    );

Map<String, dynamic> _$ApprovalReturnBodyToJson(ApprovalReturnBody instance) =>
    <String, dynamic>{
      'tipe': instance.tipe,
      'tanggal': instance.tanggal,
      'store_code': instance.store_code,
    };
