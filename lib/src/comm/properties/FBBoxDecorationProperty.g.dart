// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBBoxDecorationProperty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBBoxDecorationProperty _$FBBoxDecorationPropertyFromJson(
    Map<String, dynamic> json) {
  return FBBoxDecorationProperty(
    color: json['color'] == null
        ? null
        : FBColorProperty.fromJson(json['color'] as Map<String, dynamic>),
    topLeft: (json['topLeft'] as num?)?.toDouble(),
    topRight: (json['topRight'] as num?)?.toDouble(),
    bottomLeft: (json['bottomLeft'] as num?)?.toDouble(),
    bottomRight: (json['bottomRight'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$FBBoxDecorationPropertyToJson(
        FBBoxDecorationProperty instance) =>
    <String, dynamic>{
      'color': instance.color,
      'topLeft': instance.topLeft,
      'topRight': instance.topRight,
      'bottomLeft': instance.bottomLeft,
      'bottomRight': instance.bottomRight,
    };
