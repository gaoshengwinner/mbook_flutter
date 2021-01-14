
import 'package:flutter/material.dart';

class ListHelper {

  List<Text> _list;
  List<int> _values;
  int b = 1;
  int beginNumber = 0;
  int endNumber = 0;
  String pre="";
  String tral="";

  ListHelper(this.beginNumber, this.endNumber, {this.b = 1, this.pre = "", this.tral = ""}) {
    int tmp = beginNumber;
    _list = [];
    _values = [];
    int i = 0;
    while(tmp <= endNumber){
      _values.add(tmp);
      _list.add(Text("${pre}${tmp}${tral}"));
      i++;
      tmp = beginNumber + b*i;
    }
  }

  list(){
    return _list;
  }
  values(){
    return _values;
  }
  getIndexByValue(int dbValue){
    int serchS = dbValue.toInt();
    for(int i=0; i<_values.length; i++){
      if (_values[i] == serchS){
        return i;
      }
    }
    return 0;
  }

}