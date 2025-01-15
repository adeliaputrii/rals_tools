import 'package:json_annotation/json_annotation.dart';

part 'report_get_store_response.g.dart';

@JsonSerializable()
class SalesReportStoreResponse {
  @JsonKey(name: 'status')
  final int? status;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'data')
  final List<SalesDataStoreResponse> data;

  SalesReportStoreResponse({this.status, this.message, required this.data});

  factory SalesReportStoreResponse.fromJson(Map<String, dynamic> json) =>
      _$SalesReportStoreResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SalesReportStoreResponseToJson(this);

  @override
  String toString() {
    return 'SalesReportResponse(status: $status, message: $message, data: $data)';
  }
}

@JsonSerializable()
class SalesDataStoreResponse {
  @JsonKey(name: 'store_code')
  final String? storeCode;

  @JsonKey(name: 'id_korem')
  final String? idKorem;

  SalesDataStoreResponse({this.storeCode, this.idKorem});

  factory SalesDataStoreResponse.fromJson(Map<String, dynamic> json) =>
      _$SalesDataStoreResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SalesDataStoreResponseToJson(this);

  @override
  String toString() {
    return 'SalesData(storeCode: $storeCode, idKorem: $idKorem)';
  }
}
