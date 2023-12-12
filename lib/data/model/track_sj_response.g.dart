// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_sj_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackingSJResponse _$TrackingSJResponseFromJson(Map<String, dynamic> json) =>
    TrackingSJResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TrackingSJResponseToJson(TrackingSJResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
