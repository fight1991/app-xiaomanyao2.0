import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_car_live/providers/permission_model.dart';
import 'package:flutter_car_live/providers/user_model.dart';
import 'package:provider/provider.dart';
import 'common/global.dart';
import 'src/root_app_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // 去掉此代码 初始化SharedPreferences报错
  Global.init().then(
    (e) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => UserModel()),
          ChangeNotifierProvider(create: (ctx) => PermissionModel()),
        ],
        child: RootAPP(),
      ),
    ),
  );
  if (Platform.isAndroid) {
    // 设置状态栏背景及颜色
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    // SystemChrome.setEnabledSystemUIOverlays([]); //隐藏状态栏
  }
}
