// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_report_dynamic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportResponse _$ReportResponseFromJson(Map<String, dynamic> json) =>
    ReportResponse(
      status: json['status'] as int,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => ReportData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReportResponseToJson(ReportResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

ReportData _$ReportDataFromJson(Map<String, dynamic> json) => ReportData(
      reportId: json['report_id'] as String?,
      periode: json['periode'] as String?,
      line: json['line'] as String?,
      c1: json['c1'] as String?,
      c2: json['c2'] as String?,
      c3: json['c3'] as String?,
      c4: json['c4'] as String?,
      c5: json['c5'] as String?,
      c6: json['c6'] as String?,
      c7: json['c7'] as String?,
      c8: json['c8'] as String?,
      c9: json['c9'] as String?,
      c10: json['c10'] as String?,
      jumlahKolom: json['jml_kolom'] as String,
      statusProcess: json['status_process'] as String,
      userCreate: json['user_create'] as String,
      dateCreate: json['date_create'] as String,
      userModify: json['user_modify'] as String,
      dateModify: json['date_modify'] as String,
      lastUpdate: json['last_update'] as String,
      namaReport: json['nama_report'] as String,
    );

Map<String, dynamic> _$ReportDataToJson(ReportData instance) =>
    <String, dynamic>{
      'report_id': instance.reportId,
      'periode': instance.periode,
      'line': instance.line,
      'c1': instance.c1,
      'c2': instance.c2,
      'c3': instance.c3,
      'c4': instance.c4,
      'c5': instance.c5,
      'c6': instance.c6,
      'c7': instance.c7,
      'c8': instance.c8,
      'c9': instance.c9,
      'c10': instance.c10,
      'jml_kolom': instance.jumlahKolom,
      'status_process': instance.statusProcess,
      'user_create': instance.userCreate,
      'date_create': instance.dateCreate,
      'user_modify': instance.userModify,
      'date_modify': instance.dateModify,
      'last_update': instance.lastUpdate,
      'nama_report': instance.namaReport,
    };
