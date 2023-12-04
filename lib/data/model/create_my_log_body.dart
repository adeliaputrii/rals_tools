import 'package:json_annotation/json_annotation.dart';

part 'create_my_log_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CreateLogBody {
  String? progname;
  String? versi;
  String? dateRun;
  String? info1;
  String? info2;
  int? userid;
  String? toko;
  String? devicename;
  String? token;

  CreateLogBody(
      {this.progname,
      this.versi,
      this.dateRun,
      this.info1,
      this.info2,
      this.userid,
      this.toko,
      this.devicename,
      this.token});

  CreateLogBody.fromJson(Map<String, dynamic> json) {
    progname = json['progname'];
    versi = json['versi'];
    dateRun = json['date_run'];
    info1 = json['info1'];
    info2 = json['info2'];
    userid = json['userid'];
    toko = json['toko'];
    devicename = json['devicename'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['progname'] = this.progname;
    data['versi'] = this.versi;
    data['date_run'] = this.dateRun;
    data['info1'] = this.info1;
    data['info2'] = this.info2;
    data['userid'] = this.userid;
    data['toko'] = this.toko;
    data['devicename'] = this.devicename;
    data['token'] = this.token;
    return data;
  }
}
