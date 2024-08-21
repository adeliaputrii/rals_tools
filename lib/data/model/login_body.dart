import 'package:json_annotation/json_annotation.dart';

part 'login_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LoginBody {
  String? username;
  String? password;
  String? deviceId;
  String? versi;

  LoginBody({this.username, this.password, this.deviceId, this.versi});

  LoginBody.fromJson(Map<String, dynamic> json) {
    username = json['user_name'];
    password = json['password'];
    deviceId = json['device_id'];
    versi = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.username;
    data['password'] = this.password;
    data['device_id'] = this.deviceId;
    data['version'] = this.versi;
    return data;
  }
}
