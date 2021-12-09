import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_car_live/providers/permission_model.dart';
import 'package:provider/provider.dart';

/// @Author: Tiancong
/// @Date: 2021-12-02 15:24:48
/// @Description: 控制元素的显示与隐藏

class MenuController extends StatefulWidget {
  final code;
  final child;
  MenuController({Key? key, List<String>? this.code, Widget? this.child});
  @override
  _MenuControllerState createState() => _MenuControllerState();
}

class _MenuControllerState extends State<MenuController> {
  List<String>? permissonCodeList;
  @override
  Widget build(BuildContext context) {
    permissonCodeList = Provider.of<PermissionModel>(context).permissions;
    return Offstage(
      child: widget.child,
      offstage: !permissionFunc(),
    );
  }

  // 是否显示(默认显示)
  permissionFunc() {
    if (widget.code != null) {
      return widget.code
          .any((String item) => permissonCodeList?.contains(item) ?? false);
    }
    return true;
  }
}
