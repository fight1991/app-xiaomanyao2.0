import 'package:flutter/material.dart';
import 'package:flutter_car_live/channel/app_method_channel.dart';
import 'package:flutter_car_live/models/user.dart';
import 'package:flutter_car_live/net/fetch_methods.dart';
import 'package:flutter_car_live/net/http_helper.dart';
import 'package:flutter_car_live/net/response_data.dart';
import 'package:flutter_car_live/providers/location_model.dart';
import 'package:flutter_car_live/providers/permission_model.dart';
import 'package:flutter_car_live/providers/user_model.dart';
import 'package:flutter_car_live/src/bean/bean_location.dart';
import 'package:provider/provider.dart';

class InitUser {
  // 查询用户信息
  Future<bool> getUserInfo(BuildContext context,
      {bool withLoading = true, bool showToast = true}) async {
    ResponseInfo responseInfo = await Fetch.post(
      url: HttpHelper.getUserInfo,
      withLoading: withLoading,
      showToast: showToast,
    );
    if (responseInfo.success) {
      User user = User.fromJson(responseInfo.data);
      Provider.of<UserModel>(context, listen: false).user = user;
    }
    return responseInfo.success;
  }

  // 查询权限信息
  Future<bool> getPermissions(
    BuildContext context, {
    bool withLoading = true,
    bool showToast = true,
  }) async {
    ResponseInfo responseInfo = await Fetch.post(
      url: HttpHelper.getUserViews,
      withLoading: withLoading,
      showToast: showToast,
    );
    if (responseInfo.success) {
      // json List 转 List<String>
      List<String> permissions = responseInfo.data.cast<String>();
      Provider.of<PermissionModel>(context, listen: false).permissions =
          permissions;
    }
    return responseInfo.success;
  }

  // 获取手持机当前的经纬度
  Future<bool> getLocationInfo(BuildContext context) async {
    var map = await AppMethodChannel.getLocation();
    Map<String, dynamic> _map = {
      "success": map["success"],
      "message": map["message"],
      "longitude": map["longitude"],
      "latitude": map["latitude"],
    };
    LocationBean locationBean = LocationBean.fromJson(_map);
    Provider.of<LocationModel>(context, listen: false).locationInfo =
        locationBean;
    return locationBean.success ?? false;
  }
}
