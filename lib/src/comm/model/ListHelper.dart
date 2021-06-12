import 'package:flutter/material.dart';

class ListHelper {
  List<Text> _list;
  List<int> _values;
  List<dynamic> _sValues;
  int b = 1;
  int beginNumber = 0;
  int endNumber = 0;
  String pre = "";
  String tral = "";

  ListHelper.byStringList(List<String> list, this._sValues){
    _list = [];
    for (int i=0; i<list.length; i++) {
      _list.add(Text(list[i]));
    }
  }

  int getIndexBySValue(String dbValue) {
    for (int i = 0; i < _values.length; i++) {
      if (_sValues[i] == "$this.pre$dbValue$tral") {
        return i;
      }
    }
    return 0;
  }

  ListHelper(this.beginNumber, this.endNumber,
      {this.b = 1, this.pre = "", this.tral = ""}) {
    int tmp = beginNumber;
    _list = [];
    _values = [];
    int i = 0;
    while (tmp <= endNumber) {
      _values.add(tmp);
      _list.add(Text("$pre$tmp$tral"));
      i++;
      tmp = beginNumber + b * i;
    }
  }

  list() {
    return _list;
  }

  values() {
    return _values;
  }

  sValues() {
    return _sValues;
  }

  int getIndexByValue(int dbValue) {
    int serchS = dbValue.toInt();
    for (int i = 0; i < _values.length; i++) {
      if (_values[i] == serchS) {
        return i;
      }
    }
    return 0;
  }
}
