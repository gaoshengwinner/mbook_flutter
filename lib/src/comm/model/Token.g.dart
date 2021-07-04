// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Token _$TokenFromJson(Map<String, dynamic> json) {
  return Token(
    json['refreshToken'] as String?,
    json['refreshTokenLimit'] as int?,
    json['refressBeginDate'] == null
        ? null
        : DateTime.parse(json['refressBeginDate'] as String),
    json['accessToken'] as String?,
    json['accessTokenLimit'] as int?,
    json['accessTokenDate'] == null
        ? null
        : DateTime.parse(json['accessTokenDate'] as String),
  );
}

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'refreshToken': instance.refreshToken,
      'refreshTokenLimit': instance.refreshTokenLimit,
      'refressBeginDate': instance.refressBeginDate?.toIso8601String(),
      'accessToken': instance.accessToken,
      'accessTokenLimit': instance.accessTokenLimit,
      'accessTokenDate': instance.accessTokenDate?.toIso8601String(),
    };
