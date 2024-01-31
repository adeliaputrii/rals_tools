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
          ?.map((e) => DataHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CompanyCardHistoryResponseToJson(
        CompanyCardHistoryResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

DataHistory _$DataHistoryFromJson(Map<String, dynamic> json) => DataHistory(
      tanggal: json['tanggal'] as String?,
      toko: json['toko'] as String?,
      nokartu: json['nokartu'] as String?,
      nostruk: json['nostruk'] as String?,
      nocp: json['nocp'] as String?,
      nilai: json['nilai'] as String?,
      status: json['status'] as String?,
      kasir: json['kasir'] as String?,
    );

Map<String, dynamic> _$DataHistoryToJson(DataHistory instance) =>
    <String, dynamic>{
      'tanggal': instance.tanggal,
      'toko': instance.toko,
      'nokartu': instance.nokartu,
      'nostruk': instance.nostruk,
      'nocp': instance.nocp,
      'nilai': instance.nilai,
      'status': instance.status,
      'kasir': instance.kasir,
    };
