// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OptionTemp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionTemp _$OptionTempFromJson(Map<String, dynamic> json) {
  return OptionTemp(
    id: json['id'] as int,
    data: json['data'] as String,
    desc: json['desc'] as String,
    propertyString: json['propertyString'] as String,
  )..orders = json['orders'] as int;
}

Map<String, dynamic> _$OptionTempToJson(OptionTemp instance) =>
    <String, dynamic>{
      'id': instance.id,
      'data': instance.data,
      'desc': instance.desc,
      'propertyString': instance.propertyString,
      'orders': instance.orders,
    };
