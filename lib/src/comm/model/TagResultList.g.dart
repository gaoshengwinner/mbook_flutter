// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TagResultList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagResultList _$TagResultListFromJson(Map<String, dynamic> json) {
  return TagResultList(
    tagLst: (json['tagLst'] as List<dynamic>?)
        ?.map((e) => TagInfo.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$TagResultListToJson(TagResultList instance) =>
    <String, dynamic>{
      'tagLst': instance.tagLst,
    };
