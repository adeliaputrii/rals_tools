// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_report_dynamic_header.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseReportDynamic _$ResponseReportDynamicFromJson(
        Map<String, dynamic> json) =>
    ResponseReportDynamic(
      status: json['status'] as int,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => ReportDynamic.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseReportDynamicToJson(
        ResponseReportDynamic instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

ReportDynamic _$ReportDynamicFromJson(Map<String, dynamic> json) =>
    ReportDynamic(
      reportId: json['report_id'] as String,
      jmlKolom: json['jml_kolom'] as String,
      statusProcess: json['status_process'] as String,
      userCreate: json['user_create'] as String,
      dateCreate: json['date_create'] as String,
      userModify: json['user_modify'] as String,
      dateModify: json['date_modify'] as String,
      lastUpdate: json['last_update'] as String,
      namaReport: json['nama_report'] as String,
    );

Map<String, dynamic> _$ReportDynamicToJson(ReportDynamic instance) =>
    <String, dynamic>{
      'report_id': instance.reportId,
      'jml_kolom': instance.jmlKolom,
      'status_process': instance.statusProcess,
      'user_create': instance.userCreate,
      'date_create': instance.dateCreate,
      'user_modify': instance.userModify,
      'date_modify': instance.dateModify,
      'last_update': instance.lastUpdate,
      'nama_report': instance.namaReport,
    };
