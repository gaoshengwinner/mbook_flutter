// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ItemDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemDetail _$ItemDetailFromJson(Map<String, dynamic> json) {
  return ItemDetail(
    json['id'] as int,
    json['itemPrice'] as String,
    json['itemName'] as String,
    json['itemDescr'] as String,
    json['itemMainPicUrl'] as String,
    json['itemDispDetail'] as String,
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
    };
