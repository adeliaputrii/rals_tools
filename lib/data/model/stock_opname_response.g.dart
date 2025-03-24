// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_opname_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockOpnameResponse _$StockOpnameResponseFromJson(Map<String, dynamic> json) =>
    StockOpnameResponse(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StockOpnameResponseToJson(
        StockOpnameResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
