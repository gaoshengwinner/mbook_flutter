import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'AdditionalInfo.g.dart';
// root flutter packages pub run build_runner build --delete-conflicting-outputs
// root flutter packages pub run build_runner build watch
@JsonSerializable()
class AdditionalInfo{
  bool? canBeUse = false;
  int? no = 0;
  String? value = "";
  String? title = "";

  AdditionalInfo({this.no, this.canBeUse, this.value, this.title});

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) =>
      _$AdditionalInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AdditionalInfoToJson(this);

  String getJsonString() {
    return jsonEncode(this.toJson());
  }
}

