import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mbook_flutter/src/comm/device/device.dart';
import 'package:mbook_flutter/src/comm/model/LoginResult.dart';
import 'package:mbook_flutter/src/comm/model/Token.dart';
import 'package:mbook_flutter/src/comm/token/token.dart';

class Api {
  static String _BASE_API_URL = "https://1938d4f6ffd2.ngrok.io";
  static String _LOGIN_URL = _BASE_API_URL + "/v1/api/member/login";

  static String _CONTENT_TYPE = "application/json; charset=utf-8";
  static String _MB_DEVICE_INFOR_HEADER = "MB_DEVICE_INFOR_HEADER";
  static String _AUTHON_REFRESH_HEADER = "AUTHON_REFRESH_HEADER";
  static String _AUTHON_ACCESS_HEADER = "AUTHON_ACCESS_HEADER";

  static Future<List<Object>> login(String mail, String pws) async{

    String body = jsonEncode(<String, String>{
      'memberEmail': mail,
      'memberPassword': pws,
    });
    return await doPostNoNeedLoginApi(_LOGIN_URL, body);
  }

  static Future<List<Object>> doPostNoNeedLoginApi(String url, String body) async {
    final deviceInfo = await DeviceHelper.getDeviceInfo();
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        _MB_DEVICE_INFOR_HEADER: deviceInfo.getBase64()
      },
      body: body,
    );

    print(response.body);
    List<Object> resultList = [response.statusCode, ""];
    String responsebody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      resultList[1] = LoginResult.fromJson(jsonDecode(responsebody));
      await TokenUtil.saveToken(Token.fromJson(jsonDecode(responsebody)));
      return resultList;
    } else {
      if (response.statusCode == 400) {
        resultList[1] = LoginResult.fromJson(jsonDecode(responsebody));
        return resultList;
      }
      throw Exception(responsebody);
    }
  }
}
//　 return CircularProgressIndicator();
