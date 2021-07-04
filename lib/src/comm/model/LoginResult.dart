import 'package:json_annotation/json_annotation.dart';

part 'LoginResult.g.dart';

// root flutter packages pub run build_runner build
// root flutter packages pub run build_runner build watch
@JsonSerializable()
class LoginResult {
  String? statu;
  List<Errs>? errs;

  String? refreshToken;
  int? refreshTokenLimit;
  String? accessToken;
  int? accessTokenLimit;

  LoginResult(this.statu, this.errs, this.refreshToken, this.refreshTokenLimit,
      this.accessToken, this.accessTokenLimit);

  factory LoginResult.fromJson(Map<String, dynamic> json) =>
      _$LoginResultFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultToJson(this);
}

@JsonSerializable()
class Errs {
  String? msg;
  String? errField;

  Errs(this.msg, this.errField);

  factory Errs.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      return _$ErrsFromJson(json);
    } else {
      return Errs("", "");
    }
  }

  Map<String, dynamic> toJson() => _$ErrsToJson(this);
}
