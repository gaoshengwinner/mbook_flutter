// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SignupMailCnfResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupMailCnfResult _$SignupMailCnfResultFromJson(Map<String, dynamic> json) {
  return SignupMailCnfResult(
    json['statu'] as String,
    (json['errs'] as List)
        ?.map(
            (e) => e == null ? null : Errs.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..uuid = json['uuid'] as String;
}

Map<String, dynamic> _$SignupMailCnfResultToJson(
        SignupMailCnfResult instance) =>
    <String, dynamic>{
      'statu': instance.statu,
      'uuid': instance.uuid,
      'errs': instance.errs,
    };

Errs _$ErrsFromJson(Map<String, dynamic> json) {
  return Errs(
    json['msg'] as String,
    json['errField'] as String,
  );
}

Map<String, dynamic> _$ErrsToJson(Errs instance) => <String, dynamic>{
      'msg': instance.msg,
      'errField': instance.errField,
    };
