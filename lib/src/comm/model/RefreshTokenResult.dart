import 'package:json_annotation/json_annotation.dart';

part 'RefreshTokenResult.g.dart';

@JsonSerializable()
class RefreshTokenResult{
  String? statu;
  String? err;
  String? accessToken;
  int? accessTokenLimit;

RefreshTokenResult(this.statu, this.err, this.accessToken, this.accessTokenLimit);

  factory RefreshTokenResult.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenResultFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenResultToJson(this);

}