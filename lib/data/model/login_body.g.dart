// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginBody _$LoginBodyFromJson(Map<String, dynamic> json) => LoginBody(
      userName: json['user_name'] as String?,
      password: json['password'] as String?,
      deviceId: json['device_id'] as String?,
    );

Map<String, dynamic> _$LoginBodyToJson(LoginBody instance) => <String, dynamic>{
      'user_name': instance.userName,
      'password': instance.password,
      'device_id': instance.deviceId,
    };
