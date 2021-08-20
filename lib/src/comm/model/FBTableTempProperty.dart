import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:mbook_flutter/src/comm/extension/extension_color.dart';
import 'package:mbook_flutter/src/comm/model/widget/TextWidgetProperty.dart';
import 'package:mbook_flutter/src/comm/properties/FBBorderSideProperty.dart';
import 'package:mbook_flutter/src/comm/properties/FBBoxDecorationProperty.dart';
import 'package:mbook_flutter/src/comm/properties/FBColorProperty.dart';
import 'package:mbook_flutter/src/comm/properties/FBTableCellProperty.dart';
import 'package:mbook_flutter/src/comm/properties/FBTableProperty.dart';

part 'FBTableTempProperty.g.dart';

// root flutter packages pub run build_runner build --delete-conflicting-outputs
// root flutter packages pub run build_runner build watch

enum FBWidegetType { text, img }

@JsonSerializable()
class FBTableTempProperty {
  String? desc;

  TextWidgetProperty outSide;
  FBTableProperty? property;

  List<RowSet>? rowSet;

  FBTableTempProperty({this.desc, required this.outSide, this.property, this.rowSet});

  factory FBTableTempProperty.fromJson(Map<String, dynamic> json) =>
      _$FBTableTempPropertyFromJson(json);

  factory FBTableTempProperty.fromJsonString(String json) {
    return FBTableTempProperty.fromJson(jsonDecode(json));
  }

  Map<String, dynamic> toJson() => _$FBTableTempPropertyToJson(this);

  String getJsonString() {
    return jsonEncode(this.toJson());
  }
}

@JsonSerializable()
class OutSideProperty {
  FBColorProperty? backColor;

  FBBorderSideProperty? leftBorder;
  FBBorderSideProperty? topBorder;
  FBBorderSideProperty? rightBorder;
  FBBorderSideProperty? bottomBorder;
  double? borderRadiusTopLeft;
  double? borderRadiusTopRight;
  double? borderRadiusBottomRight;
  double? borderRadiusBottomLeft;

  OutSideProperty(
      {this.backColor,
      this.leftBorder,
      this.topBorder,
      this.rightBorder,
      this.bottomBorder,
      this.borderRadiusTopLeft,
      this.borderRadiusBottomLeft,
      this.borderRadiusBottomRight,
      this.borderRadiusTopRight});

  factory OutSideProperty.fromJson(Map<String, dynamic> json) =>
      _$OutSidePropertyFromJson(json);

  Map<String, dynamic> toJson() => _$OutSidePropertyToJson(this);

  String getJsonString() {
    return jsonEncode(this.toJson());
  }
}

@JsonSerializable()
class RowSet {
  FBBoxDecorationProperty? property;
  List<CellSet>? cellSet;

  RowSet({this.property, this.cellSet});

  factory RowSet.fromJson(Map<String, dynamic> json) => _$RowSetFromJson(json);

  Map<String, dynamic> toJson() => _$RowSetToJson(this);

  String getJsonString() {
    return jsonEncode(this.toJson());
  }
}

@JsonSerializable()
class CellSet {
  FBTableCellProperty? property;
  List<FBWidget>? fbWidget;

  CellSet({this.property, this.fbWidget});

  factory CellSet.fromJson(Map<String, dynamic> json) =>
      _$CellSetFromJson(json);

  Map<String, dynamic> toJson() => _$CellSetToJson(this);

  String getJsonString() {
    return jsonEncode(this.toJson());
  }
}

@JsonSerializable()
class FBWidget {
  FBWidegetType? type = FBWidegetType.text;

  String? value = "TODO";

  FBWidget({this.type, this.value});

  factory FBWidget.fromJson(Map<String, dynamic> json) =>
      _$FBWidgetFromJson(json);

  Map<String, dynamic> toJson() => _$FBWidgetToJson(this);

  String getJsonString() {
    return jsonEncode(this.toJson());
  }
}
