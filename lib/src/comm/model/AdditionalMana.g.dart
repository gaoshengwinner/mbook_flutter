// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AdditionalMana.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdditionalMana _$AdditionalManaFromJson(Map<String, dynamic> json) {
  return AdditionalMana(
    simpleTexts: (json['simpleTexts'] as List<dynamic>?)
        ?.map((e) => AdditionalInfo.fromJson(e as Map<String, dynamic>))
        .toList(),
    htmlTexts: (json['htmlTexts'] as List<dynamic>?)
        ?.map((e) => AdditionalInfo.fromJson(e as Map<String, dynamic>))
        .toList(),
    pictures: (json['pictures'] as List<dynamic>?)
        ?.map((e) => AdditionalInfo.fromJson(e as Map<String, dynamic>))
        .toList(),
    videos: (json['videos'] as List<dynamic>?)
        ?.map((e) => AdditionalInfo.fromJson(e as Map<String, dynamic>))
        .toList(),
    webViews: (json['webViews'] as List<dynamic>?)
        ?.map((e) => AdditionalInfo.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$AdditionalManaToJson(AdditionalMana instance) =>
    <String, dynamic>{
      'simpleTexts': instance.simpleTexts,
      'htmlTexts': instance.htmlTexts,
      'pictures': instance.pictures,
      'videos': instance.videos,
      'webViews': instance.webViews,
    };
