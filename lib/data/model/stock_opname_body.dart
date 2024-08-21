
import 'package:json_annotation/json_annotation.dart';
part 'stock_opname_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class StockOpnameGetBody {
  String? quenic;

  StockOpnameGetBody({this.quenic});

  StockOpnameGetBody.fromJson(Map<String, dynamic> json) {
    quenic = json['quenic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quenic'] = this.quenic;
    return data;
  }
}