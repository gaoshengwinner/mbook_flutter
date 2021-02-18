import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'ItemOptionList.g.dart';

// root flutter packages pub run build_runner build
// root flutter packages pub run build_runner build watch
@JsonSerializable()
class ItemOptionList {
  ItemOptionList(
      {this.canMultSelect = false,
      this.title,
      this.delefalutSelectId,
      this.options});

  bool canMultSelect = false;
  String title = "";
  List<int> delefalutSelectId = [];
  List<ItemOption> options = [];

  factory ItemOptionList.forTemp() {
    List<ItemOption> options = [];
    options.add(ItemOption(
        title: "Option a",
        prePriceString: "",
        price: 100,
        nexPriceString: "¥"));
    options.add(ItemOption(
        title: "Option b",
        prePriceString: "",
        price: -50,
        nexPriceString: "¥"));
    options.add(ItemOption(
        title: "Option c", prePriceString: "", price: 0, nexPriceString: "¥"));
    options.add(ItemOption(
        title: "Option d", prePriceString: "", price: 0, nexPriceString: "¥"));

    options.add(ItemOption(
        title: "Option e", prePriceString: "", price: 0, nexPriceString: "¥"));

    return ItemOptionList(title: "Choose your favorite.", options: options);
  }

  factory ItemOptionList.fromJson(Map<String, dynamic> json) =>
      _$ItemOptionListFromJson(json);

  Map<String, dynamic> toJson() {
    return _$ItemOptionListToJson(this);
  }

  @override
  String toString() {
    return getJsonString();
  }

  String getJsonString() {
    return jsonEncode(this.toJson());
  }
}

@JsonSerializable()
class ItemOption {
  ItemOption(
      {this.id,
      this.title,
      this.prePriceString,
      this.price,
      this.nexPriceString});

  int id;
  String title;
  String prePriceString;
  int price;
  String nexPriceString;

  String getPriceString() {
    if (price != 0) {
      String tmp = price > 0 ? "-" : "";
      return "${prePriceString}${tmp}${price}${nexPriceString}"; //prePriceString + price + nexPriceString;
    }
    return "";
  }

  factory ItemOption.fromJson(Map<String, dynamic> json) =>
      _$ItemOptionFromJson(json);

  Map<String, dynamic> toJson() {
    return _$ItemOptionToJson(this);
  }

  @override
  String toString() {
    return getJsonString();
  }

  String getJsonString() {
    return jsonEncode(this.toJson());
  }
}
