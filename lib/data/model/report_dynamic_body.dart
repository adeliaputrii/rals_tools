import 'package:json_annotation/json_annotation.dart';

part 'report_dynamic_body.g.dart';

@JsonSerializable()
class ReportModel {
  @JsonKey(name: 'report_id')
  final String reportId;

  ReportModel({required this.reportId});

  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportModelToJson(this);

    @override
  String toString() {
    return 'Report_id(report_id: $reportId)';
  }
}
