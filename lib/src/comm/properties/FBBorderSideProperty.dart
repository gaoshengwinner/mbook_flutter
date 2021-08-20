// root flutter packages pub run build_runner build --delete-conflicting-outputs
// root flutter packages pub run build_runner build watch

import 'dart:convert';

import 'package:flutter/painting.dart';
import 'package:json_annotation/json_annotation.dart';

import 'FBColorProperty.dart';

part 'FBBorderSideProperty.g.dart';

// root flutter packages pub run build_runner build --delete-conflicting-outputs
// root flutter packages pub run build_runner build watch

@JsonSerializable()
class FBBorderSideProperty {
  FBColorProperty? colorProperty;
  double? width;
  BorderStyle? style;

  FBBorderSideProperty({this.colorProperty, this.width, this.style});

  Map<String, dynamic> toJson() => _$FBBorderSidePropertyToJson(this);

  factory FBBorderSideProperty.fromJsonString(String s) {
    return FBBorderSideProperty.fromJson(jsonDecode(s));
  }

  factory FBBorderSideProperty.fromJson(Map<String, dynamic> json) =>
      _$FBBorderSidePropertyFromJson(json);

  BorderSide toBorderSide() {
    return BorderSide(
        color: colorProperty?.toColor() ?? const Color(0xFF000000),
        width: width ?? 1.0,
        style: style ?? BorderStyle.none);
  }

  String getJsonString() {
    return jsonEncode(this.toJson());
  }
}
