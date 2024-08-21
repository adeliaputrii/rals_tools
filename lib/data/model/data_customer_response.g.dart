// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_customer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataCustomerResponse _$DataCustomerResponseFromJson(
        Map<String, dynamic> json) =>
    DataCustomerResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataCustomerResponseToJson(
        DataCustomerResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      nokartu: json['nokartu'] as String?,
      nama: json['nama'] as String?,
      nohp: json['nohp'] as String?,
      email: json['email'] as String?,
      saldo: json['saldo'] as String?,
      saldoPemakaian: json['saldo_pemakaian'] as int?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'nokartu': instance.nokartu,
      'nama': instance.nama,
      'nohp': instance.nohp,
      'email': instance.email,
      'saldo': instance.saldo,
      'saldo_pemakaian': instance.saldoPemakaian,
    };
