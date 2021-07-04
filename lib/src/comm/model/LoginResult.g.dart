// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LoginResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResult _$LoginResultFromJson(Map<String, dynamic> json) {
  return LoginResult(
    json['statu'] as String?,
    (json['errs'] as List<dynamic>?)
        ?.map((e) => Errs.fromJson(e as Map<String, dynamic>?))
        .toList(),
    json['refreshToken'] as String?,
    json['refreshTokenLimit'] as int?,
    json['accessToken'] as String?,
    json['accessTokenLimit'] as int?,
  );
}

Map<String, dynamic> _$LoginResultToJson(LoginResult instance) =>
    <String, dynamic>{
      'statu': instance.statu,
      'errs': instance.errs,
      'refreshToken': instance.refreshToken,
      'refreshTokenLimit': instance.refreshTokenLimit,
      'accessToken': instance.accessToken,
      'accessTokenLimit': instance.accessTokenLimit,
    };

Errs _$ErrsFromJson(Map<String, dynamic> json) {
  return Errs(
    json['msg'] as String?,
    json['errField'] as String?,
  );
}

Map<String, dynamic> _$ErrsToJson(Errs instance) => <String, dynamic>{
      'msg': instance.msg,
      'errField': instance.errField,
    };
