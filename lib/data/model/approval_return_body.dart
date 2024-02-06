import 'package:json_annotation/json_annotation.dart';

part 'approval_return_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ApprovalReturnBody {
  String? tipe;
  String? tanggal;
  String? store_code;

  ApprovalReturnBody({
    this.tipe,
    this.tanggal,
    this.store_code
    });

  ApprovalReturnBody.fromJson(Map<String, dynamic> json) {
    tipe = json['tipe'];
    tanggal = json['tanggal'];
    store_code = json['store_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tipe'] = this.tipe;
    data['tanggal'] = this.tanggal;
    data['store_code'] = this.store_code;
    return data;
  }
}