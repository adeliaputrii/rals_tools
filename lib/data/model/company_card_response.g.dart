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

DataCompany _$DataFromJson(Map<String, dynamic> json) => DataCompany(
      nokartu: json['nokartu'] as String?,
      nama: json['nama'] as String?,
      poin: json['poin'] as String?,
      status: json['status'] as int?,
      saldo: json['saldo'] as String?,
      rmyId: json['rmy_id'] as String?,
      typeMc: json['type_mc'] as int?,
      tglinaktif: json['tglinaktif'] as String?,
    );

Map<String, dynamic> _$DataToJson(DataCompany instance) => <String, dynamic>{
      'nokartu': instance.nokartu,
      'nama': instance.nama,
      'poin': instance.poin,
      'status': instance.status,
      'saldo': instance.saldo,
      'rmy_id': instance.rmyId,
      'type_mc': instance.typeMc,
      'tglinaktif': instance.tglinaktif,
    };
