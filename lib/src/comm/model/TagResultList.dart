import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mbook_flutter/src/comm/model/TagInfo.dart';

part 'TagResultList.g.dart';

@JsonSerializable()
class TagResultList {
  List<TagInfo> tagLst;

  TagResultList({this.tagLst}) {
  }

  factory TagResultList.fromJson(Map<String, dynamic> json) =>
      _$TagResultListFromJson(json);

  Map<String, dynamic> toJson() {
    return _$TagResultListToJson(this);
  }

  @override
  String toString() {
    return getJsonString();
  }

  String getJsonString() {
    return jsonEncode(this.toJson());
  }

}
