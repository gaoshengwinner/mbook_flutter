// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ShopInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopInfo _$ShopInfoFromJson(Map<String, dynamic> json) {
  return ShopInfo(
    shopName: json['shopName'] as String?,
    shopAddr: json['shopAddr'] as String?,
    shopTel: json['shopTel'] as String?,
    shopPicUrl: json['shopPicUrl'] as String?,
    additionInfo: json['additionInfo'] as String?,
  )
    ..preCurrencyUnit = json['preCurrencyUnit'] as String?
    ..tailCurrencyUnit = json['tailCurrencyUnit'] as String?;
}

Map<String, dynamic> _$ShopInfoToJson(ShopInfo instance) => <String, dynamic>{
      'shopName': instance.shopName,
      'shopAddr': instance.shopAddr,
      'shopTel': instance.shopTel,
      'shopPicUrl': instance.shopPicUrl,
      'additionInfo': instance.additionInfo,
      'preCurrencyUnit': instance.preCurrencyUnit,
      'tailCurrencyUnit': instance.tailCurrencyUnit,
    };
