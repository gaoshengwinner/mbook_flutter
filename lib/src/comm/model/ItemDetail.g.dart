// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ItemDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemDetail _$ItemDetailFromJson(Map<String, dynamic> json) {
  return ItemDetail(
    id: json['id'] as int?,
    itemPrice: json['itemPrice'] as String?,
    itemName: json['itemName'] as String?,
    itemDescr: json['itemDescr'] as String?,
    itemMainPicUrl: json['itemMainPicUrl'] as String?,
    itemDispDetail: json['itemDispDetail'] as String?,
    displayTags: (json['displayTags'] as List<dynamic>?)
        ?.map((e) => TagInfo.fromJson(e as Map<String, dynamic>))
        .toList(),
    functionTags: (json['functionTags'] as List<dynamic>?)
        ?.map((e) => TagInfo.fromJson(e as Map<String, dynamic>))
        .toList(),
    additionInfo: json['additionInfo'] as String?,
  )
    ..shopId = json['shopId'] as int?
    ..itemNo = json['itemNo'] as String?;
}

Map<String, dynamic> _$ItemDetailToJson(ItemDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shopId': instance.shopId,
      'itemNo': instance.itemNo,
      'itemPrice': instance.itemPrice,
      'itemName': instance.itemName,
      'itemDescr': instance.itemDescr,
      'itemMainPicUrl': instance.itemMainPicUrl,
      'itemDispDetail': instance.itemDispDetail,
      'displayTags': instance.displayTags,
      'functionTags': instance.functionTags,
      'additionInfo': instance.additionInfo,
    };
