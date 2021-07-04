// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResetPasswordResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPasswordResult _$ResetPasswordResultFromJson(Map<String, dynamic> json) {
  return ResetPasswordResult(
    json['statu'] as String?,
    (json['errs'] as List<dynamic>?)
        ?.map((e) => Errs.fromJson(e as Map<String, dynamic>?))
        .toList(),
  )..uuid = json['uuid'] as String?;
}

Map<String, dynamic> _$ResetPasswordResultToJson(
        ResetPasswordResult instance) =>
    <String, dynamic>{
      'statu': instance.statu,
      'uuid': instance.uuid,
      'errs': instance.errs,
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
