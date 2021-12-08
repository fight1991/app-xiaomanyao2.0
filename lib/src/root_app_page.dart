import 'package:flutter/material.dart';
import 'package:flutter_car_live/routes/router_key.dart';
import 'package:flutter_car_live/routes/router_paths.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'index_page.dart';

/// @Author: Tiancong
/// @Date: 2021-11-29 18:07:52
/// @Description: 入口页
class RootAPP extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RootAPPState();
}

class _RootAPPState extends State<RootAPP> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFFf5f9fc)),
      routes: routeMap,
      navigatorKey: RouterKey.navigatorKey,
      debugShowCheckedModeBanner: false,
      home: IndexPage(),
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
    );
  }
}
