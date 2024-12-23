// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_sales_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportSalesBody _$ReportSalesBodyFromJson(Map<String, dynamic> json) =>
    ReportSalesBody(
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
      storeCode: json['store_code'] as String,
    );

Map<String, dynamic> _$ReportSalesBodyToJson(ReportSalesBody instance) =>
    <String, dynamic>{
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'store_code': instance.storeCode,
    };
