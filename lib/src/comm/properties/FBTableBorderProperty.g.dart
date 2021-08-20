// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBTableBorderProperty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBTableBorderProperty _$FBTableBorderPropertyFromJson(
    Map<String, dynamic> json) {
  return FBTableBorderProperty(
    top: json['top'] == null
        ? null
        : FBBorderSideProperty.fromJson(json['top'] as Map<String, dynamic>),
    right: json['right'] == null
        ? null
        : FBBorderSideProperty.fromJson(json['right'] as Map<String, dynamic>),
    bottom: json['bottom'] == null
        ? null
        : FBBorderSideProperty.fromJson(json['bottom'] as Map<String, dynamic>),
    left: json['left'] == null
        ? null
        : FBBorderSideProperty.fromJson(json['left'] as Map<String, dynamic>),
    horizontalInside: json['horizontalInside'] == null
        ? null
        : FBBorderSideProperty.fromJson(
            json['horizontalInside'] as Map<String, dynamic>),
    verticalInside: json['verticalInside'] == null
        ? null
        : FBBorderSideProperty.fromJson(
            json['verticalInside'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FBTableBorderPropertyToJson(
        FBTableBorderProperty instance) =>
    <String, dynamic>{
      'top': instance.top,
      'right': instance.right,
      'bottom': instance.bottom,
      'left': instance.left,
      'horizontalInside': instance.horizontalInside,
      'verticalInside': instance.verticalInside,
    };
