import 'package:json_annotation/json_annotation.dart';

part 'scan_sj_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TrackingSJBody {
  String? noSj;
  String? remarks;
  String? rcv_koli;
  List<String>? missingKoli;

  TrackingSJBody({this.noSj, this.remarks, this.rcv_koli, this.missingKoli});

  TrackingSJBody.fromJson(Map<String, dynamic> json) {
    noSj = json['no_sj'];
    remarks = json['remarks'];
    rcv_koli = json['rcv_koli'];
    missingKoli = json['missing_koli'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no_sj'] = this.noSj;
    data['remarks'] = this.remarks;
    data['rcv_koli'] = this.rcv_koli;
    data['missing_koli'] = this.missingKoli;
    return data;
  }
}
