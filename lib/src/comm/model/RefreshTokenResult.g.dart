// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RefreshTokenResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshTokenResult _$RefreshTokenResultFromJson(Map<String, dynamic> json) {
  return RefreshTokenResult(
    json['statu'] as String,
    json['err'] as String,
    json['accessToken'] as String,
    json['accessTokenLimit'] as int,
  );
}

Map<String, dynamic> _$RefreshTokenResultToJson(RefreshTokenResult instance) =>
    <String, dynamic>{
      'statu': instance.statu,
      'err': instance.err,
      'accessToken': instance.accessToken,
      'accessTokenLimit': instance.accessTokenLimit,
    };
