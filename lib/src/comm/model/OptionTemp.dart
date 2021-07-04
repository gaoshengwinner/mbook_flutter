import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:mbook_flutter/src/comm/model/widget/OptionWidgetProperty.dart';
import 'package:uuid/uuid.dart';

part 'OptionTemp.g.dart';

@JsonSerializable()
class OptionTemp {
  int? id;
  String? desc;
  String? propertyString;
  int? orders;

  OptionTemp copy(){
    return OptionTemp.fromJson(toJson());
  }

  @JsonKey(ignore: true)
  OptionWidgetProperty? property;

  @JsonKey(ignore: true)
  String? uuid;

  OptionTemp({this.id, this.desc, this.propertyString}) {
    if (propertyString?.isEmpty ?? true) {
      property = OptionWidgetProperty.init();
    } else {
      property = OptionWidgetProperty.fromJson(jsonDecode(propertyString!));
    }
    uuid = Uuid().v1();
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

  void beForToJson(){
    this.propertyString = jsonEncode(property?.toJson());
  }

  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is OptionTemp &&
        o.id == id &&
        o.uuid == uuid &&
        o.property!.toJson() == property!.toJson();
  }

  @override
  int get hashCode => super.hashCode;

}
