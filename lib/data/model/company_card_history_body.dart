import 'package:json_annotation/json_annotation.dart';

part 'company_card_history_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CompanyCardHistoryBody {
  String? nokartu;
  String? month;
  String? year;
  CompanyCardHistoryBody({this.nokartu, this.month, this.year});

  CompanyCardHistoryBody.fromJson(Map<String, dynamic> json) {
    nokartu = json['nokartu'];
    month = json['month'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nokartu'] = this.nokartu;
    data['month'] = this.month;
    data['year'] = this.year;
    return data;
  }
}
