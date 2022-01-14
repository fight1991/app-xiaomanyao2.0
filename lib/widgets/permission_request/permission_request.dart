import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

/// 创建人： Created by TC
///权限请求模版
class PermissionRequest extends StatefulWidget {
  final Permission permission;
  final List<String> permissionList;
  final bool isCloseApp;
  final String leftButtonText;

  PermissionRequest(
      {required this.permission,
      required this.permissionList,
      this.leftButtonText = "退出",
      this.isCloseApp = false});

  @override
  _PermissionRequestState createState() => _PermissionRequestState();
}

class _PermissionRequestState extends State<PermissionRequest>
    with WidgetsBindingObserver {
  //页面的初始化函数
  @override
  void initState() {
    super.initState();
    checkPermisson();
    //注册观察者
    if (WidgetsBinding.instance != null) {
      WidgetsBinding.instance!.addObserver(this);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed && _isGoSetting) {
      checkPermisson();
    }
  }

  ///[PermissionStatus.denied] 用户拒绝访问所请求的特性
  ///[PermissionStatus.granted] 用户被授予对所请求特性的访问权。
  ///[PermissionStatus.restricted] iOS 平台 用户拒绝这个权限
  ///[PermissionStatus.limited] 用户已授权此应用程序进行有限访问。
  ///[PermissionStatus.permanentlyDenied] 被永久拒绝
  void checkPermisson({PermissionStatus? status}) async {
    print('status======================$status');
    //权限
    Permission permission = widget.permission;

    if (status == null) {
      //权限状态
      status = await permission.status;
    }
    if (status.isGranted) {
      //权限通过
      Navigator.of(context).pop(true);
      return;
    }
    if (status.isDenied) {
      // 权限拒绝
      if (Platform.isIOS) {
        showPermissonAlert(widget.permissionList[2], "去设置中心", permission,
            isSetting: true);
        return;
      }
      //用户第一次申请拒绝
      showPermissonAlert(widget.permissionList[1], "重试", permission);
      return;
    }
    if (status.isPermanentlyDenied) {
      //权限永久拒绝，且不在提示，需要进入设置界面，IOS和Android不同
      showPermissonAlert(widget.permissionList[2], "去设置中心", permission,
          isSetting: true);
      return;
    }
  }

  //是否去设置中心
  bool _isGoSetting = false;

  void showPermissonAlert(
      String message, String rightString, Permission permission,
      {bool isSetting = false}) {
    showCupertinoDialog(
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text("温馨提示"),
            content: Container(
              padding: EdgeInsets.all(12),
              child: Text(message),
            ),
            actions: [
              //左边的按钮
              CupertinoDialogAction(
                child: Text("${widget.leftButtonText}"),
                onPressed: () {
                  if (widget.isCloseApp) {
                    closeApp();
                  } else {
                    Navigator.of(context).pop(false);
                  }
                },
              ),
              //右边的按钮
              CupertinoDialogAction(
                child: Text("$rightString"),
                onPressed: () {
                  //关闭弹框
                  Navigator.of(context).pop();
                  if (isSetting) {
                    _isGoSetting = true;
                    //去设置中心
                    openAppSettings();
                  } else {
                    //申请权限
                    requestPermiss(permission);
                  }
                },
              )
            ],
          );
        },
        context: context);
  }

  void requestPermiss(Permission permission) async {
    //发起权限申请
    PermissionStatus status = await permission.request();
    //校验
    checkPermisson(status: status);
  }

  /// TODO 暂未使用
  void requestPermissionList(List<Permission> list) async {
    //多个权限申请
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
    ].request();
  }

  void closeApp() {
    //关闭应用的方法
    SystemChannels.platform.invokeMethod("SystemNavigator.pop");
  }

  @override
  void dispose() {
    //注销观察者
    if (WidgetsBinding.instance != null) {
      WidgetsBinding.instance!.removeObserver(this);
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
    );
  }
}
