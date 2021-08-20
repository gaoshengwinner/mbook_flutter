import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mbook_flutter/src/comm/extension/extension_text_align.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/tools/wh_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'TextWidgetProperty.g.dart';

const String unitPX = "px";

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

  double? borderWidth = 0;
  Color borderColor = const Color(0xFF000000);

  // Color borderColorTop = const Color(0xFF000000);
  // Color borderColorRight = const Color(0xFF000000);
  // Color borderColorBottom = const Color(0xFF000000);
  double borderRadiusTopLeft = 0;
  double borderRadiusTopRight = 0;
  double borderRadiusBottomLeft = 0;
  double borderRadiusBottomRight = 0;

  Color shadowColor = Colors.transparent;
  double shadowOffsetX = 0.0;
  double shadowOffsetY = 0.0;
  double shadowBlurRadius = 0.0;
  double shadowSpreadRadius = 0.0;

  double? width;
  WHOption? widthUnit = WHOption.px;
  double? height;
  WHOption? heightUnit = WHOption.px;
  double? minWidth = 0;
  WHOption? minWidthUnit = WHOption.px;
  double minHeight = 0;
  WHOption? minHeightUnit = WHOption.px;
  WHOption? maxHeightUnit = WHOption.px;
  double? maxWidth = 0;
  WHOption? maxWidthUnit = WHOption.px;
  double? maxHeight = 0;

  double marginLeft = 0;
  double marginTop = 0;
  double marginRight = 0;
  double marginBottom = 0;

  String alignment = FBAlignment.DEFAULT_ALIGM;

  String backalignment = FBAlignment.DEFAULT_ALIGM;

  Color spacingColor = Colors.white;
  double spacingHWidth = 0;
  double spacingVWidth = 0;

  String backImg = "";

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
      this.minWidthUnit = WHOption.px,
      this.minHeight = 0,
      this.minHeightUnit = WHOption.px,
      this.maxWidth = 0,
      this.maxHeight = 0,
      this.alignment = "-",
      this.backalignment = "-",
      this.marginLeft = 0,
      this.marginTop = 0,
      this.marginRight = 0,
      this.marginBottom = 0,
      this.backImg = "",
      this.spacingHWidth = 0,
      this.spacingVWidth = 0,
      this.spacingColor = Colors.transparent,
      this.width,
      this.widthUnit = WHOption.px,
      this.height});

  String getJsonString() {
    return jsonEncode(this.toJson());
  }

  double? getRealMinWidth() {
    return minWidth == null
        ? null
        : (this.minWidth! <= 0
            ? 0
            : this.minWidthUnit == WHOption.px
                ? this.minWidth
                : this.minWidthUnit == WHOption.sw
                    ? this.minWidth! * 0.01 * 1.sw
                    : this.minWidth! * 0.01 * 1.sh);
  }

  double? getRealWidth() {
    return this.width == null || this.width! <= 0
        ? null
        : this.widthUnit == WHOption.px
            ? this.width
            : this.widthUnit == WHOption.sw
                ? this.width! * 0.01 * 1.sw
                : this.width! * 0.01 * 1.sh;
  }

  double? getRealHeight() {
    return this.height == null || this.height! <= 0
        ? null
        : this.heightUnit == WHOption.px
            ? this.height
            : this.heightUnit == WHOption.sw
                ? this.height! * 0.01 * 1.sw
                : this.height! * 0.01 * 1.sh;
  }

  double getRealMinHeight() {
    return this.minHeight <= 0
        ? 0
        : this.minHeightUnit == WHOption.px
            ? this.minHeight
            : this.minHeightUnit == WHOption.sw
                ? this.minHeight * 0.01 * 1.sw
                : this.minHeight * 0.01 * 1.sh;
  }

  double? getRealMaxWidth() {
    return maxWidth == null
        ? null
        : (this.maxWidth! <= 0
            ? double.infinity
            : this.maxHeightUnit == WHOption.px
                ? this.maxWidth
                : this.maxHeightUnit == WHOption.sw
                    ? this.maxWidth! * 0.01 * 1.sw
                    : this.maxWidth! * 0.01 * 1.sh);
  }

  double? getRealMaxHeight() {
    return this.maxHeight == null
        ? null
        : (this.maxHeight! <= 0
            ? double.infinity
            : this.maxHeightUnit == WHOption.px
                ? this.maxHeight
                : this.maxHeightUnit == WHOption.sw
                    ? this.maxHeight! * 0.01 * 1.sw
                    : this.maxHeight! * 0.01 * 1.sh);
  }

  factory TextWidgetProperty.fromJson(Map<String, dynamic> json) =>
      _$TextWidgetPropertyFromJson(json);

  TextWidgetProperty copy() {
    return TextWidgetProperty.fromJson(toJson());
  }

  Map<String, dynamic> toJson() => _$TextWidgetPropertyToJson(this);
}

class CustomColorConverter implements JsonConverter<Color, String> {
  const CustomColorConverter();

  @override
  Color fromJson(String json) {
    if (json.isEmpty) {
      return Colors.white;
    }
    List<String> values = json.split(";");
    Map<String, String> map = Map();
    for (String s in values) {
      if ("" != s) {
        List<String> sv = s.split("=");
        map[sv[0]] = sv[1];
      }
    }

    return Color.fromRGBO(int.parse(map["R"]!), int.parse(map["G"]!),
        int.parse(map["B"]!), double.parse(map["O"]!));
  }

  @override
  String toJson(Color json) {
    return "R=${json.red};B=${json.blue};G=${json.green};O=${json.opacity};";
  }
}
