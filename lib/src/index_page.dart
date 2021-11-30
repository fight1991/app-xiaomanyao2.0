import 'package:flutter/material.dart';
import 'package:flutter_car_live/src/pages/home/home_page.dart';
import 'package:flutter_car_live/src/pages/login/login_page.dart';
import 'package:flutter_car_live/utils/navigator_utils.dart';

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
class _IndexPage extends State<IndexPage> {
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
  void initData() {
    // 假设没有登录则跳转到登录页面
    NavigatorUtils.pushPageByFade(
      context: context,
      // targPage: LoginPage(),
      targPage: HomePage(),
      isReplace: true,
    );
  }
}
