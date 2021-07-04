import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mbook_flutter/src/comm/device/device.dart';
import 'package:mbook_flutter/src/comm/menu.dart';
import 'package:mbook_flutter/src/comm/model/ItemDetail.dart';
import 'package:mbook_flutter/src/comm/model/LoginResult.dart';
import 'package:mbook_flutter/src/comm/model/OptionTemp.dart';
import 'package:mbook_flutter/src/comm/model/OptionTempResultList.dart';
import 'package:mbook_flutter/src/comm/model/RefreshTokenResult.dart';
import 'package:mbook_flutter/src/comm/model/ResetPasswordResult.dart';
import 'package:mbook_flutter/src/comm/model/ShopInfo.dart';
import 'package:mbook_flutter/src/comm/model/SignupMailCnfResult.dart';
import 'package:mbook_flutter/src/comm/model/TagInfo.dart';
import 'package:mbook_flutter/src/comm/model/TagResultList.dart';
import 'package:mbook_flutter/src/comm/model/Token.dart';
import 'package:mbook_flutter/src/comm/token/token.dart';

class Api {
  static const int OK = 200;
  static const String _BASE_API_URL = "https://27e646ea6296.ngrok.io";
  static const String _LOGIN_URL = _BASE_API_URL + "/v1/api/member/login";
  static const String _SIGNUP_MAIL_CNF_URL = _BASE_API_URL + "/v1/api/sigup/sigupMailCnf";
  static const String _SIGNUP_MAIL_CODE_CNF_URL = _BASE_API_URL + "/v1/api/sigup/sigupCodeCnf";
  static const String _SIGNUP_SIGUP_URL = _BASE_API_URL + "/v1/api/sigup/sigup";

  static const String _RESET_PASSWORD_MAIL_CNF_URL = _BASE_API_URL + "/v1/api/resetPassword/resetPasswordMailCnf";
  static const String _RESET_PASSWORD_MAIL_CODE_CNF_URL = _BASE_API_URL + "/v1/api/resetPassword/resetPasswordCodeCnf";
  static const String _RESET_PASSWORD_SIGUP_URL = _BASE_API_URL + "/v1/api/resetPassword/resetPassword";


  static const String _REFRESH_TOKEN_URL =
      _BASE_API_URL + "/v1/api/manag/refreshToken";
  static const String _MY_SHOPINFO_URL = _BASE_API_URL + "/v1/api/manag/shopInfo";
  static const String _SAVE_MY_SHOPINFO_URL =
      _BASE_API_URL + "/v1/api/manag/save_shopInfo";
  static const String _GET_MY_ITEMINFO_URL =
      _BASE_API_URL + "/v1/api/manag/shopItemInfo";
  static const String _MY_SAVE_ITEM_BASE_INFO_URL =
      _BASE_API_URL + "/v1/api/manag/shopItemInfoRow";
  static const String _MY_DELETE_ITEM_URL =
      _BASE_API_URL + "/v1/api/manag/deleteShopItemRow";

  static const String _MY_GET_TAG_URL = _BASE_API_URL +  "/v1/api/manag/get_tags";
  static const String _MY_SAVE_TAG_URL = _BASE_API_URL +  "/v1/api/manag/save_tags";

  static const String _MY_GET_OPTIONTEMP_URL = _BASE_API_URL +  "/v1/api/manag/get_optiontemps";
  static const String _MY_SAVE_OPTIONTEMP_URL = _BASE_API_URL +  "/v1/api/manag/save_optiontemps";

  static const String _CONTENT_TYPE = "application/json; charset=utf-8";
  static const String _MB_DEVICE_INFOR_HEADER = "MB_DEVICE_INFOR_HEADER";
  static const String _AUTHON_REFRESH_HEADER = "AUTHON_REFRESH_HEADER";
  static const String _AUTHON_ACCESS_HEADER = "AUTHON_ACCESS_HEADER";

  static Future<List<dynamic>> login(String mail, String pws) async {
    String body = jsonEncode(<String, String>{
      'memberEmail': mail,
      'memberPassword': pws,
    });
    List<dynamic> result = await doPostNoNeedLoginApi(_LOGIN_URL, body);
    result[1] = LoginResult.fromJson(jsonDecode(result[1]));
    if (result[0] == Api.OK) {
      await TokenUtil.saveToken(Token.fromTokenResult(result[1]));
    }
    return result;
  }

  static Future<List<dynamic>> sigupMailCnf(String mail) async {
    String body = jsonEncode(<String, String>{
      'memberEmail': mail
    });
    List<dynamic> result = await doPostNoNeedLoginApi(_SIGNUP_MAIL_CNF_URL, body);
    result[1] = SignupMailCnfResult.fromJson(jsonDecode(result[1]));

    return result;
  }

  static Future<List<dynamic>> sigupMailCodeCnf(String uuid, String code) async {
    String body = jsonEncode(<String, String>{
      'code': code,
      'uuid': uuid
    });
    List<dynamic> result = await doPostNoNeedLoginApi(_SIGNUP_MAIL_CODE_CNF_URL, body);
    result[1] = SignupMailCnfResult.fromJson(jsonDecode(result[1]));

    return result;
  }

  static Future<List<dynamic>> sigup(String memberEmail, String uuid, String memberPassword) async {
    String body = jsonEncode(<String, String>{
      'memberEmail': memberEmail,
      'uuid': uuid,
      'memberPassword':memberPassword
    });
    List<dynamic> result = await doPostNoNeedLoginApi(_SIGNUP_SIGUP_URL, body);
    result[1] = SignupMailCnfResult.fromJson(jsonDecode(result[1]));

    return result;
  }

  static Future<List<dynamic>> resetPassordMailCnf(String mail) async {
    String body = jsonEncode(<String, String>{
      'memberEmail': mail
    });
    List<dynamic> result = await doPostNoNeedLoginApi(_RESET_PASSWORD_MAIL_CNF_URL
        , body);
    result[1] = ResetPasswordResult.fromJson(jsonDecode(result[1]));

    return result;
  }

  static Future<List<dynamic>> resetPasswordMailCodeCnf(String? uuid, String code) async {
    String body = jsonEncode(<String, String>{
      'code': code,
      'uuid': uuid?.toString() ?? ""
    });
    List<dynamic> result = await doPostNoNeedLoginApi(_RESET_PASSWORD_MAIL_CODE_CNF_URL
        , body);
    result[1] = ResetPasswordResult.fromJson(jsonDecode(result[1]));

    return result;
  }

  static Future<List<dynamic>> resetPassword(String? memberEmail, String? uuid, String? memberPassword) async {
    String body = jsonEncode(<String, String>{
      'memberEmail': memberEmail?.toString() ?? "",
      'uuid': uuid?.toString() ?? "",
      'memberPassword':memberPassword?.toString() ?? ""
    });
    List<dynamic> result = await doPostNoNeedLoginApi(_RESET_PASSWORD_SIGUP_URL
        , body);
    result[1] = ResetPasswordResult.fromJson(jsonDecode(result[1]));

    return result;
  }


  // [0] status [1] body string
  static Future<List<dynamic>> doPostNoNeedLoginApi( String url,
      [String? body, Map<String, String>? header]) async {
    final deviceInfo = await DeviceHelper.getDeviceInfo();
    Map<String, String> headers = Map();
    if (header != null) headers.addAll(header);
    headers['Content-Type'] = _CONTENT_TYPE;
    headers[_MB_DEVICE_INFOR_HEADER] = deviceInfo.getBase64();
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);
    List<dynamic> resultList = [response.statusCode, ""];
    final String responsebody = utf8.decode(response.bodyBytes);
    print(responsebody);
    if (response.statusCode == 200 ||
        response.statusCode == 400 ||
        response.statusCode == 401) {
      resultList[1] = responsebody;
      return resultList;
    } else {
      throw Exception('$response.statusCode$responsebody');
    }
  }

  static Future<List<dynamic>?>? doPostNeedLoginApi(
      BuildContext _context, String url, String? body) async {
    print("$body");
    String? accessToken = await TokenUtil.getAccessToken();
    if (accessToken == null) {
      final refreshToken = await TokenUtil.getRefreshToken();
      if (refreshToken == null) {
        MenuBar.logout(_context);
        return null;
      }

      Map<String, String> header = Map();
      header[_AUTHON_REFRESH_HEADER] = refreshToken;

      List<dynamic> refreshTokenResult =
          await doPostNoNeedLoginApi(_REFRESH_TOKEN_URL, null, header);
      if (refreshTokenResult[0] != 200) {
        MenuBar.logout(_context);
        return null;
      }

      RefreshTokenResult rt =
          RefreshTokenResult.fromJson(jsonDecode(refreshTokenResult[1]));
      TokenUtil.refreshAccessToken(rt);

      accessToken = await TokenUtil.getAccessToken();
    }

    Map<String, String> header = Map();
    header[_AUTHON_ACCESS_HEADER] = accessToken!;
    List<dynamic> result = await doPostNoNeedLoginApi(url, body, header);
    if (result[0] == 401) {
      MenuBar.logout(_context);
      return null;
    }

    return result;
  }

  static Future<List<dynamic>>? getMyShopInfo(BuildContext _context) async {
    List<dynamic>? shopInfo =
        await doPostNeedLoginApi(_context, _MY_SHOPINFO_URL, null);
    if (shopInfo![0] == 200) {
      shopInfo[1] = ShopInfo.fromJson(jsonDecode(shopInfo[1]));
    } else {
      throw Exception(shopInfo[1]);
    }
    return shopInfo;
  }

  static Future<void> saveMyShopInfo(
      BuildContext _context, ShopInfo _shopInfo) async {
    List<dynamic>? shopInfo = await doPostNeedLoginApi(
        _context, _SAVE_MY_SHOPINFO_URL, _shopInfo.getJsonString());
    if (shopInfo![0] == 200) {
      return;
    }
    throw Exception('${shopInfo[0]}${shopInfo[1]}');
  }

  static Future<void> deleteMyShopItem(BuildContext _context, ItemDetail _itemDetail) async {
    List<dynamic>? result = await doPostNeedLoginApi(
        _context, _MY_DELETE_ITEM_URL, _itemDetail.getJsonString());
    if (result![0] == 200) {
      return;
    }
    throw Exception('${result[0]}${result[1]}');

  }

  static Future<void> saveMyItemInfo(BuildContext _context, ItemDetail _itemDetail) async{
    List<dynamic>? result = await doPostNeedLoginApi(
        _context, _MY_SAVE_ITEM_BASE_INFO_URL, _itemDetail.getJsonString());
    if (result![0] == 200) {
      return;
    }
    throw Exception('${result[0]}${result[1]}');
  }

  static Future<List<dynamic>> getMyShopItemInfo(BuildContext _context) async {
    List<dynamic>? itemInfo =
        await doPostNeedLoginApi(_context, _GET_MY_ITEMINFO_URL, null);
    if (itemInfo == null) {
      throw Exception("itemInfo is null");
    }
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

  static Future<List<dynamic>> getMyTags(BuildContext _context) async {
    List<dynamic>? tagInfo =
    await doPostNeedLoginApi(_context, _MY_GET_TAG_URL, null);
    if (tagInfo == null) {
      throw Exception("tagInfo is null!");
    }
    if (tagInfo[0] == 200) {
      List<TagInfo> myModels = (json.decode(tagInfo[1]) as List)
          .map((i) => TagInfo.fromJson(i))
          .toList();
      tagInfo[1] = myModels;
      print(myModels.length);
    } else {
      throw Exception(tagInfo[1]);
    }

    return tagInfo;
  }

  static Future<void> saveMyTagInfo(BuildContext _context, TagResultList _tags) async{
    List<dynamic>? result = await doPostNeedLoginApi(
        _context, _MY_SAVE_TAG_URL, jsonEncode(_tags));
    if (result == null) {
      return;
    }
    if (result[0] == 200) {
      return;
    }
    throw Exception('${result[0]}${result[1]}');
  }

  static Future<List<dynamic>> getMyOptionTemps(BuildContext _context) async {
    List<dynamic>? optionTempInfo =
    await doPostNeedLoginApi(_context, _MY_GET_OPTIONTEMP_URL, null);
    if (optionTempInfo![0] == 200) {
      List<OptionTemp> myModels = (json.decode(optionTempInfo[1]) as List)
          .map((i) => OptionTemp.fromJson(i))
          .toList();
      optionTempInfo[1] = myModels;
      print(myModels.length);
    } else {
      throw Exception(optionTempInfo[1]);
    }

    return optionTempInfo;
  }

  static Future<void> saveMyOptionTempnfo(BuildContext _context, OptionTempResultList _optionTemps) async{
    List<dynamic>? result = await doPostNeedLoginApi(
        _context, _MY_SAVE_OPTIONTEMP_URL, jsonEncode(_optionTemps));
    if (result![0] == 200) {
      return;
    }
    throw Exception('${result[0]}${result[1]}');
  }

}

//　 return CircularProgressIndicator();
