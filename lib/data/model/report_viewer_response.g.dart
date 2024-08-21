// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_viewer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportViewerResponse _$ReportViewerResponseFromJson(
        Map<String, dynamic> json) =>
    ReportViewerResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReportViewerResponseToJson(
        ReportViewerResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
