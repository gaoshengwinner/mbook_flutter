import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:mbook_flutter/src/comm/model/widget/TextWidgetProperty.dart';
import 'package:uuid/uuid.dart';

part 'TagInfo.g.dart';

@JsonSerializable()
class TagInfo {
  int? id;
  String? data;
  String? desc;
  String? propertyString;
  int? orders;
  @JsonKey(ignore: true)
  TextWidgetProperty? property;
  @JsonKey(ignore: true)
  String? uuid;

  TagInfo copy() {
    return TagInfo.fromJson(toJson());
  }

  TagInfo({this.id, this.data, this.desc, this.propertyString}) {
    if (propertyString?.isEmpty ?? true) {
      property = TextWidgetProperty();
    } else {
      property = TextWidgetProperty.fromJson(jsonDecode(propertyString!));
    }
    uuid = Uuid().v1();
  }

  factory TagInfo.fromJson(Map<String, dynamic> json) =>
      _$TagInfoFromJson(json);

  Map<String, dynamic> toJson() {
    beForToJson();
    return _$TagInfoToJson(this);
  }

  @override
  String toString() {
    return getJsonString();
  }

  String getJsonString() {
    return jsonEncode(this.toJson());
  }

  void beForToJson() {
    this.propertyString = jsonEncode(property!.toJson());
  }

  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    beForToJson();
    (o as TagInfo).beForToJson();
    return o is TagInfo &&
        o.id == id &&
        o.data == data &&
        o.desc == desc &&
        //o.uuid == uuid &&
        o.propertyString == propertyString;
  }

  @override
  int get hashCode => super.hashCode;
}
