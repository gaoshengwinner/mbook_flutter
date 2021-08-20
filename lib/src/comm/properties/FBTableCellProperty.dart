import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

// root flutter packages pub run build_runner build --delete-conflicting-outputs
// root flutter packages pub run build_runner build watch
part 'FBTableCellProperty.g.dart';
@JsonSerializable()
class FBTableCellProperty {
  double width = 1;
  TableCellVerticalAlignment? verticalAlignment;

  FBTableCellProperty({required this.width, this.verticalAlignment});

  Map<String, dynamic> toJson() => _$FBTableCellPropertyToJson(this);

  factory FBTableCellProperty.fromJsonString(String s) {
    return FBTableCellProperty.fromJson(jsonDecode(s));
  }

  factory FBTableCellProperty.fromJson(Map<String, dynamic> json) =>
      _$FBTableCellPropertyFromJson(json);

  String getJsonString() {
    return jsonEncode(this.toJson());
  }

}
