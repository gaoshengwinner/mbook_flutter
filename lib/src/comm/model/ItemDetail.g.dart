// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ItemDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemDetail _$ItemDetailFromJson(Map<String, dynamic> json) {
  return ItemDetail(
    id: json['id'] as int,
    itemPrice: json['itemPrice'] as String,
    itemName: json['itemName'] as String,
    itemDescr: json['itemDescr'] as String,
    itemMainPicUrl: json['itemMainPicUrl'] as String,
    itemDispDetail: json['itemDispDetail'] as String,
    tags: (json['tags'] as List)
        ?.map((e) =>
            e == null ? null : TagInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..shopId = json['shopId'] as int;
}

Map<String, dynamic> _$ItemDetailToJson(ItemDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shopId': instance.shopId,
      'itemPrice': instance.itemPrice,
      'itemName': instance.itemName,
      'itemDescr': instance.itemDescr,
      'itemMainPicUrl': instance.itemMainPicUrl,
      'itemDispDetail': instance.itemDispDetail,
      'tags': instance.tags,
    };
