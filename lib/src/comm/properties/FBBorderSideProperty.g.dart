// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBBorderSideProperty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBBorderSideProperty _$FBBorderSidePropertyFromJson(Map<String, dynamic> json) {
  return FBBorderSideProperty(
    colorProperty: json['colorProperty'] == null
        ? null
        : FBColorProperty.fromJson(
            json['colorProperty'] as Map<String, dynamic>),
    width: (json['width'] as num?)?.toDouble(),
    style: _$enumDecodeNullable(_$BorderStyleEnumMap, json['style']),
  );
}

Map<String, dynamic> _$FBBorderSidePropertyToJson(
        FBBorderSideProperty instance) =>
    <String, dynamic>{
      'colorProperty': instance.colorProperty,
      'width': instance.width,
      'style': _$BorderStyleEnumMap[instance.style],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$BorderStyleEnumMap = {
  BorderStyle.none: 'none',
  BorderStyle.solid: 'solid',
};
