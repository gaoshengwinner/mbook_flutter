// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ShopInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopInfo _$ShopInfoFromJson(Map<String, dynamic> json) {
  return ShopInfo(
    json['shopName'] as String,
    json['shopAddr'] as String,
    json['shopTel'] as String,
    json['shopPicUrl'] as String,
  );
}

Map<String, dynamic> _$ShopInfoToJson(ShopInfo instance) => <String, dynamic>{
      'shopName': instance.shopName,
      'shopAddr': instance.shopAddr,
      'shopTel': instance.shopTel,
      'shopPicUrl': instance.shopPicUrl,
    };
