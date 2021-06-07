import 'package:json_annotation/json_annotation.dart';

part 'SignupMailCnfResult.g.dart';

// root flutter packages pub run build_runner build --delete-conflicting-outputs
// root flutter packages pub run build_runner build watch
@JsonSerializable()
class SignupMailCnfResult {
  String statu;
  String code;
  List<Errs> errs;

  SignupMailCnfResult(this.statu, this.errs);

  factory SignupMailCnfResult.fromJson(Map<String, dynamic> json) =>
      _$SignupMailCnfResultFromJson(json);

  Map<String, dynamic> toJson() => _$SignupMailCnfResultToJson(this);
}

@JsonSerializable()
class Errs{
  String msg;
  String errField;

  Errs(this.msg, this.errField);

  factory Errs.fromJson(Map<String, dynamic> json) =>
      _$ErrsFromJson(json);

  Map<String, dynamic> toJson() => _$ErrsToJson(this);

}