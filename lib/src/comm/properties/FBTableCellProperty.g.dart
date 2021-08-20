// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBTableCellProperty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBTableCellProperty _$FBTableCellPropertyFromJson(Map<String, dynamic> json) {
  return FBTableCellProperty(
    width: (json['width'] as num).toDouble(),
    verticalAlignment: _$enumDecodeNullable(
        _$TableCellVerticalAlignmentEnumMap, json['verticalAlignment']),
  );
}

Map<String, dynamic> _$FBTableCellPropertyToJson(
        FBTableCellProperty instance) =>
    <String, dynamic>{
      'width': instance.width,
      'verticalAlignment':
          _$TableCellVerticalAlignmentEnumMap[instance.verticalAlignment],
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

const _$TableCellVerticalAlignmentEnumMap = {
  TableCellVerticalAlignment.top: 'top',
  TableCellVerticalAlignment.middle: 'middle',
  TableCellVerticalAlignment.bottom: 'bottom',
  TableCellVerticalAlignment.baseline: 'baseline',
  TableCellVerticalAlignment.fill: 'fill',
};
