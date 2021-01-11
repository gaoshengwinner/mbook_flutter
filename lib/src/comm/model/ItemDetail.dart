import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'ItemDetail.g.dart';

// root flutter packages pub run build_runner build
// root flutter packages pub run build_runner build watch
@JsonSerializable()
class ItemDetail {
  int id;
  int shopId;
  String itemPrice;
  String itemName;
  String itemDescr;
  String itemMainPicUrl;
  String itemDispDetail;

  ItemDetail(this.id, this.itemPrice, this.itemName, this.itemDescr,
      this.itemMainPicUrl,this.itemDispDetail);

  factory ItemDetail.fromJson(Map<String, dynamic> json) =>
      _$ItemDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ItemDetailToJson(this);

  String getJsonString() {
    return jsonEncode(this.toJson());
  }
}
