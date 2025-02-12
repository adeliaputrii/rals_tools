import 'package:json_annotation/json_annotation.dart';

part 'report_sales_body.g.dart';

@JsonSerializable()
class ReportSalesBody {
  @JsonKey(name: 'start_date')
  final String startDate;

  @JsonKey(name: 'end_date')
  final String endDate;

  @JsonKey(name: 'store_code')
  final String storeCode;



  ReportSalesBody({
    required this.startDate,
    required this.endDate,
    required this.storeCode,

  });

  factory ReportSalesBody.fromJson(Map<String, dynamic> json) =>
      _$ReportSalesBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ReportSalesBodyToJson(this);
}
