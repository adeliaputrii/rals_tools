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
      trackingStatus: json['tracking_status'] == null
          ? null
          : TrackingStatus.fromJson(
              json['tracking_status'] as Map<String, dynamic>),
      button: json['button'] == null
          ? null
          : Button.fromJson(json['button'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'tracking_status': instance.trackingStatus,
      'button': instance.button,
    };

TrackingStatus _$TrackingStatusFromJson(Map<String, dynamic> json) =>
    TrackingStatus(
      noSj: json['no_sj'] as String?,
      site: json['site'] as String?,
      description: json['description'] as String?,
      createdDate: json['created_date'] as String?,
      statusBarang: json['status_barang'] as String?,
    );

Map<String, dynamic> _$TrackingStatusToJson(TrackingStatus instance) =>
    <String, dynamic>{
      'no_sj': instance.noSj,
      'site': instance.site,
      'description': instance.description,
      'created_date': instance.createdDate,
      'status_barang': instance.statusBarang,
    };

Button _$ButtonFromJson(Map<String, dynamic> json) => Button(
      receivedBySupplier: json['received_by_supplier'] as bool?,
      regular: json['regular'] as bool?,
      storeline: json['storeline'] as bool?,
    );

Map<String, dynamic> _$ButtonToJson(Button instance) => <String, dynamic>{
      'received_by_supplier': instance.receivedBySupplier,
      'regular': instance.regular,
      'storeline': instance.storeline,
    };
