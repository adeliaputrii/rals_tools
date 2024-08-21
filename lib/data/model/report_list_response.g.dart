// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportListResponse _$ReportListResponseFromJson(Map<String, dynamic> json) =>
    ReportListResponse(
      header1: json['header1'] as String?,
      header2: json['header2'] as String?,
      tipe: json['tipe'] as String?,
      properties: json['properties'] as String?,
      createDate: json['create_date'] as String?,
    );

Map<String, dynamic> _$ReportListResponseToJson(ReportListResponse instance) =>
    <String, dynamic>{
      'header1': instance.header1,
      'header2': instance.header2,
      'tipe': instance.tipe,
      'properties': instance.properties,
      'create_date': instance.createDate,
    };
