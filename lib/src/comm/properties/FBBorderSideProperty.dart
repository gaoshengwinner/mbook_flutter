// root flutter packages pub run build_runner build --delete-conflicting-outputs
// root flutter packages pub run build_runner build watch

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mbook_flutter/src/comm/model/base_json_converter.dart';


part 'FBBorderSideProperty.g.dart';

// root flutter packages pub run build_runner build --delete-conflicting-outputs
// root flutter packages pub run build_runner build watch

@JsonSerializable()
@CustomColorNullSafeConverter()
class FBBorderSideProperty {
  Color? color = Colors.white;
  double? width;
  BorderStyle? style;

  FBBorderSideProperty({this.color, this.width, this.style});

  Map<String, dynamic> toJson() => _$FBBorderSidePropertyToJson(this);

  factory FBBorderSideProperty.fromJsonString(String s) {
    return FBBorderSideProperty.fromJson(jsonDecode(s));
  }

  factory FBBorderSideProperty.fromJson(Map<String, dynamic> json) =>
      _$FBBorderSidePropertyFromJson(json);

  BorderSide toBorderSide() {
    return width == null || width == null
        ? BorderSide.none
        : BorderSide(
            color: color ?? const Color(0xFF000000),
            width: width!,
            style: style ?? BorderStyle.solid);
  }

  String getJsonString() {
    return jsonEncode(this.toJson());
  }
}

