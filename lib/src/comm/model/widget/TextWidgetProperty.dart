import 'dart:ui';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mbook_flutter/src/comm/extension/extension.dart';

part 'TextWidgetProperty.g.dart';

@JsonSerializable()
@CustomColorConverter()
class TextWidgetProperty {
  bool fullLineDisp = false;
  Color textColor = Colors.black;
  Color backColor = Colors.white;
  double fontSize = 14;
  int fontWeight = 400;
  bool italic = false;
  double letterSpacing = 0;
  double paddingLeft = 0;
  double paddingTop = 0;
  double paddingRight = 0;
  double paddingBottom = 0;

  String textTextAlign = TextAlign.left.toShortString();

  double borderWidth = 0;
  Color borderColor = const Color(0xFF000000);
  double borderRadiusTopLeft = 0;
  double borderRadiusTopRight = 0;
  double borderRadiusBottomLeft = 0;
  double borderRadiusBottomRight = 0;

  Color shadowColor = Colors.transparent;
  double shadowOffsetX = 0.0;
  double shadowOffsetY = 0.0;
  double shadowBlurRadius = 0.0;
  double shadowSpreadRadius = 0.0;

  double minWidth = 0;
  double minHeight = 0;
  double maxWidth = 0;
  double maxHeight = 0;

  String alignment = FBAlignment.DEFALUT_ALIGM;

  TextWidgetProperty(
      {this.fullLineDisp = false,
      this.textColor = Colors.black,
      this.backColor = Colors.white,
      this.fontSize = 14,
      this.fontWeight = 400,
      this.italic = false,
      this.letterSpacing = 0,
      this.paddingLeft = 0,
      this.paddingTop = 0,
      this.paddingRight = 0,
      this.paddingBottom = 0,
      this.textTextAlign = "left",
      this.borderWidth = 0,
      this.borderColor = const Color(0xFF000000),
      this.borderRadiusTopLeft = 0,
      this.borderRadiusTopRight = 0,
      this.borderRadiusBottomLeft = 0,
      this.borderRadiusBottomRight = 0,
      this.shadowColor = const Color(0xFF000000),
      this.shadowOffsetX = 0.0,
      this.shadowOffsetY = 0.0,
      this.shadowBlurRadius = 0.0,
      this.shadowSpreadRadius = 0.0,
      this.minWidth = 0,
      this.minHeight = 0,
      this.maxWidth = 0,
      this.maxHeight = 0,
      this.alignment = "-"});

  factory TextWidgetProperty.fromJson(Map<String, dynamic> json) =>
      _$TextWidgetPropertyFromJson(json);

  TextWidgetProperty copy(){
    return TextWidgetProperty.fromJson(toJson());
  }

  Map<String, dynamic> toJson() => _$TextWidgetPropertyToJson(this);
}

class CustomColorConverter implements JsonConverter<Color, String> {
  const CustomColorConverter();

  @override
  Color fromJson(String json) {
    if (json == null || json == "" ) {
      return null;
    }
    List<String> values = json.split(";");
    Map<String, String> map = Map();
    for (String s in values) {
      if ("" != s) {
        List<String> sv = s.split("=");
        map[sv[0]] = sv[1];
      }
    }

    return Color.fromRGBO(int.parse(map["R"]), int.parse(map["G"]),
        int.parse(map["B"]), double.parse(map["O"]));
  }

  @override
  String toJson(Color json) {
    return "R=${json.red};B=${json.blue};G=${json.green};O=${json.opacity};";
  }
}
