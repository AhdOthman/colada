import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class GetDeviceId {
  static Future<String> getDeviceDetails() async {
    late String identifier;
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        identifier = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      debugPrint('Failed to get platform version');
    }

    return identifier;
  }
}
