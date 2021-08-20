// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBColorProperty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBColorProperty _$FBColorPropertyFromJson(Map<String, dynamic> json) {
  return FBColorProperty(
    R: json['R'] as int?,
    B: json['B'] as int?,
    G: json['G'] as int?,
    O: (json['O'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$FBColorPropertyToJson(FBColorProperty instance) =>
    <String, dynamic>{
      'R': instance.R,
      'B': instance.B,
      'G': instance.G,
      'O': instance.O,
    };
