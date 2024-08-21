// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_card_history_month_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyCardHistoryMonthResponse _$CompanyCardHistoryMonthResponseFromJson(
        Map<String, dynamic> json) =>
    CompanyCardHistoryMonthResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CompanyCardHistoryMonthResponseToJson(
        CompanyCardHistoryMonthResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
