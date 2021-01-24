// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TextWidgetProperty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextWidgetProperty _$TextWidgetPropertyFromJson(Map<String, dynamic> json) {
  return TextWidgetProperty(
    fullLineDisp: json['fullLineDisp'] as bool,
    textColor:
        const CustomColorConverter().fromJson(json['textColor'] as String),
    backColor:
        const CustomColorConverter().fromJson(json['backColor'] as String),
    fontSize: (json['fontSize'] as num)?.toDouble(),
    fontWeight: json['fontWeight'] as int,
    italic: json['italic'] as bool,
    letterSpacing: (json['letterSpacing'] as num)?.toDouble(),
    paddingLeft: (json['paddingLeft'] as num)?.toDouble(),
    paddingTop: (json['paddingTop'] as num)?.toDouble(),
    paddingRight: (json['paddingRight'] as num)?.toDouble(),
    paddingBottom: (json['paddingBottom'] as num)?.toDouble(),
    textTextAlign: json['textTextAlign'] as String,
    borderWidth: (json['borderWidth'] as num)?.toDouble(),
    borderColor:
        const CustomColorConverter().fromJson(json['borderColor'] as String),
    borderRadiusTopLeft: (json['borderRadiusTopLeft'] as num)?.toDouble(),
    borderRadiusTopRight: (json['borderRadiusTopRight'] as num)?.toDouble(),
    borderRadiusBottomLeft: (json['borderRadiusBottomLeft'] as num)?.toDouble(),
    borderRadiusBottomRight:
        (json['borderRadiusBottomRight'] as num)?.toDouble(),
    shadowColor:
        const CustomColorConverter().fromJson(json['shadowColor'] as String),
    shadowOffsetX: (json['shadowOffsetX'] as num)?.toDouble(),
    shadowOffsetY: (json['shadowOffsetY'] as num)?.toDouble(),
    shadowBlurRadius: (json['shadowBlurRadius'] as num)?.toDouble(),
    shadowSpreadRadius: (json['shadowSpreadRadius'] as num)?.toDouble(),
    minWidth: (json['minWidth'] as num)?.toDouble(),
    minHeight: (json['minHeight'] as num)?.toDouble(),
    maxWidth: (json['maxWidth'] as num)?.toDouble(),
    maxHeight: (json['maxHeight'] as num)?.toDouble(),
    alignment: json['alignment'] as String,
  );
}

Map<String, dynamic> _$TextWidgetPropertyToJson(TextWidgetProperty instance) =>
    <String, dynamic>{
      'fullLineDisp': instance.fullLineDisp,
      'textColor': const CustomColorConverter().toJson(instance.textColor),
      'backColor': const CustomColorConverter().toJson(instance.backColor),
      'fontSize': instance.fontSize,
      'fontWeight': instance.fontWeight,
      'italic': instance.italic,
      'letterSpacing': instance.letterSpacing,
      'paddingLeft': instance.paddingLeft,
      'paddingTop': instance.paddingTop,
      'paddingRight': instance.paddingRight,
      'paddingBottom': instance.paddingBottom,
      'textTextAlign': instance.textTextAlign,
      'borderWidth': instance.borderWidth,
      'borderColor': const CustomColorConverter().toJson(instance.borderColor),
      'borderRadiusTopLeft': instance.borderRadiusTopLeft,
      'borderRadiusTopRight': instance.borderRadiusTopRight,
      'borderRadiusBottomLeft': instance.borderRadiusBottomLeft,
      'borderRadiusBottomRight': instance.borderRadiusBottomRight,
      'shadowColor': const CustomColorConverter().toJson(instance.shadowColor),
      'shadowOffsetX': instance.shadowOffsetX,
      'shadowOffsetY': instance.shadowOffsetY,
      'shadowBlurRadius': instance.shadowBlurRadius,
      'shadowSpreadRadius': instance.shadowSpreadRadius,
      'minWidth': instance.minWidth,
      'minHeight': instance.minHeight,
      'maxWidth': instance.maxWidth,
      'maxHeight': instance.maxHeight,
      'alignment': instance.alignment,
    };
