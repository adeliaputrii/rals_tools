// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_opname_submit_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockOpnameSubmitBody _$StockOpnameSubmitBodyFromJson(
        Map<String, dynamic> json) =>
    StockOpnameSubmitBody(
      quenic: json['quenic'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => StockOpnameBody.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StockOpnameSubmitBodyToJson(
        StockOpnameSubmitBody instance) =>
    <String, dynamic>{
      'quenic': instance.quenic,
      'data': instance.data,
    };
