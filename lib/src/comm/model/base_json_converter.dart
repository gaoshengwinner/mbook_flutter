
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

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

class CustomColorNullSafeConverter implements JsonConverter<Color?, String> {
  const CustomColorNullSafeConverter();

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
  String toJson(Color? json) {
    return "R=${json?.red ?? 0};B=${json?.blue ?? 0};G=${json?.green ?? 0};O=${json?.opacity ?? 0};";
  }
}
