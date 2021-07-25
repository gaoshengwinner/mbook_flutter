import 'dart:core';

import 'package:mbook_flutter/src/comm/consts.dart';

class Option extends Object {
  String _title = "";
  String _price = "";
  bool _selected = false;
  DateTime? selectedTime;

  String get title {
    return _title;
  }

  set title(String? title) {
    _title = title ?? "";
  }

  String get price {
    return _price;
  }

  set price(String? price) {
    _price = price ?? "";
  }

  bool get selected {
    return _selected;
  }

  set selected(bool? selected) {
    _selected = selected ?? false;
    if (_selected) {
      selectedTime = DateTime.now();
    } else {
      selectedTime = null;
    }
  }

  Option({String? title, String? price, bool? selected}) {
    this._title = title ?? "";
    this._price = price ?? "";
    this._selected = selected ?? false;
    if (_selected) {
      selectedTime = DateTime.now();
    } else {
      selectedTime = null;
    }
  }
}

class OptionGroupInfo extends Object {
  String? _title;
  String? _description;
  int? _mustSelectMin;
  int? _mustSelectMax;
  int? _lineDispCount;
  int? _optionTempId;
  List<Option>? _options;

  String get description{
    return G.ifNull(_description, "");
  }
  set description(String? description){
    this._description = description;
  }
  String get title{
    return G.ifNull(_title, "");
  }
  set title(String? title){
    this._title = title;
  }
  int get mustSelectMin{
    return G.ifNull(_mustSelectMin, 0);
  }
  set mustSelectMin(int? mustSelectMin){
    this._mustSelectMin = mustSelectMin;
  }
  int get mustSelectMax{
    return G.ifNull(_mustSelectMax, 1);
  }
  set mustSelectMax(int? mustSelectMax){
    this._mustSelectMax = mustSelectMax;
  }
  int? get lineDispCount{
    return _lineDispCount;
  }
  set lineDispCount(int? lineDispCount){
    this._lineDispCount = lineDispCount;
  }
  int? get optionTempId{
    return _optionTempId;
  }
  set optionTempId(int? optionTempId){
    this._optionTempId = optionTempId;
  }
  List<Option> get options{
    if (_options == null) {
      _options = [];
    }
    return _options!;
  }
  set options(List<Option>? options){
    this._options = options ?? [];
  }

  OptionGroupInfo({
    String? description,
    String? title,
    int? mustSelectMin,
    int? lineDispCount,
    int? optionTempId,
    int? mustSelectMax,
    List<Option>? options,
  }){
    this._title = title;
    this._description = description;
    this._mustSelectMin = mustSelectMin;
    this._lineDispCount = lineDispCount;
    this._optionTempId = optionTempId;
    this._mustSelectMax = mustSelectMax;
    this._options = options ?? [];
  }

  factory OptionGroupInfo.temp() {
    List<Option> options = [];
    options.add(Option(title: "並盛", price: "", selected: true));
    options.add(Option(title: "大盛", price: "", selected: false));
    options.add(Option(title: "特盛", price: "", selected: false));

    return OptionGroupInfo(
        title: "サイズ変更",
        mustSelectMin: 1,
        mustSelectMax: 2,
        lineDispCount: null,
        options: options);
  }

  bool get selectIsOK {
    if (options.isEmpty) {
      return false;
    }
    var count = 0;
    for (var i = 0; i < options.length; i++) {
      if (options[i].selected) {
        count++;
      }
    }
    return count >= (mustSelectMin) &&
        count <= (mustSelectMax);
  }

  OptionGroupInfo copyWith() {
    OptionGroupInfo copy = OptionGroupInfo(title: this.title);
    return copy;
  }
}
