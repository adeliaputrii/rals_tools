import 'package:json_annotation/json_annotation.dart';

part 'lspb_form_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LspbFormBody {
  String? scan_dokumen;
  String? user;
  String? store;
  String? error_qty;

  LspbFormBody({this.scan_dokumen, this.user, this.store, this.error_qty});

  LspbFormBody.fromJson(Map<String, dynamic> json) {
    scan_dokumen = json['scan_dokumen'];
    user = json['user'];
    store = json['store'];
    error_qty = json['error_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scan_dokumen'] = this.scan_dokumen;
    data['user'] = this.user;
    data['store'] = this.store;
    data['error_qty'] = this.error_qty;
    return data;
  }
}
