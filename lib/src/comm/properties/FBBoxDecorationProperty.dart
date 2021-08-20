// root flutter packages pub run build_runner build --delete-conflicting-outputs
// root flutter packages pub run build_runner build watch

import 'dart:convert';

import 'package:flutter/painting.dart';
import 'package:json_annotation/json_annotation.dart';

import 'FBColorProperty.dart';

part 'FBBoxDecorationProperty.g.dart';

// root flutter packages pub run build_runner build --delete-conflicting-outputs
// root flutter packages pub run build_runner build watch

@JsonSerializable()
class FBBoxDecorationProperty {
  FBColorProperty? color;
  double? topLeft;
  double? topRight;
  double? bottomLeft;
  double? bottomRight;

  BoxDecoration toBoxDecoration() {
    return BoxDecoration(
        color: color?.toColor(),
        borderRadius: BorderRadius.only(
          topLeft: topLeft == null ? Radius.zero : Radius.circular(topLeft!),
          topRight: topRight == null ? Radius.zero : Radius.circular(topRight!),
          bottomLeft:
              bottomLeft == null ? Radius.zero : Radius.circular(bottomLeft!),
          bottomRight:
              bottomRight == null ? Radius.zero : Radius.circular(bottomRight!),
        ));
  }

  FBBoxDecorationProperty({this.color, this.topLeft, this.topRight, this.bottomLeft, this.bottomRight});

  Map<String, dynamic> toJson() => _$FBBoxDecorationPropertyToJson(this);

  factory FBBoxDecorationProperty.fromJsonString(String s) {
    return FBBoxDecorationProperty.fromJson(jsonDecode(s));
  }

  factory FBBoxDecorationProperty.fromJson(Map<String, dynamic> json) =>
      _$FBBoxDecorationPropertyFromJson(json);


  String getJsonString() {
    return jsonEncode(this.toJson());
  }
}
