import 'package:json_annotation/json_annotation.dart';

part 'check_price_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CheckPriceBody {
  String? para1;
  String? apara2;

  CheckPriceBody({
    this.para1,
    this.apara2,
    });

  CheckPriceBody.fromJson(Map<String, dynamic> json) {
    para1 = json['para1'];
    apara2 = json['apara2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['para1'] = this.para1;
    data['apara2'] = this.apara2;
    return data;
  }
}