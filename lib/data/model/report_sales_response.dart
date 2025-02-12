import 'package:json_annotation/json_annotation.dart';

part 'report_sales_response.g.dart';

@JsonSerializable()
class SalesReportResponse {
  final int? status;
  final String? message;
  final List<SalesData> data;

  SalesReportResponse({
    this.status,
    this.message,
    required this.data,
  });

  factory SalesReportResponse.fromJson(Map<String, dynamic> json) =>
      _$SalesReportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SalesReportResponseToJson(this);

  @override
  String toString() {
    return 'SalesReportResponse(status: $status, message: $message, data: $data)';
  }
}

@JsonSerializable()
class SalesData {
  final String? toko;
  final String? md;
  final String? tanggal;
  final String? net;
  final String? target;
  final String? qty;
  final String? gross;
  final String? discount;
  @JsonKey(name: 'last_update')
  final String lastUpdate;

  SalesData({
    this.toko,
    this.md,
    this.tanggal,
    this.net,
    this.target,
    this.qty,
    this.gross,
    this.discount,
    required this.lastUpdate,
  });

  factory SalesData.fromJson(Map<String, dynamic> json) =>
      _$SalesDataFromJson(json);

  Map<String, dynamic> toJson() => _$SalesDataToJson(this);

  @override
  String toString() {
    return 'SalesData(toko: $toko, md: $md, tanggal: $tanggal, net: $net, target: $target, qty: $qty, gross: $gross, discount: $discount, lastUpdate: $lastUpdate)';
  }
}
