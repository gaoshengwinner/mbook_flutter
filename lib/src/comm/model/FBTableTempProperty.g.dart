// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBTableTempProperty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBTableTempProperty _$FBTableTempPropertyFromJson(Map<String, dynamic> json) {
  return FBTableTempProperty(
    desc: json['desc'] as String?,
    outSide:
        TextWidgetProperty.fromJson(json['outSide'] as Map<String, dynamic>),
    property: json['property'] == null
        ? null
        : FBTableProperty.fromJson(json['property'] as Map<String, dynamic>),
    rowSet: (json['rowSet'] as List<dynamic>?)
        ?.map((e) => RowSet.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$FBTableTempPropertyToJson(
        FBTableTempProperty instance) =>
    <String, dynamic>{
      'desc': instance.desc,
      'outSide': instance.outSide,
      'property': instance.property,
      'rowSet': instance.rowSet,
    };

OutSideProperty _$OutSidePropertyFromJson(Map<String, dynamic> json) {
  return OutSideProperty(
    backColor: json['backColor'] == null
        ? null
        : FBColorProperty.fromJson(json['backColor'] as Map<String, dynamic>),
    leftBorder: json['leftBorder'] == null
        ? null
        : FBBorderSideProperty.fromJson(
            json['leftBorder'] as Map<String, dynamic>),
    topBorder: json['topBorder'] == null
        ? null
        : FBBorderSideProperty.fromJson(
            json['topBorder'] as Map<String, dynamic>),
    rightBorder: json['rightBorder'] == null
        ? null
        : FBBorderSideProperty.fromJson(
            json['rightBorder'] as Map<String, dynamic>),
    bottomBorder: json['bottomBorder'] == null
        ? null
        : FBBorderSideProperty.fromJson(
            json['bottomBorder'] as Map<String, dynamic>),
    borderRadiusTopLeft: (json['borderRadiusTopLeft'] as num?)?.toDouble(),
    borderRadiusBottomLeft:
        (json['borderRadiusBottomLeft'] as num?)?.toDouble(),
    borderRadiusBottomRight:
        (json['borderRadiusBottomRight'] as num?)?.toDouble(),
    borderRadiusTopRight: (json['borderRadiusTopRight'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$OutSidePropertyToJson(OutSideProperty instance) =>
    <String, dynamic>{
      'backColor': instance.backColor,
      'leftBorder': instance.leftBorder,
      'topBorder': instance.topBorder,
      'rightBorder': instance.rightBorder,
      'bottomBorder': instance.bottomBorder,
      'borderRadiusTopLeft': instance.borderRadiusTopLeft,
      'borderRadiusTopRight': instance.borderRadiusTopRight,
      'borderRadiusBottomRight': instance.borderRadiusBottomRight,
      'borderRadiusBottomLeft': instance.borderRadiusBottomLeft,
    };

RowSet _$RowSetFromJson(Map<String, dynamic> json) {
  return RowSet(
    property: json['property'] == null
        ? null
        : FBBoxDecorationProperty.fromJson(
            json['property'] as Map<String, dynamic>),
    cellSet: (json['cellSet'] as List<dynamic>?)
        ?.map((e) => CellSet.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$RowSetToJson(RowSet instance) => <String, dynamic>{
      'property': instance.property,
      'cellSet': instance.cellSet,
    };

CellSet _$CellSetFromJson(Map<String, dynamic> json) {
  return CellSet(
    property: json['property'] == null
        ? null
        : FBTableCellProperty.fromJson(
            json['property'] as Map<String, dynamic>),
    fbWidget: (json['fbWidget'] as List<dynamic>?)
        ?.map((e) => FBWidget.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CellSetToJson(CellSet instance) => <String, dynamic>{
      'property': instance.property,
      'fbWidget': instance.fbWidget,
    };

FBWidget _$FBWidgetFromJson(Map<String, dynamic> json) {
  return FBWidget(
    type: _$enumDecodeNullable(_$FBWidegetTypeEnumMap, json['type']),
    value: json['value'] as String?,
  );
}

Map<String, dynamic> _$FBWidgetToJson(FBWidget instance) => <String, dynamic>{
      'type': _$FBWidegetTypeEnumMap[instance.type],
      'value': instance.value,
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

const _$FBWidegetTypeEnumMap = {
  FBWidegetType.text: 'text',
  FBWidegetType.img: 'img',
};
