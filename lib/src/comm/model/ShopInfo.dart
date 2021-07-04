import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:mbook_flutter/src/comm/model/AdditionalMana.dart';

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

  String?  additionInfo;

  ShopInfo({required this.shopName, required this.shopAddr, required this.shopTel, required this.shopPicUrl, this.additionInfo}){
    getMana();
  }

  factory ShopInfo.fromJson(Map<String, dynamic> json) =>
      _$ShopInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ShopInfoToJson(this);

  String getJsonString() {
    additionInfo = _additionalMana == null ? "" : _additionalMana!.getJsonString();
    return jsonEncode(this.toJson());
  }

  AdditionalMana? _additionalMana;
  AdditionalMana getMana(){
    _additionalMana = AdditionalMana.fromJsonString(additionInfo);
    return _additionalMana!;
  }

}