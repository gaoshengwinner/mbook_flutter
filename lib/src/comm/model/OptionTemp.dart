import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:mbook_flutter/src/comm/model/widget/OptionWidgetProperty.dart';
import 'package:uuid/uuid.dart';

part 'OptionTemp.g.dart';

@JsonSerializable()
class OptionTemp {
  // int? id;
  // String? desc;
  // String? propertyString;
  // int? orders;
  // int? defaultLineCount;

  int? _id;
  String? _desc;
  String? _propertyString;
  int? _orders;
  int? _defaultLineCount;

  OptionTemp copy() {
    return OptionTemp.fromJson(toJson());
  }

  @JsonKey(ignore: true)
  OptionWidgetProperty get property {
    if (propertyString.isEmpty) {
      return OptionWidgetProperty.init();
    } else {
      return OptionWidgetProperty.fromJson(jsonDecode(propertyString));
    }
  }
  set property(OptionWidgetProperty? property){
    if (property == null){
      this._propertyString = "";
    } else {
      this._propertyString = jsonEncode(property.toJson());
    }
  }

  @JsonKey(ignore: true)
  String? uuid;

  OptionTemp(
      {int? id,
      String? desc,
      String? propertyString,
      int? orders,
      int? defaultLineCount}) {
    this._id = id;
    this._desc = desc;
    this._propertyString = propertyString;
    this._orders = orders;
    this._defaultLineCount = defaultLineCount;
    if (propertyString?.isEmpty ?? true) {
      property = OptionWidgetProperty.init();
    } else {
      property = OptionWidgetProperty.fromJson(jsonDecode(propertyString!));
    }
    uuid = Uuid().v1();
  }

  set id(int? id) => _id = id;

  int get id {
    return _id ?? -1;
  }

  set desc(String? desc) => _desc = desc;

  String get desc {
    return _desc ?? "";
  }

  set propertyString(String? propertyString) {
    _propertyString = propertyString;
    if (propertyString?.isEmpty ?? true) {
      property = OptionWidgetProperty.init();
    } else {
      property = OptionWidgetProperty.fromJson(jsonDecode(_propertyString!));
    }
  }

  String get propertyString {
    return _propertyString ?? "";
  }

  set orders(int? orders) => _orders = orders;

  int get orders {
    return _orders ?? 0;
  }

  set defaultLineCount(int? defaultLineCount) =>
      _defaultLineCount = defaultLineCount;

  int get defaultLineCount {
    return _defaultLineCount ?? 3;
  }

  factory OptionTemp.fromJson(Map<String, dynamic> json) =>
      _$OptionTempFromJson(json);

  Map<String, dynamic> toJson() {
    beForToJson();
    return _$OptionTempToJson(this);
  }

  @override
  String toString() {
    return getJsonString();
  }

  String getJsonString() {
    return jsonEncode(this.toJson());
  }

  void beForToJson() {
    this.propertyString = jsonEncode(property.toJson());
  }

  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is OptionTemp &&
        o.id == id &&
        o.uuid == uuid &&
        o.property.toJson() == property.toJson();
  }

  @override
  int get hashCode => super.hashCode;
}
