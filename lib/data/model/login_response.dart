import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LoginResponse {
  String? userpass;
  int? status;
  String? message;
  String? accessToken;
  Data? data;

  LoginResponse(
      {this.userpass, this.status, this.message, this.accessToken, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    userpass = json['userpass'];
    status = json['status'];
    message = json['message'];
    accessToken = json['access_token'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userpass'] = this.userpass;
    data['status'] = this.status;
    data['message'] = this.message;
    data['access_token'] = this.accessToken;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Data {
  int? userId;
  String? name;
  String? username;
  String? username7;
  String? email;
  String? password;
  int? idSubDivisi;
  int? isActive;
  String? toko;
  String? imei;
  String? md;
  String? aksesMenu;
  String? listMenu;

  Data(
      {this.userId,
      this.name,
      this.username,
      this.username7,
      this.email,
      this.password,
      this.idSubDivisi,
      this.isActive,
      this.toko,
      this.imei,
      this.md,
      this.aksesMenu,
      this.listMenu});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    username = json['username'];
    username7 = json['username7'];
    email = json['email'];
    password = json['password'];
    idSubDivisi = json['id_sub_divisi'];
    isActive = json['is_active'];
    toko = json['toko'];
    imei = json['imei'];
    md = json['md'];
    aksesMenu = json['akses_menu'];
    listMenu = json['list_menu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['username'] = this.username;
    data['username7'] = this.username7;
    data['email'] = this.email;
    data['password'] = this.password;
    data['id_sub_divisi'] = this.idSubDivisi;
    data['is_active'] = this.isActive;
    data['toko'] = this.toko;
    data['imei'] = this.imei;
    data['md'] = this.md;
    data['akses_menu'] = this.aksesMenu;
    data['list_menu'] = this.listMenu;
    return data;
  }
}
