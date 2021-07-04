import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'DeviceInfo.g.dart';

// root flutter packages pub run build_runner build
// root flutter packages pub run build_runner build watch
@JsonSerializable()
class DeviceInfo {
  String? deviceId;
  String phoneName = "TODO";
  String appVersion = "TODO";
  String systemName = "TODO";
  String systemVersion = "TODO";
  String deviceIP = "TODO";

  DeviceInfo(this.deviceId, this.phoneName, this.appVersion, this.systemName,
      this.systemVersion);

  factory DeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceInfoToJson(this);

  String getJsonString() {
    return jsonEncode(this.toJson());
  }

  String getBase64() {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(getJsonString());
   // String decoded = stringToBase64.decode(encoded);
    return encoded;
  }
}
