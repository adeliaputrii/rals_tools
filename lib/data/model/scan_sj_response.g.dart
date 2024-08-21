// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_sj_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScanSJResponse _$ScanSJResponseFromJson(Map<String, dynamic> json) =>
    ScanSJResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ScanSJResponseToJson(ScanSJResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
