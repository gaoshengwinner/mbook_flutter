// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DeviceInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) {
  return DeviceInfo(
    json['deviceId'] as String?,
    json['phoneName'] as String,
    json['appVersion'] as String,
    json['systemName'] as String,
    json['systemVersion'] as String,
  )..deviceIP = json['deviceIP'] as String;
}

Map<String, dynamic> _$DeviceInfoToJson(DeviceInfo instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'phoneName': instance.phoneName,
      'appVersion': instance.appVersion,
      'systemName': instance.systemName,
      'systemVersion': instance.systemVersion,
      'deviceIP': instance.deviceIP,
    };
