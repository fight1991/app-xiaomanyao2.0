import 'package:flutter/material.dart';
import 'package:flutter_car_live/common/global.dart';
import 'package:flutter_car_live/net/fetch_methods.dart';
import 'package:flutter_car_live/providers/permission_model.dart';
import 'package:flutter_car_live/src/mixins/init_user.dart';
import 'package:flutter_car_live/src/pages/home/home_page.dart';
import 'package:flutter_car_live/src/pages/login/login_page.dart';
import 'package:flutter_car_live/utils/navigator_utils.dart';
import 'package:flutter_car_live/utils/toast_utils.dart';
import 'package:provider/provider.dart';

/// @Author: Tiancong
/// @Date: 2021-11-29 18:07:52
/// @Description: 初始化页面
class IndexPage extends StatefulWidget {
  @override
  _IndexPage createState() => _IndexPage();
}

// 在此页面可以进行
// 1. 获取系统权限
// 2. 初始化用户信息
// 3. 跳转页面
class _IndexPage extends State<IndexPage> with InitUser {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      initData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image.asset(
        'assets/images/common/lp.png',
        fit: BoxFit.fill,
      ),
    );
  }

  // 初始化用户信息
  void initData() async {
    // 假设没有登录则跳转到登录页面
    if (Global.isLogin) {
      // 初始化用户信息和权限信息, 不弹框, 不显示loading
      bool isInitSuccess = await Fetch.all([
        getUserInfo(context, withLoading: false, showToast: false),
        getPermissions(context, withLoading: false, showToast: false)
      ], widthLoading: false);
      if (!isInitSuccess) {
        // 初始化用户信息失败跳转到登录页
        jumpToPage(LoginPage());
        return;
      }
      List<String> permissions =
          Provider.of<PermissionModel>(context, listen: false).permissions;
      // 如果仅仅是发卡点
      if (permissions.contains('0801000000') &&
          (!permissions.contains('0802000000') ||
              !permissions.contains('0803000000'))) {
        jumpToPage(HomePage());
        return;
      }
      // 加油商户需要位置信息'0802000000', '0803000000'
      bool isLocation = await getLocationInfo(context, widthLoading: false);
      // 获取经纬度失败,重新跳转到登录页
      if (!isLocation) {
        jumpToPage(LoginPage());
        return;
      }
      jumpToPage(HomePage());
      return;
    }
    jumpToPage(LoginPage());
  }

  // 跳转页面
  void jumpToPage(Widget page) {
    NavigatorUtils.pushPageByFade(
      context: context,
      targPage: page,
      isReplace: true,
    );
  }
}
