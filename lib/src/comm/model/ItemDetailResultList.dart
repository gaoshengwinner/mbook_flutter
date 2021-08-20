import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:mbook_flutter/src/comm/model/ItemDetail.dart';

part 'ItemDetailResultList.g.dart';

@JsonSerializable()
class ItemDetailResultList {
  List<ItemDetail>? itemDetailLst;

  ItemDetailResultList({this.itemDetailLst}) ;

  factory ItemDetailResultList.fromJson(Map<String, dynamic> json) =>
      _$ItemDetailResultListFromJson(json);

  Map<String, dynamic> toJson() {
    return _$ItemDetailResultListToJson(this);
  }

  @override
  String toString() {
    return getJsonString();
  }

  String getJsonString() {
    return jsonEncode(this.toJson());
  }

}
