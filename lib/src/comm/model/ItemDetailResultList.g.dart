// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ItemDetailResultList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemDetailResultList _$ItemDetailResultListFromJson(Map<String, dynamic> json) {
  return ItemDetailResultList(
    itemDetailLst: (json['itemDetailLst'] as List<dynamic>?)
        ?.map((e) => ItemDetail.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ItemDetailResultListToJson(
        ItemDetailResultList instance) =>
    <String, dynamic>{
      'itemDetailLst': instance.itemDetailLst,
    };
