import 'package:json_annotation/json_annotation.dart';

part 'report_get_store_body.g.dart';


@JsonSerializable()
class SalesDataStore {
  @JsonKey(name: 'id_korem')
  final String? idKorem;

  @JsonKey(name: 'store_code')
  final String? storeCode;

  SalesDataStore({this.idKorem, this.storeCode});

  factory SalesDataStore.fromJson(Map<String, dynamic> json) =>
      _$SalesDataStoreFromJson(json);

  Map<String, dynamic> toJson() => _$SalesDataStoreToJson(this);

  @override
  String toString() {
    return 'SalesData(idKorem: $idKorem, storeCode: $storeCode)';
  }
}
