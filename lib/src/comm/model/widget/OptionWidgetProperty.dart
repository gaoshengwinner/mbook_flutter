import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:mbook_flutter/src/comm/extension/extension.dart';
import 'package:mbook_flutter/src/comm/global.dart';
import 'package:mbook_flutter/src/comm/model/widget/TextWidgetProperty.dart';
import 'package:mbook_flutter/src/comm/tools/wh_picker.dart';

part 'OptionWidgetProperty.g.dart';

@JsonSerializable()
@CustomColorConverter()
@CustomTextWidgetPropertyConverter()
class OptionWidgetProperty {
  factory OptionWidgetProperty.init() {
    const double defalutspace = 5;

    TextWidgetProperty framPr = TextWidgetProperty(
        paddingLeft: defalutspace,
        paddingTop: defalutspace,
        paddingRight: defalutspace,
        paddingBottom: defalutspace,
        spacingHWidth: defalutspace,
        spacingVWidth: defalutspace,
        minWidth: 100,
        minWidthUnit: enumToString(WHOptin.sw));
    TextWidgetProperty titlePr = TextWidgetProperty(paddingLeft: defalutspace, fontWeight: 700);
    TextWidgetProperty buttonPr = TextWidgetProperty(
        alignment: FBAlignment.CENTER,
        backalignment: FBAlignment.CENTER,
        borderWidth: 1,
        borderColor: Color.fromRGBO(224, 224, 224, 1),
        minHeight: 50,
        minWidth: 100,
        minWidthUnit: enumToString(WHOptin.sw));
    TextWidgetProperty buttonSelectPr = buttonPr.copy();
    buttonSelectPr.borderColor = G.appBaseColor[0];
    OptionWidgetProperty me = OptionWidgetProperty(framPr:framPr, titlePr:titlePr, buttonPr:buttonPr, buttonSelectPr:buttonSelectPr );
    return me;
  }

  OptionWidgetProperty copy() {
    print(toJson());
    return OptionWidgetProperty.fromJson(toJson());
  }

  OptionWidgetProperty(
      {required this.titlePr, required this.framPr, required this.buttonPr, required this.buttonSelectPr}){

  }

  factory OptionWidgetProperty.fromJson(Map<String, dynamic> json) =>
      _$OptionWidgetPropertyFromJson(json);

  Map<String, dynamic> toJson() => _$OptionWidgetPropertyToJson(this);

  String getJsonString() {
    return jsonEncode(this.toJson());
  }

  TextWidgetProperty framPr = TextWidgetProperty();
  TextWidgetProperty titlePr = TextWidgetProperty();
  TextWidgetProperty buttonPr = TextWidgetProperty();
  TextWidgetProperty buttonSelectPr = TextWidgetProperty();
}

// class FrameProperty {
//   Color backColor = Colors.white;
//
//   FrameProperty({this.backColor});
// }

// class OptionBean {
//   String mainTitle;
//   String subTitle;
//   int price;
// }

class CustomTextWidgetPropertyConverter
    implements JsonConverter<TextWidgetProperty, String> {
  const CustomTextWidgetPropertyConverter();

  @override
  TextWidgetProperty fromJson(String json) {
    return TextWidgetProperty.fromJson(jsonDecode(json));
  }

  @override
  String toJson(TextWidgetProperty object) {
    return object.getJsonString();
  }
}
