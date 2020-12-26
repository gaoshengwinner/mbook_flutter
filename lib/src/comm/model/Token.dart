import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'LoginResult.dart';

part 'Token.g.dart';

@JsonSerializable()
class Token {
  String refreshToken;
  int refreshTokenLimit;
  DateTime refressBeginDate;
  String accessToken;
  int accessTokenLimit;
  DateTime accessTokenDate;

  Token(this.refreshToken, this.refreshTokenLimit, this.refressBeginDate,
      this.accessToken, this.accessTokenLimit, this.accessTokenDate);

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);

  factory Token.fromTokenResult(LoginResult result) {
    return new Token(
        result.refreshToken,
        result.refreshTokenLimit,
        DateTime.now(),
        result.accessToken,
        result.accessTokenLimit,
        DateTime.now());
  }

  String getJsonString() {
    return jsonEncode(this.toJson());
  }
}
