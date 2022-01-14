import 'package:flutter/material.dart';
import 'package:flutter_car_live/common/global.dart';
import 'package:flutter_car_live/net/fetch_methods.dart';
import 'package:flutter_car_live/providers/permission_model.dart';
import 'package:flutter_car_live/src/mixins/init_user.dart';
import 'package:flutter_car_live/src/pages/login/login_page.dart';
import 'package:flutter_car_live/utils/log_utils.dart';
import 'package:flutter_car_live/utils/navigator_utils.dart';
import 'package:flutter_car_live/widgets/permission_request/permission_request.dart';
import 'package:permission_handler/permission_handler.dart';
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
  List<String> _list = [
    "为您更好的体验应用，需要获取当前位置信息",
    "您已拒绝权限，无法获取位置信息，将无法使用APP",
    "您已拒绝权限，请在设置中心中同意APP的权限请求",
    "其他错误"
  ];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      checkPermisson();
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
      Navigator.of(context).pushReplacementNamed('/main');
      return;
    }
    jumpToPage(LoginPage());
  }

  // 跳转登录页面
  void jumpToPage(Widget page) {
    NavigatorUtils.pushPageByFade(
      context: context,
      targPage: page,
      isReplace: true,
    );
  }

  // 权限检测
  void checkPermisson() {
    NavigatorUtils.pushPageByFade(
      context: context,
      //目标页面
      targPage: PermissionRequest(
        //所需要申请的权限
        permission: Permission.location,
        //显示关闭应用按钮
        isCloseApp: true,
        //提示文案
        permissionList: _list,
      ),
      //权限申请结果
      dismissCallBack: (value) {
        //插值
        LogUtils.e("权限申请结果 $value");

        initData();
      },
    );
  }
}
