// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OptionWidgetProperty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionWidgetProperty _$OptionWidgetPropertyFromJson(Map<String, dynamic> json) {
  return OptionWidgetProperty(
    titlePr: const CustomTextWidgetPropertyConverter()
        .fromJson(json['titlePr'] as String),
    framPr: const CustomTextWidgetPropertyConverter()
        .fromJson(json['framPr'] as String),
    buttonPr: const CustomTextWidgetPropertyConverter()
        .fromJson(json['buttonPr'] as String),
    buttonSelectPr: const CustomTextWidgetPropertyConverter()
        .fromJson(json['buttonSelectPr'] as String),
  );
}

Map<String, dynamic> _$OptionWidgetPropertyToJson(
        OptionWidgetProperty instance) =>
    <String, dynamic>{
      'framPr':
          const CustomTextWidgetPropertyConverter().toJson(instance.framPr),
      'titlePr':
          const CustomTextWidgetPropertyConverter().toJson(instance.titlePr),
      'buttonPr':
          const CustomTextWidgetPropertyConverter().toJson(instance.buttonPr),
      'buttonSelectPr': const CustomTextWidgetPropertyConverter()
          .toJson(instance.buttonSelectPr),
    };
