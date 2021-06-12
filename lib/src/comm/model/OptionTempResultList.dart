import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:mbook_flutter/src/comm/model/OptionTemp.dart';

part 'OptionTempResultList.g.dart';

@JsonSerializable()
class OptionTempResultList {
  List<OptionTemp> optionTempLst;

  OptionTempResultList({this.optionTempLst}) ;

  factory OptionTempResultList.fromJson(Map<String, dynamic> json) =>
      _$OptionTempResultListFromJson(json);

  Map<String, dynamic> toJson() {
    return _$OptionTempResultListToJson(this);
  }

  @override
  String toString() {
    return getJsonString();
  }

  String getJsonString() {
    return jsonEncode(this.toJson());
  }

}
