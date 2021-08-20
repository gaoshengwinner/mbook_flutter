import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mbook_flutter/src/comm/properties/FBBorderSideProperty.dart';

part 'FBTableBorderProperty.g.dart';

@JsonSerializable()
class FBTableBorderProperty {
  final FBBorderSideProperty? top;
  final FBBorderSideProperty? right;
  final FBBorderSideProperty? bottom;
  final FBBorderSideProperty? left;
  final FBBorderSideProperty? horizontalInside;
  final FBBorderSideProperty? verticalInside;

  FBTableBorderProperty({this.top, this.right, this.bottom, this.left,
      this.horizontalInside, this.verticalInside});


  Map<String, dynamic> toJson() => _$FBTableBorderPropertyToJson(this);

  factory FBTableBorderProperty.fromJson(Map<String, dynamic> json) =>
      _$FBTableBorderPropertyFromJson(json);

  factory FBTableBorderProperty.fromJsonString(String s) {
    return FBTableBorderProperty.fromJson(jsonDecode(s));
  }

  String getJsonString() {
    return jsonEncode(this.toJson());
  }
}
