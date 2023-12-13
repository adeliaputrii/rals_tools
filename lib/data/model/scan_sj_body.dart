import 'package:json_annotation/json_annotation.dart';

part 'scan_sj_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TrackingSJBody {
  String? noSj;
  String? remarks;

  TrackingSJBody({this.noSj, this.remarks});

  TrackingSJBody.fromJson(Map<String, dynamic> json) {
    noSj = json['no_sj'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no_sj'] = this.noSj;
    data['remarks'] = this.remarks;
    return data;
  }
}
