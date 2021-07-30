
import 'package:flutter/material.dart';

class G{
  // APP基本色
  static List<Color> appBaseColor = [Colors.deepOrange, Colors.orangeAccent];



  // MeelBook基本头
  static const String APP_BASE = "MEAIL_BOOL_";
  // KeyChain设备ID
  static const String KEY_CHAIN_DEVICE_ID = APP_BASE + "KEY_CHAIN_DEVICE_ID";
  // KeyChainトークン
  static const String KEY_CHAIN_TOKEN = APP_BASE + "KEY_CHAIN_TOKEN";

  //
  // final size = MediaQuery.of(context).size;
  // final width = size.width;
  // final height = size.height;


// routes
 static const String ROUTES_LOGIN = "/login_page";
  static const String ROUTES_HOME = "/home";

  static bool isNullOrEmpty(dynamic value){
    if (value == null){
      return true;
    }
    if (value is String) {
      return value.isEmpty;
    }
    return false;
  }

  static bool isNotNullOrEmpty(dynamic value){
    return !isNullOrEmpty(value);
  }

  static String nullSafe(String? s){
    return s == null ? "" : s;
  }

  static T ifNull<T>(T? value, T nullValue){
    return value == null ? nullValue : value;
  }

}