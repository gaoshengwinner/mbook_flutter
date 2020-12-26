import 'dart:convert';
import 'dart:ffi';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mbook_flutter/src/comm/model/RefreshTokenResult.dart';
import 'package:mbook_flutter/src/comm/model/Token.dart';

import '../consts.dart';

class TokenUtil{

  static Future<String> getRefreshToken() async {
    final storage = new FlutterSecureStorage();
    final tokenString =  await storage.read(key: G.KEY_CHAIN_TOKEN);
    if (tokenString.isEmpty) {
      return null;
    }
    final token = Token.fromJson(jsonDecode(tokenString));

    if (token.refressBeginDate.difference(DateTime.now()).inMinutes < token.refreshTokenLimit -30){
      return token.refreshToken;
    } else {
      return null;
    }
  }

  static Future<String> getAccessToken() async {
    final storage = new FlutterSecureStorage();
    final tokenString =  await storage.read(key: G.KEY_CHAIN_TOKEN);
    if (tokenString.isEmpty) {
      return null;
    }
    final token = Token.fromJson(jsonDecode(tokenString));

    if (token.accessTokenDate.difference(DateTime.now()).inMinutes < token.accessTokenLimit -30){
      return token.accessToken;
    } else {
      return null;
    }
  }

  static Future<Void> refreshAccessToken(RefreshTokenResult result) async{
    final storage = new FlutterSecureStorage();
    final tokenString =  await storage.read(key: G.KEY_CHAIN_TOKEN);

    var token = Token.fromJson(jsonDecode(tokenString));
    token.accessToken = result.accessToken;
    token.accessTokenLimit = result.accessTokenLimit;
    token.accessTokenDate = DateTime.now();

    await saveToken(token);
  }

  static Future<bool> checkRefreshToken() async{
    final result = await getRefreshToken();
    print("test");
    return !result.isEmpty;
  }
  
  static saveToken(Token toke) async{
    final storage = new FlutterSecureStorage();
    toke.accessTokenDate = DateTime.now();
    toke.refressBeginDate = DateTime.now();
    storage.write(key: G.KEY_CHAIN_TOKEN, value: toke.getJsonString());
  }


}