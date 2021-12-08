import 'package:flutter/material.dart';
import 'package:flutter_car_live/models/user.dart';
import 'package:flutter_car_live/net/fetch_methods.dart';
import 'package:flutter_car_live/net/http_helper.dart';
import 'package:flutter_car_live/net/response_data.dart';
import 'package:flutter_car_live/providers/permission_model.dart';
import 'package:flutter_car_live/providers/user_model.dart';
import 'package:provider/provider.dart';

class InitUser {
  // 查询用户信息
  Future<bool> getUserInfo(BuildContext context) async {
    ResponseInfo responseInfo = await Fetch.post(
        url: HttpHelper.getUserInfo, withLoading: false, showToast: false);
    if (responseInfo.success) {
      User user = User.fromJson(responseInfo.data);
      Provider.of<UserModel>(context, listen: false).user = user;
    }
    return responseInfo.success;
  }

  // 查询权限信息
  Future<bool> getPermissions(BuildContext context) async {
    ResponseInfo responseInfo = await Fetch.post(
        url: HttpHelper.getUserViews, withLoading: false, showToast: false);
    if (responseInfo.success) {
      // json List 转 List<String>
      List<String> permissions = responseInfo.data.cast<String>();
      Provider.of<PermissionModel>(context, listen: false).permissions =
          permissions;
    }
    return responseInfo.success;
  }
}
