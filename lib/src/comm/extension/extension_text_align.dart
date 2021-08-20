
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
  static const String DEFAULT_ALIGM = NO;
  static const String NO = "-";
  static const String TOP_LEFT = "Top Left";
  static const String TOP_CENTER = "Top Center";
  static const String TOP_RIGHT = "Top Right";
  static const String CENTER_LEFT = "Center Left";
  static const String CENTER = "Center";
  static const String CENTER_RIGHT = "Center Right";
  static const String BOTTOM_LEFT = "Bottom Left";
  static const String BOTTOM_CENTER = "Bottom Center";
  static const String BOTTOM__RIGHT = "Bottom Right";

  static Map map(){
    Map alignmentMap = Map();
    alignmentMap[NO] = null;
    alignmentMap[TOP_LEFT] = Alignment(-1.0, -1.0);
    alignmentMap[TOP_CENTER] = Alignment(0.0, -1.0);
    alignmentMap[TOP_RIGHT] = Alignment(1.0, -1.0);
    alignmentMap[CENTER_LEFT] = Alignment(-1.0, 0.0);
    alignmentMap[CENTER] = Alignment(0.0, 0.0);
    alignmentMap[CENTER_RIGHT] = Alignment(1.0, 0.0);
    alignmentMap[BOTTOM_LEFT] = Alignment(-1.0, 1.0);
    alignmentMap[BOTTOM_CENTER] = Alignment(0.0, 1.0);
    alignmentMap[BOTTOM__RIGHT] = Alignment(1.0, 1.0);
    return alignmentMap;
  }
  static List<Text> getAligmentList() {
    List<Text> result = [];
    result.add(Text(NO));
    result.add(Text(TOP_LEFT));
    result.add(Text(TOP_CENTER));
    result.add(Text(TOP_RIGHT));
    result.add(Text(CENTER_LEFT));
    result.add(Text(CENTER));
    result.add(Text(CENTER_RIGHT));
    result.add(Text(BOTTOM_LEFT));
    result.add(Text(BOTTOM_CENTER));
    result.add(Text(BOTTOM__RIGHT));
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
