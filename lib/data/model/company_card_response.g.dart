// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_card_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyCardResponse _$CompanyCardResponseFromJson(Map<String, dynamic> json) =>
    CompanyCardResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DataCompany.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CompanyCardResponseToJson(
        CompanyCardResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
