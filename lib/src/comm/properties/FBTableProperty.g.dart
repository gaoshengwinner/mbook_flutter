// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBTableProperty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBTableProperty _$FBTablePropertyFromJson(Map<String, dynamic> json) {
  return FBTableProperty(
    textDirection:
        _$enumDecodeNullable(_$TextDirectionEnumMap, json['textDirection']),
    border: json['border'] == null
        ? null
        : FBTableBorderProperty.fromJson(
            json['border'] as Map<String, dynamic>),
    defaultVerticalAlignment: _$enumDecodeNullable(
        _$TableCellVerticalAlignmentEnumMap, json['defaultVerticalAlignment']),
    textBaseline:
        _$enumDecodeNullable(_$TextBaselineEnumMap, json['textBaseline']),
  );
}

Map<String, dynamic> _$FBTablePropertyToJson(FBTableProperty instance) =>
    <String, dynamic>{
      'textDirection': _$TextDirectionEnumMap[instance.textDirection],
      'border': instance.border,
      'defaultVerticalAlignment': _$TableCellVerticalAlignmentEnumMap[
          instance.defaultVerticalAlignment],
      'textBaseline': _$TextBaselineEnumMap[instance.textBaseline],
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

const _$TextDirectionEnumMap = {
  TextDirection.rtl: 'rtl',
  TextDirection.ltr: 'ltr',
};

const _$TableCellVerticalAlignmentEnumMap = {
  TableCellVerticalAlignment.top: 'top',
  TableCellVerticalAlignment.middle: 'middle',
  TableCellVerticalAlignment.bottom: 'bottom',
  TableCellVerticalAlignment.baseline: 'baseline',
  TableCellVerticalAlignment.fill: 'fill',
};

const _$TextBaselineEnumMap = {
  TextBaseline.alphabetic: 'alphabetic',
  TextBaseline.ideographic: 'ideographic',
};
