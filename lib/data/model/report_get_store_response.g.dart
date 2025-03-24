// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_get_store_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesReportStoreResponse _$SalesReportStoreResponseFromJson(
        Map<String, dynamic> json) =>
    SalesReportStoreResponse(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>)
          .map(
              (e) => SalesDataStoreResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SalesReportStoreResponseToJson(
        SalesReportStoreResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

SalesDataStoreResponse _$SalesDataStoreResponseFromJson(
        Map<String, dynamic> json) =>
    SalesDataStoreResponse(
      storeCode: json['store_code'] as String?,
      idKorem: json['id_korem'] as String?,
    );

Map<String, dynamic> _$SalesDataStoreResponseToJson(
        SalesDataStoreResponse instance) =>
    <String, dynamic>{
      'store_code': instance.storeCode,
      'id_korem': instance.idKorem,
    };
