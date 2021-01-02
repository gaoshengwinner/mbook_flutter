import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'ShopInfo.g.dart';

// cd /Users/zhengyuehua/Documents/WORK/mBook/mbook_flutter/
// root flutter packages pub run build_runner build
// root flutter packages pub run build_runner build watch
@JsonSerializable()
class ShopInfo{
  String shopName;

  String  shopAddr;

  String  shopTel;

  String  shopPicUrl;

  ShopInfo(this.shopName, this.shopAddr, this.shopTel, this.shopPicUrl);

  factory ShopInfo.fromJson(Map<String, dynamic> json) =>
      _$ShopInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ShopInfoToJson(this);

  String getJsonString() {
    return jsonEncode(this.toJson());
  }
}