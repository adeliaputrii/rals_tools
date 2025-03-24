// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_opname_submit_reponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockOpnameSubmitResponse _$StockOpnameSubmitResponseFromJson(
        Map<String, dynamic> json) =>
    StockOpnameSubmitResponse(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$StockOpnameSubmitResponseToJson(
        StockOpnameSubmitResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
