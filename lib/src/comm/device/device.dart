import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mbook_flutter/src/comm/consts.dart';
import 'package:mbook_flutter/src/comm/model/DeviceInfo.dart';
import 'package:uuid/uuid.dart';

class DeviceHelper {
  static Future<DeviceInfo> getDeviceInfo() async {
    final deviceId = await getDeviceId();
    return DeviceInfo(deviceId, "", "","","");
  }

  static Future<String> getDeviceId() async {
    final storage = new FlutterSecureStorage();

// Read value
    return await storage?.read(key: G.KEY_CHAIN_DEVICE_ID)?.then((deviceId) {
      if (deviceId?.isEmpty ?? true) {
        var uuid = Uuid();
        deviceId = uuid.v4();
        storage.write(key: G.KEY_CHAIN_DEVICE_ID, value: deviceId);
      }
      return deviceId;
    });
  }
}
