import 'package:flutter/cupertino.dart';
import 'package:flutter_car_live/src/index_page.dart';
import 'package:flutter_car_live/src/pages/home/home_page.dart';
import 'package:flutter_car_live/src/pages/login/login_page.dart';

Map<String, WidgetBuilder> routeMap = {
  '/index': (ctx) => IndexPage(),
  '/login': (ctx) => LoginPage(),
  '/main': (ctx) => HomePage()
};
