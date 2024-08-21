// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_card_history_year_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyCardHistoryYearResponse _$CompanyCardHistoryYearResponseFromJson(
        Map<String, dynamic> json) =>
    CompanyCardHistoryYearResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CompanyCardHistoryYearResponseToJson(
        CompanyCardHistoryYearResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
