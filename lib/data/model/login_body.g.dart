// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginBody _$LoginBodyFromJson(Map<String, dynamic> json) => LoginBody(
      username: json['username'] as String?,
      password: json['password'] as String?,
      deviceId: json['device_id'] as String?,
      versi: json['versi'] as String?,
    );

Map<String, dynamic> _$LoginBodyToJson(LoginBody instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'device_id': instance.deviceId,
      'versi': instance.versi,
    };
