import 'package:json_annotation/json_annotation.dart';

part 'ResetPasswordResult.g.dart';

// root flutter packages pub run build_runner build --delete-conflicting-outputs
// root flutter packages pub run build_runner build watch
@JsonSerializable()
class ResetPasswordResult {
  String statu;
  String uuid;
  List<Errs> errs;

  ResetPasswordResult(this.statu, this.errs);

  factory ResetPasswordResult.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordResultToJson(this);
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