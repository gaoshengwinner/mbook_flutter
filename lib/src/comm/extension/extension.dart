import 'package:flutter/material.dart';

extension FBTextAlign on TextAlign {
  String toShortString() {
    return this.toString().split('.').last;
  }

  static List<Text> toTextList() {
    List<Text> tmp = [];
    for (TextAlign ta in TextAlign.values) {
      tmp.add(Text(ta.toString().split('.').last));
    }
    return tmp;
  }

  static List<String> toStringList() {
    List<String> tmp = [];
    for (TextAlign ta in TextAlign.values) {
      tmp.add(ta.toString().split('.').last);
    }
    return tmp;
  }

  static TextAlign getByString(String s) {
    for (TextAlign ta in TextAlign.values) {
      if (ta.toString().split('.').last == s) {
        return ta;
      }
    }

    return TextAlign.left;
  }

  static int getIndexByValue(String s) {
    List<String> tmp = toStringList();
    for (int i = 0; i < tmp.length; i++) {
      if (tmp[i] == s) {
        return i;
      }
    }
    return 0;
  }
}

class FBAlignment {
  static String DEFALUT_ALIGM = _TOP_LEFT;
  static String _NO = "-";
  static String _TOP_LEFT = "Top Left";
  static String _TOP_CENTER = "Top Center";
  static String _TOP_RIGHT = "Top Right";
  static String _CENTER_LEFT = "Center Left";
  static String _CENTER = "Center";
  static String _CENTER_RIGHT = "Center Right";
  static String _BOTTOM_LEFT = "Bottom Left";
  static String _BOTTOM_CENTER = "Bottom Center";
  static String _BOTTOM__RIGHT = "Bottom Right";

  static Map map(){
    Map alignmentMap = Map();
    alignmentMap[_NO] = null;
    alignmentMap[_TOP_LEFT] = Alignment(-1.0, -1.0);
    alignmentMap[_TOP_CENTER] = Alignment(0.0, -1.0);
    alignmentMap[_TOP_RIGHT] = Alignment(1.0, -1.0);
    alignmentMap[_CENTER_LEFT] = Alignment(-1.0, 0.0);
    alignmentMap[_CENTER] = Alignment(0.0, 0.0);
    alignmentMap[_CENTER_RIGHT] = Alignment(1.0, 0.0);
    alignmentMap[_BOTTOM_LEFT] = Alignment(-1.0, 1.0);
    alignmentMap[_BOTTOM_CENTER] = Alignment(0.0, 1.0);
    alignmentMap[_BOTTOM__RIGHT] = Alignment(1.0, 1.0);
    return alignmentMap;
  }
  static List<Text> getAligmentList() {
    List<Text> result = [];
    result.add(Text(_NO));
    result.add(Text(_TOP_LEFT));
    result.add(Text(_TOP_CENTER));
    result.add(Text(_TOP_RIGHT));
    result.add(Text(_CENTER_LEFT));
    result.add(Text(_CENTER));
    result.add(Text(_CENTER_RIGHT));
    result.add(Text(_BOTTOM_LEFT));
    result.add(Text(_BOTTOM_CENTER));
    result.add(Text(_BOTTOM__RIGHT));
    return result;
  }
  static int getIndexByString(String s){
    List<Text> tmp = getAligmentList();
    for (int i = 0; i < tmp.length; i++) {
      if (tmp[i].data == s) {
        return i;
      }
    }
    return 0;
  }
}
