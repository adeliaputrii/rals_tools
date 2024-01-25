// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_card_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyCardHistoryResponse _$CompanyCardHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    CompanyCardHistoryResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CompanyCardHistoryResponseToJson(
        CompanyCardHistoryResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
