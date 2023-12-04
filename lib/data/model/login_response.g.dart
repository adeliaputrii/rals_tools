// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      userpass: json['userpass'] as String?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      accessToken: json['access_token'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'userpass': instance.userpass,
      'status': instance.status,
      'message': instance.message,
      'access_token': instance.accessToken,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      userId: json['user_id'] as int?,
      name: json['name'] as String?,
      username: json['username'] as String?,
      username7: json['username7'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      idSubDivisi: json['id_sub_divisi'] as int?,
      isActive: json['is_active'] as int?,
      toko: json['toko'] as String?,
      imei: json['imei'] as String?,
      md: json['md'] as String?,
      aksesMenu: json['akses_menu'] as String?,
      listMenu: json['list_menu'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'user_id': instance.userId,
      'name': instance.name,
      'username': instance.username,
      'username7': instance.username7,
      'email': instance.email,
      'password': instance.password,
      'id_sub_divisi': instance.idSubDivisi,
      'is_active': instance.isActive,
      'toko': instance.toko,
      'imei': instance.imei,
      'md': instance.md,
      'akses_menu': instance.aksesMenu,
      'list_menu': instance.listMenu,
    };
