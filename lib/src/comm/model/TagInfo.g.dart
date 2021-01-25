// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TagInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagInfo _$TagInfoFromJson(Map<String, dynamic> json) {
  return TagInfo(
    id: json['id'] as int,
    data: json['data'] as String,
    desc: json['desc'] as String,
    propertyString: json['propertyString'] as String,
  );
}

Map<String, dynamic> _$TagInfoToJson(TagInfo instance) => <String, dynamic>{
      'id': instance.id,
      'data': instance.data,
      'desc': instance.desc,
      'propertyString': instance.propertyString,
    };
