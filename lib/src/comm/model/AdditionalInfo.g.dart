// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AdditionalInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdditionalInfo _$AdditionalInfoFromJson(Map<String, dynamic> json) {
  return AdditionalInfo(
    no: json['no'] as int?,
    canBeUse: json['canBeUse'] as bool?,
    value: json['value'] as String?,
    title: json['title'] as String?,
  );
}

Map<String, dynamic> _$AdditionalInfoToJson(AdditionalInfo instance) =>
    <String, dynamic>{
      'canBeUse': instance.canBeUse,
      'no': instance.no,
      'value': instance.value,
      'title': instance.title,
    };
