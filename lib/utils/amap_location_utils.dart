import 'dart:async';
import 'dart:io';

import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_car_live/providers/location_model.dart';
import 'package:flutter_car_live/src/bean/bean_location.dart';
import 'package:flutter_car_live/src/subpages/locationError/location_error.dart';
import 'package:flutter_car_live/utils/navigator_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class AmapLocationUtils {
  static StreamSubscription<Map<String, Object>>? _locationListener;

  static AMapFlutterLocation? _locationPlugin;
  static init(BuildContext context) async {
    /// 5.6.0以上版本测试有问题
    // AMapFlutterLocation.updatePrivacyShow(true, true);
    // AMapFlutterLocation.updatePrivacyAgree(true);
    // 申请权限
    bool hasLocationPermission = await requestLocationPermission();
    if (!hasLocationPermission) {
      // 获取定位权限被拒绝弹框 去设置中心

      return;
    }

    ///iOS 获取native精度类型
    if (Platform.isIOS) {
      requestAccuracyAuthorization();
    }
    _locationPlugin = new AMapFlutterLocation();

    ///注册定位结果监听
    _locationListener = _locationPlugin!
        .onLocationChanged()
        .listen((Map<String, dynamic> result) {
      print(result);
      int? errorCode = result["errorCode"];
      String? solution = result["errorInfo"];
      if (errorCode != null) {
        // 获取定位结果错误
        NavigatorUtils.pushPageByFade(
          context: context,
          isReplace: true,
          targPage: LocationError(errorCode: errorCode, solution: solution),
        );
        return;
      }
      LocationBean locationBean = LocationBean.fromJson(result);
      Provider.of<LocationModel>(context, listen: false).locationInfo =
          locationBean;
    });
    startLocation();
  }

  ///设置定位参数
  static void _setLocationOption() {
    AMapLocationOption locationOption = new AMapLocationOption();

    ///是否单次定位
    locationOption.onceLocation = false;

    ///是否需要返回逆地理信息
    locationOption.needAddress = true;

    ///逆地理信息的语言类型
    locationOption.geoLanguage = GeoLanguage.DEFAULT;

    locationOption.desiredLocationAccuracyAuthorizationMode =
        AMapLocationAccuracyAuthorizationMode.ReduceAccuracy;

    locationOption.fullAccuracyPurposeKey = "AMapLocationScene";

    ///设置Android端连续定位的定位间隔毫秒(5分钟更新一次定位)
    locationOption.locationInterval = 5 * 60 * 1000;

    ///设置Android端的定位模式<br>
    locationOption.locationMode = AMapLocationMode.Battery_Saving;

    ///设置iOS端的定位最小更新距离<br>
    locationOption.distanceFilter = -1;

    ///设置iOS端期望的定位精度
    locationOption.desiredAccuracy = DesiredAccuracy.Best;

    ///设置iOS端是否允许系统暂停定位
    locationOption.pausesLocationUpdatesAutomatically = false;

    ///将定位参数设置给定位插件
    _locationPlugin!.setLocationOption(locationOption);
  }

  ///获取iOS native的accuracyAuthorization类型
  static void requestAccuracyAuthorization() async {
    AMapAccuracyAuthorization currentAccuracyAuthorization =
        await _locationPlugin!.getSystemAccuracyAuthorization();
    if (currentAccuracyAuthorization ==
        AMapAccuracyAuthorization.AMapAccuracyAuthorizationFullAccuracy) {
      print("精确定位类型");
    } else if (currentAccuracyAuthorization ==
        AMapAccuracyAuthorization.AMapAccuracyAuthorizationReducedAccuracy) {
      print("模糊定位类型");
    } else {
      print("未知定位类型");
    }
  }

  ///开始定位
  static void startLocation() {
    ///开始定位之前设置定位参数
    _setLocationOption();
    _locationPlugin!.startLocation();
  }

  ///停止定位
  static void stopLocation() {
    _locationPlugin!.stopLocation();
  }

  static void destroyLocation() {
    ///移除定位监听
    if (null != _locationListener) {
      _locationListener?.cancel();
    }

    ///销毁定位
    _locationPlugin!.destroy();
  }
}

/// 申请定位权限
/// 授予定位权限返回true， 否则返回false
Future<bool> requestLocationPermission() async {
  //获取当前的权限
  var status = await Permission.location.status;
  if (status == PermissionStatus.granted) {
    //已经授权
    return true;
  } else {
    //未授权则发起一次申请
    status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}
