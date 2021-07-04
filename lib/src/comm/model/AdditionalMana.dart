
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'AdditionalInfo.dart';

part 'AdditionalMana.g.dart';

@JsonSerializable()
class AdditionalMana {
  List<AdditionalInfo>? simpleTexts;
  List<AdditionalInfo>? htmlTexts;
  List<AdditionalInfo>? pictures;
  List<AdditionalInfo>? videos;
  List<AdditionalInfo>? webViews;

  AdditionalMana({required this.simpleTexts, required this.htmlTexts, required this.pictures, required this.videos, required this.webViews});

  factory AdditionalMana.fromJson(Map<String, dynamic> json) =>
      _$AdditionalManaFromJson(json);

  Map<String, dynamic> toJson() {
    return _$AdditionalManaToJson(this);
  }

  @override
  String toString() {
    return getJsonString();
  }

  String getJsonString() {
    return jsonEncode(this.toJson());
  }
}