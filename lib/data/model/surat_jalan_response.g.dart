// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surat_jalan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuratJalanResponse _$SuratJalanResponseFromJson(Map<String, dynamic> json) =>
    SuratJalanResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SuratJalanResponseToJson(SuratJalanResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      detailSj: json['detail_sj'] == null
          ? null
          : DetailSj.fromJson(json['detail_sj'] as Map<String, dynamic>),
      button: json['button'] == null
          ? null
          : Button.fromJson(json['button'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'detail_sj': instance.detailSj,
      'button': instance.button,
    };

DetailSj _$DetailSjFromJson(Map<String, dynamic> json) => DetailSj(
      noSj: json['no_sj'] as String?,
      destination: json['destination'] as String?,
      documentType: json['document_type'] as String?,
      noVehicle: json['no_vehicle'] as String?,
      driverName: json['driver_name'] as String?,
      origin: json['origin'] as String?,
      trackingStatus: json['tracking_status'] as String?,
      actualKoli: json['actual_koli'] as int?,
      listKoli: (json['list_koli'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$DetailSjToJson(DetailSj instance) => <String, dynamic>{
      'no_sj': instance.noSj,
      'destination': instance.destination,
      'document_type': instance.documentType,
      'no_vehicle': instance.noVehicle,
      'driver_name': instance.driverName,
      'origin': instance.origin,
      'tracking_status': instance.trackingStatus,
      'actual_koli': instance.actualKoli,
      'list_koli': instance.listKoli,
    };
