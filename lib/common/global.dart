import 'dart:convert';

import 'package:flutter_car_live/models/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static SharedPreferences? _prefs;
  static Profile profile = Profile();
  // 网络缓存对象
  // static NetCache netCache = NetCache();

  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");
  // 是否登录
  static bool get isLogin => profile.token != null;
  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
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

  // 持久化Profile信息
  static saveProfile() =>
      _prefs?.setString("profile", jsonEncode(profile.toJson()));
}
