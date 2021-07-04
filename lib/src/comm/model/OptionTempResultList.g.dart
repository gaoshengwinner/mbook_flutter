// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OptionTempResultList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionTempResultList _$OptionTempResultListFromJson(Map<String, dynamic> json) {
  return OptionTempResultList(
    optionTempLst: (json['optionTempLst'] as List<dynamic>?)
        ?.map((e) => OptionTemp.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$OptionTempResultListToJson(
        OptionTempResultList instance) =>
    <String, dynamic>{
      'optionTempLst': instance.optionTempLst,
    };
