import 'dart:convert';

import 'package:flutter_car_live/channel/app_event_channel.dart';
import 'package:flutter_car_live/models/profile.dart';
import 'package:flutter_car_live/utils/sp_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static SharedPreferences? _prefs;
  static Profile profile = Profile();
  static String? _deviceId; // 手持机设备号;
  // 网络缓存对象
  // static NetCache netCache = NetCache();
  // 获取设备号
  static String? get deviceId => _deviceId;
  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");
  // 是否登录
  static bool get isLogin => profile.token != '';
  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    // 初始化本地存储
    _prefs = await SPUtil.init();
    // 建立flutter与native事件通道
    AppEventChannel.registerPushEvent();
    // 读取本地数据
    var _profile = _prefs?.getString("profile");
    if (_profile != null) {
      profile = Profile.fromJson(jsonDecode(_profile));
    }
  }

  // 如果没有缓存策略，设置默认缓存策略
  // profile.cache = profile.cache ?? CacheConfig()
  //   ..enable = true
  //   ..maxAge = 3600
  //   ..maxCount = 100;

  // 保存设备号信息
  static saveDeviceId(id) {
    _deviceId = id;
  }

  // 持久化Profile信息
  static saveProfile() =>
      _prefs?.setString("profile", jsonEncode(profile.toJson()));
}
