// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_sales_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesReportResponse _$SalesReportResponseFromJson(Map<String, dynamic> json) =>
    SalesReportResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>)
          .map((e) => SalesData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SalesReportResponseToJson(
        SalesReportResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

SalesData _$SalesDataFromJson(Map<String, dynamic> json) => SalesData(
      toko: json['toko'] as String?,
      md: json['md'] as String?,
      tanggal: json['tanggal'] as String?,
      net: json['net'] as String?,
      target: json['target'] as String?,
      qty: json['qty'] as String?,
      gross: json['gross'] as String?,
      discount: json['discount'] as String?,
      lastUpdate: json['last_update'] as String,
    );

Map<String, dynamic> _$SalesDataToJson(SalesData instance) => <String, dynamic>{
      'toko': instance.toko,
      'md': instance.md,
      'tanggal': instance.tanggal,
      'net': instance.net,
      'target': instance.target,
      'qty': instance.qty,
      'gross': instance.gross,
      'discount': instance.discount,
      'last_update': instance.lastUpdate,
    };
