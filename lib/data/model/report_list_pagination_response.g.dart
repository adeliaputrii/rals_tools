// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_list_pagination_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportListPaginationResponse _$ReportListPaginationResponseFromJson(
        Map<String, dynamic> json) =>
    ReportListPaginationResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
      path: json['path'] as String?,
      perPage: json['per_page'] as int?,
      nextPageUrl: json['next_page_url'] as String?,
      prevPageUrl: json['prev_page_url'] as String?,
    );

Map<String, dynamic> _$ReportListPaginationResponseToJson(
        ReportListPaginationResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'path': instance.path,
      'per_page': instance.perPage,
      'next_page_url': instance.nextPageUrl,
      'prev_page_url': instance.prevPageUrl,
    };
