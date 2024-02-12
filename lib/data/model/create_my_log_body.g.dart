// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_my_log_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateLogBody _$CreateLogBodyFromJson(Map<String, dynamic> json) =>
    CreateLogBody(
      progname: json['progname'] as String?,
      versi: json['versi'] as String?,
      dateRun: json['date_run'] as String?,
      info1: json['info1'] as String?,
      info2: json['info2'] as String?,
      userid: json['userid'] as String?,
      toko: json['toko'] as String?,
      devicename: json['devicename'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$CreateLogBodyToJson(CreateLogBody instance) =>
    <String, dynamic>{
      'progname': instance.progname,
      'versi': instance.versi,
      'date_run': instance.dateRun,
      'info1': instance.info1,
      'info2': instance.info2,
      'userid': instance.userid,
      'toko': instance.toko,
      'devicename': instance.devicename,
      'token': instance.token,
    };
