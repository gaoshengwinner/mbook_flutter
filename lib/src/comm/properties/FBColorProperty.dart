// root flutter packages pub run build_runner build --delete-conflicting-outputs
// root flutter packages pub run build_runner build watch

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FBColorProperty.g.dart';

@JsonSerializable()
class FBColorProperty {
  int? R;
  int? B;
  int? G;
  double? O;

  FBColorProperty({this.R, this.B, this.G, this.O});

  FBColorProperty.fromColor({Color? color}) {
    this.R = color?.red ?? 0;
    this.B = color?.blue ?? 0;
    this.G = color?.green ?? 0;
    this.O = color?.opacity ?? 0;
  }

  Map<String, dynamic> toJson() => _$FBColorPropertyToJson(this);

  factory FBColorProperty.fromJson(Map<String, dynamic> json) =>
      _$FBColorPropertyFromJson(json);

  factory FBColorProperty.fromJsonString(String s) {
    return FBColorProperty.fromJson(jsonDecode(s));
  }

  Color toColor() {
    return Color.fromRGBO(R ?? Colors.white.red, G ?? Colors.white.green,
        B ?? Colors.white.blue, O ?? Colors.white.opacity);
  }

  String getJsonString() {
    return jsonEncode(this.toJson());
  }
}
