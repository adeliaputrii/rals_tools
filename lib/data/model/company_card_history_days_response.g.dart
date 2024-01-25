// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_card_history_days_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyCardHistoryDaysResponse _$CompanyCardHistoryDaysResponseFromJson(
        Map<String, dynamic> json) =>
    CompanyCardHistoryDaysResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CompanyCardHistoryDaysResponseToJson(
        CompanyCardHistoryDaysResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
