// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_sj_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackingSJBody _$TrackingSJBodyFromJson(Map<String, dynamic> json) =>
    TrackingSJBody(
      noSj: json['no_sj'] as String?,
      remarks: json['remarks'] as String?,
      rcv_koli: json['rcv_koli'] as String?,
      missingKoli: (json['missing_koli'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$TrackingSJBodyToJson(TrackingSJBody instance) =>
    <String, dynamic>{
      'no_sj': instance.noSj,
      'remarks': instance.remarks,
      'rcv_koli': instance.rcv_koli,
      'missing_koli': instance.missingKoli,
    };
