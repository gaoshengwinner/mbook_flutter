// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ItemOptionList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemOptionList _$ItemOptionListFromJson(Map<String, dynamic> json) {
  return ItemOptionList(
    canMultSelect: json['canMultSelect'] as bool,
    title: json['title'] as String,
    delefalutSelectId:
        (json['delefalutSelectId'] as List)?.map((e) => e as int)?.toList(),
    options: (json['options'] as List)
        ?.map((e) =>
            e == null ? null : ItemOption.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ItemOptionListToJson(ItemOptionList instance) =>
    <String, dynamic>{
      'canMultSelect': instance.canMultSelect,
      'title': instance.title,
      'delefalutSelectId': instance.delefalutSelectId,
      'options': instance.options,
    };

ItemOption _$ItemOptionFromJson(Map<String, dynamic> json) {
  return ItemOption(
    id: json['id'] as int,
    title: json['title'] as String,
    prePriceString: json['prePriceString'] as String,
    price: json['price'] as int,
    nexPriceString: json['nexPriceString'] as String,
  );
}

Map<String, dynamic> _$ItemOptionToJson(ItemOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'prePriceString': instance.prePriceString,
      'price': instance.price,
      'nexPriceString': instance.nexPriceString,
    };
