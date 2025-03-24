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
    final String? c1;
    final String? c2;
    final String? c3;
    final String? c4;
    final String? c5;
    final String? c6;
    final String? c7;
    final String? c8;
    final String? c9;
    final String? c10;
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
  }
