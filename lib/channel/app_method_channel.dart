import 'dart:core';

import 'package:flutter/services.dart';

import 'constant.dart';

class AppMethodChannel {
  static MethodChannel _methodChannel =
      MethodChannel(Constant.appMethodChannel);

  static Future<bool> startMapNav(
      double? lat, double? lng, String address) async {
    if (lat == null || lng == null) {
      return false;
    }
    try {
      await _methodChannel.invokeMethod(
        "startMapNav",
        {
          "lat": lat,
          "lng": lng,
          "address": address,
        },
      );
      return true;
    } catch (onError) {
      print("AppMethodChannel, startMapNav onError:$onError");
      return false;
    }
  }

  // 获取经纬度
  static Future<dynamic> getLocation() async {
    var location = await _methodChannel.invokeMethod("requestLocation");
    return location;
  }

  // 手动触发本能机读取cid
  static Future<bool> emitReadCid() async {
    return await _methodChannel.invokeMethod("readCid");
  }

  static Future<String> getHtDeviceId() async {
    String _htDeviceId = await _methodChannel.invokeMethod("getHtDeviceId");
    return _htDeviceId;
  }

  static Future<String> huatuoScan() async {
    return await _methodChannel.invokeMethod("huatuoScan");
  }

  static Future<bool> onUmEvent(String eventId) async {
    if (eventId == '') {
      return false;
    }
    _methodChannel.invokeMethod("onUmEvent", {"eventId": eventId});
    print("onUmEvent:" + eventId);
    return true;
//    Fluttertoast.showToast(msg: eventId,gravity: ToastGravity.CENTER,);
//      UmUtils.eventClick(eventId);
  }

  static Future<bool> bindAlias(String alias) async {
    if (alias == "") {
      return false;
    }
    _methodChannel.invokeMethod("bindAlias", {"alias": alias});
    return true;
  }

  ///判断本能设备是否已经连接
  static Future<bool> isBenNengConnected() async {
    String deviceid = await _methodChannel.invokeMethod("bn_device_id");
    return deviceid != "";
  }

  static Future<String> getBNDeviceCode() async {
    return await _methodChannel.invokeMethod("bn_device_id");
  }

  @deprecated
  static searchBnDevice() async {
    String deviceId = await _methodChannel.invokeMethod("bn_search_device");
    return deviceId;
  }
}
