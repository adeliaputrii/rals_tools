import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'response_report_dynamic_header.g.dart';

@JsonSerializable()
class ResponseReportDynamic {
  final int status;
  final String message;
  final List<ReportDynamic> data;

  ResponseReportDynamic({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ResponseReportDynamic.fromJson(Map<String, dynamic> json) =>
      _$ResponseReportDynamicFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseReportDynamicToJson(this);
}

@JsonSerializable()
class ReportDynamic {
  @JsonKey(name: 'report_id')
  final String reportId;

  @JsonKey(name: 'jml_kolom')
  final String jmlKolom;

  @JsonKey(name: 'status_process')
  final String statusProcess;

  @JsonKey(name: 'user_create')
  final String userCreate;

  @JsonKey(name: 'date_create')
  final String dateCreate;

  @JsonKey(name: 'user_modify')
  final String userModify;

  @JsonKey(name: 'date_modify')
  final String dateModify;

  @JsonKey(name: 'last_update')
  final String lastUpdate;

  @JsonKey(name: 'nama_report')
  final String namaReport;

  ReportDynamic({
    required this.reportId,
    required this.jmlKolom,
    required this.statusProcess,
    required this.userCreate,
    required this.dateCreate,
    required this.userModify,
    required this.dateModify,
    required this.lastUpdate,
    required this.namaReport,
  });

  factory ReportDynamic.fromJson(Map<String, dynamic> json) =>
      _$ReportDynamicFromJson(json);

  Map<String, dynamic> toJson() => _$ReportDynamicToJson(this);
}
