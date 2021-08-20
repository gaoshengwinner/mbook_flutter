// root flutter packages pub run build_runner build --delete-conflicting-outputs
// root flutter packages pub run build_runner build watch

import 'dart:convert';
import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mbook_flutter/src/comm/properties/FBTableBorderProperty.dart';

part 'FBTableProperty.g.dart';

@JsonSerializable()
class FBTableProperty {
  TextDirection? textDirection;
  FBTableBorderProperty? border;
  TableCellVerticalAlignment? defaultVerticalAlignment;
  TextBaseline? textBaseline;
  FBTableProperty({this.textDirection, this.border, this.defaultVerticalAlignment, this.textBaseline});

  Map<String, dynamic> toJson() => _$FBTablePropertyToJson(this);

  factory FBTableProperty.fromJsonString(String s) {
    return FBTableProperty.fromJson(jsonDecode(s));
  }

  factory FBTableProperty.fromJson(Map<String, dynamic> json) =>
      _$FBTablePropertyFromJson(json);

  String getJsonString() {
    return jsonEncode(this.toJson());
  }
}
