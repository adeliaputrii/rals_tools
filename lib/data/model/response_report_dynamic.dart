import 'package:json_annotation/json_annotation.dart';

part 'response_report_dynamic.g.dart';

@JsonSerializable()
class ReportResponse {
  final int status;
  final String message;
  final List<ReportData> data;

  ReportResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ReportResponse.fromJson(Map<String, dynamic> json) =>
      _$ReportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReportResponseToJson(this);
}

@JsonSerializable()
class ReportData {
  @JsonKey(name: 'report_id')
  final String? reportId;
  final String? periode;
  final String? line;

  @JsonKey(name: 'c1') final String? c1;
  @JsonKey(name: 'c2') final String? c2;
  @JsonKey(name: 'c3') final String? c3;
  @JsonKey(name: 'c4') final String? c4;
  @JsonKey(name: 'c5') final String? c5;
  @JsonKey(name: 'c6') final String? c6;
  @JsonKey(name: 'c7') final String? c7;
  @JsonKey(name: 'c8') final String? c8;
  @JsonKey(name: 'c9') final String? c9;
  @JsonKey(name: 'c10') final String? c10;
  @JsonKey(name: 'c11') final String? c11;
  @JsonKey(name: 'c12') final String? c12;
  @JsonKey(name: 'c13') final String? c13;
  @JsonKey(name: 'c14') final String? c14;
  @JsonKey(name: 'c15') final String? c15;
  @JsonKey(name: 'c16') final String? c16;
  @JsonKey(name: 'c17') final String? c17;
  @JsonKey(name: 'c18') final String? c18;
  @JsonKey(name: 'c19') final String? c19;
  @JsonKey(name: 'c20') final String? c20;
  @JsonKey(name: 'c21') final String? c21;
  @JsonKey(name: 'c22') final String? c22;
  @JsonKey(name: 'c23') final String? c23;
  @JsonKey(name: 'c24') final String? c24;
  @JsonKey(name: 'c25') final String? c25;
  @JsonKey(name: 'c26') final String? c26;
  @JsonKey(name: 'c27') final String? c27;
  @JsonKey(name: 'c28') final String? c28;
  @JsonKey(name: 'c29') final String? c29;
  @JsonKey(name: 'c30') final String? c30;
  @JsonKey(name: 'c31') final String? c31;
  @JsonKey(name: 'c32') final String? c32;
  @JsonKey(name: 'c33') final String? c33;
  @JsonKey(name: 'c34') final String? c34;
  @JsonKey(name: 'c35') final String? c35;
  @JsonKey(name: 'c36') final String? c36;
  @JsonKey(name: 'c37') final String? c37;
  @JsonKey(name: 'c38') final String? c38;
  @JsonKey(name: 'c39') final String? c39;
  @JsonKey(name: 'c40') final String? c40;
  @JsonKey(name: 'c41') final String? c41;
  @JsonKey(name: 'c42') final String? c42;
  @JsonKey(name: 'c43') final String? c43;
  @JsonKey(name: 'c44') final String? c44;
  @JsonKey(name: 'c45') final String? c45;
  @JsonKey(name: 'c46') final String? c46;
  @JsonKey(name: 'c47') final String? c47;
  @JsonKey(name: 'c48') final String? c48;
  @JsonKey(name: 'c49') final String? c49;
  @JsonKey(name: 'c50') final String? c50;

  @JsonKey(name: 'jml_kolom')
  final String jumlahKolom;
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

  ReportData({
    required this.reportId,
    required this.periode,
    required this.line,
    required this.c1,
    required this.c2,
    required this.c3,
    required this.c4,
    required this.c5,
    this.c6,
    this.c7,
    this.c8,
    this.c9,
    this.c10,
    this.c11,
    this.c12,
    this.c13,
    this.c14,
    this.c15,
    this.c16,
    this.c17,
    this.c18,
    this.c19,
    this.c20,
    this.c21,
    this.c22,
    this.c23,
    this.c24,
    this.c25,
    this.c26,
    this.c27,
    this.c28,
    this.c29,
    this.c30,
    this.c31,
    this.c32,
    this.c33,
    this.c34,
    this.c35,
    this.c36,
    this.c37,
    this.c38,
    this.c39,
    this.c40,
    this.c41,
    this.c42,
    this.c43,
    this.c44,
    this.c45,
    this.c46,
    this.c47,
    this.c48,
    this.c49,
    this.c50,
    required this.jumlahKolom,
    required this.statusProcess,
    required this.userCreate,
    required this.dateCreate,
    required this.userModify,
    required this.dateModify,
    required this.lastUpdate,
    required this.namaReport,
  });

  factory ReportData.fromJson(Map<String, dynamic> json) =>
      _$ReportDataFromJson(json);

  Map<String, dynamic> toJson() => _$ReportDataToJson(this);


  @override
  String toString() {
    return 'ReportData(reportId: $reportId, periode: $periode, line: $line, '
        'c1: $c1, c2: $c2, c3: $c3, c4: $c4, c5: $c5, c6: $c6, c7: $c7, c8: $c8, '
        'c9: $c9, c10: $c10, jumlahKolom: $jumlahKolom, statusProcess: $statusProcess, '
        'userCreate: $userCreate, dateCreate: $dateCreate, userModify: $userModify, '
        'dateModify: $dateModify, lastUpdate: $lastUpdate, namaReport: $namaReport)';
  }
}
