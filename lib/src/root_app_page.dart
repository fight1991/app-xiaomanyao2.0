import 'package:flutter/material.dart';
import 'package:flutter_car_live/routes/router_paths.dart';
import 'index_page.dart';

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
      home: IndexPage(),
    );
  }
}
