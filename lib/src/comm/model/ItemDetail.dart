import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:mbook_flutter/src/comm/model/TagInfo.dart';

import 'AdditionalMana.dart';

part 'ItemDetail.g.dart';

// root flutter packages pub run build_runner build
// root flutter packages pub run build_runner build watch
@JsonSerializable()
class ItemDetail {
  int? id;
  int? shopId;
  String? itemPrice;
  String? itemName;
  String? itemDescr;
  String? itemMainPicUrl;
  String? itemDispDetail;
  List<TagInfo>? tags = [];

  String?  additionInfo;

  ItemDetail({this.id, this.itemPrice, this.itemName, this.itemDescr,
      this.itemMainPicUrl,this.itemDispDetail, this.tags, this.additionInfo}){
    if (this.tags == null){
      this.tags = [];
    }
    getMana();
  }
  AdditionalMana? _additionalMana;
  AdditionalMana getMana(){
    _additionalMana = AdditionalMana.fromJsonString(additionInfo);
    return _additionalMana!;
  }

  factory ItemDetail.newItem(){
    return ItemDetail(id:null, itemPrice: "", itemName: "", itemDescr:"",itemMainPicUrl:"", itemDispDetail:"");
  }
  factory ItemDetail.fromJson(Map<String, dynamic> json) =>
      _$ItemDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ItemDetailToJson(this);

  String getJsonString() {
    additionInfo = _additionalMana == null ? "" : _additionalMana!.getJsonString();
    return jsonEncode(this.toJson());
  }
}
