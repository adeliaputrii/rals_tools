import 'package:json_annotation/json_annotation.dart';

part 'login_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LoginBody {
  String? userName;
  String? password;
  String? deviceId;
  String? version;

  LoginBody({this.userName, this.password, this.deviceId, this.version});

  LoginBody.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    password = json['password'];
    deviceId = json['device_id'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['password'] = this.password;
    data['device_id'] = this.deviceId;
    data['version'] = this.version;
    return data;
  }
}
