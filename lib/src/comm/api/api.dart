import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mbook_flutter/src/comm/device/device.dart';
import 'package:mbook_flutter/src/comm/menu.dart';
import 'package:mbook_flutter/src/comm/model/ItemDetail.dart';
import 'package:mbook_flutter/src/comm/model/RefreshTokenResult.dart';
import 'package:mbook_flutter/src/comm/model/ShopInfo.dart';
import 'package:mbook_flutter/src/comm/model/Token.dart';
import 'package:mbook_flutter/src/comm/token/token.dart';

class Api {
  static String _BASE_API_URL = "http://663eb064875e.ngrok.io";
  static String _LOGIN_URL = _BASE_API_URL + "/v1/api/member/login";
  static String _REFRESH_TOKEN_URL =
      _BASE_API_URL + "/v1/api/manag/refreshToken";
  static String _MY_SHOPINFO_URL = _BASE_API_URL + "/v1/api/manag/shopInfo";
  static String _SAVE_MY_SHOPINFO_URL =
      _BASE_API_URL + "/v1/api/manag/save_shopInfo";
  static String _GET_MY_ITEMINFO_URL =
      _BASE_API_URL + "/v1/api/manag/shopItemInfo";

  static String _CONTENT_TYPE = "application/json; charset=utf-8";
  static String _MB_DEVICE_INFOR_HEADER = "MB_DEVICE_INFOR_HEADER";
  static String _AUTHON_REFRESH_HEADER = "AUTHON_REFRESH_HEADER";
  static String _AUTHON_ACCESS_HEADER = "AUTHON_ACCESS_HEADER";

  static Future<List<Object>> login(String mail, String pws) async {
    String body = jsonEncode(<String, String>{
      'memberEmail': mail,
      'memberPassword': pws,
    });
    List<Object> result = await doPostNoNeedLoginApi(_LOGIN_URL, body);
    result[1] = Token.fromJson(jsonDecode(result[1]));
    if (result[0] == 200) {
      await TokenUtil.saveToken(result[1]);
    }
    return result;
  }

  // [0] status [1] body string
  static Future<List<Object>> doPostNoNeedLoginApi(String url,
      [String body, Map<String, String> header]) async {
    final deviceInfo = await DeviceHelper.getDeviceInfo();
    Map<String, String> headers = Map();
    if (header != null) headers.addAll(header);
    headers['Content-Type'] = _CONTENT_TYPE;
    headers[_MB_DEVICE_INFOR_HEADER] = deviceInfo.getBase64();
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(response.body);
    List<Object> resultList = [response.statusCode, ""];
    final String responsebody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200 ||
        response.statusCode == 400 ||
        response.statusCode == 401) {
      resultList[1] = responsebody;
      return resultList;
    } else {
      throw Exception('${response.statusCode}${responsebody}');
    }
  }

  static Future<List<Object>> doPostNeedLoginApi(
      BuildContext _context, String url, String body) async {
    final deviceInfo = await DeviceHelper.getDeviceInfo();
    String accessToken = await TokenUtil.getAccessToken();
    if (accessToken == null) {
      final refreshToken = await TokenUtil.getRefreshToken();
      if (refreshToken == null) {
        MenuBar.logout(_context, null);
        return null;
      }

      Map<String, String> header = Map();
      header[_AUTHON_REFRESH_HEADER] = refreshToken;

      List<Object> refreshTokenResult =
          await doPostNoNeedLoginApi(_REFRESH_TOKEN_URL, null, header);
      if (refreshTokenResult[0] != 200) {
        MenuBar.logout(_context, null);
        return null;
      }

      RefreshTokenResult rt =
          RefreshTokenResult.fromJson(jsonDecode(refreshTokenResult[1]));
      TokenUtil.refreshAccessToken(rt);

      accessToken = await TokenUtil.getAccessToken();
    }

    Map<String, String> header = Map();
    header[_AUTHON_ACCESS_HEADER] = accessToken;
    List<Object> result = await doPostNoNeedLoginApi(url, body, header);
    if (result[0] == 401) {
      MenuBar.logout(_context, null);
      return null;
    }

    return result;
  }

  static Future<List<Object>> getMyShopInfo(BuildContext _context) async {
    List<Object> shopInfo =
        await doPostNeedLoginApi(_context, _MY_SHOPINFO_URL, null);
    if (shopInfo[0] == 200) {
      shopInfo[1] = ShopInfo.fromJson(jsonDecode(shopInfo[1]));
    } else {
      throw Exception(shopInfo[1]);
    }
    return shopInfo;
  }

  static Future<void> saveMyShopInfo(
      BuildContext _context, ShopInfo _shopInfo) async {
    //
    List<Object> shopInfo = await doPostNeedLoginApi(
        _context, _SAVE_MY_SHOPINFO_URL, _shopInfo.getJsonString());
    if (shopInfo[0] == 200) {
      return;
    }
    throw Exception('${shopInfo[0]}${shopInfo[1]}');
  }

  static Future<List<Object>> getMyShopItemInfo(BuildContext _context) async {
    List<Object> itemInfo =
        await doPostNeedLoginApi(_context, _GET_MY_ITEMINFO_URL, null);
    if (itemInfo[0] == 200) {
      List<ItemDetail> myModels = (json.decode(itemInfo[1]) as List)
          .map((i) => ItemDetail.fromJson(i))
          .toList();
      itemInfo[1] = myModels;
      print(myModels.length);
    } else {
      throw Exception(itemInfo[1]);
    }

    return itemInfo;
  }
}

//　 return CircularProgressIndicator();
