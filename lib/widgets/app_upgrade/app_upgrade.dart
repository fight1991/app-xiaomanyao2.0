import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_car_live/net/fetch_methods.dart';
import 'package:flutter_car_live/net/http_helper.dart';
import 'package:flutter_car_live/net/response_data.dart';
import 'package:flutter_car_live/src/bean/bean_app_version.dart';
import 'package:flutter_car_live/utils/log_utils.dart';
import 'package:flutter_car_live/utils/navigator_utils.dart';
import 'package:flutter_car_live/utils/toast_utils.dart';
import 'package:r_upgrade/r_upgrade.dart';

checkAppVersion(BuildContext context,
    {bool showToast = false, String? version, String? buildNumber}) async {
  ResponseInfo responseInfo = await Fetch.post(
      url: HttpHelper.checkApp,
      data: {"appName": "航天移动收单App", "appOs": "Android"});
  if (!responseInfo.success) {
    ToastUtils.showToast("检查更新失败,请稍后重试");
    return;
  }
  AppVersionBean appVersionBean = AppVersionBean.fromJson(responseInfo.data);
  // 是否需要安装
  if (!(appVersionBean.requireInstall!)) {
    ToastUtils.showToast("已是最新版本");
    return;
  }
  // 版本号是否一致且构建号<线上构建号
  int onlineNum = int.parse(appVersionBean.buildNum ?? '');
  int localNum = int.parse(buildNumber ?? '');
  if (onlineNum <= localNum) {
    ToastUtils.showToast("已是最新版本");
    return;
  }
  showAppUpgradeDialog(
    context: context,
    upgradTitle: appVersionBean.title ?? '',
    upgradText: appVersionBean.description ?? '',
    apkUrl: appVersionBean.downloadUrl ?? '',
  );
}

/// lib/app/page/common/app_upgrade.dart
///便捷显示升级弹框
void showAppUpgradeDialog({
  required BuildContext context,
  //是否强制升级
  bool isForce = false,
  //点击背景是否消失
  bool isBackDismiss = false,
  //升级标题
  String upgradTitle = "",
  //升级内容描述
  String upgradText = "",
  String apkUrl = "",
}) {
  //通过透明的方式来打开弹框
  NavigatorUtils.pushPageByFade(
    context: context,
    opaque: false,
    targPage: //自定义的弹框页面
        AppUpgradePage(
      isBackDismiss: isBackDismiss,
      isForce: isForce,
      upgradTitle: upgradTitle,
      upgradText: upgradText,
      apkUrl: apkUrl,
    ),
  );
}

/// lib/app/page/common/app_upgrade.dart
class AppUpgradePage extends StatefulWidget {
  //是否强制升级
  final bool isForce;

  //点击背景是否消失
  final bool isBackDismiss;

  final String upgradText;
  final String upgradTitle;

  final String apkUrl;

  AppUpgradePage({
    this.isForce = false,
    this.upgradText = "",
    this.apkUrl = "",
    this.upgradTitle = "",
    this.isBackDismiss = false,
  });

  @override
  _AppUpgradeState createState() => _AppUpgradeState();
}

class _AppUpgradeState extends State<AppUpgradePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 54 透明度的黑色 0~255 0完全透明 255 不透明
      backgroundColor: Colors.black54,
      body: new Material(
        type: MaterialType.transparency,
        //监听Android设备上的返回键盘物理按钮
        child: WillPopScope(
          onWillPop: () async {
            //这里返回true表示不拦截
            //返回false拦截事件的向上传递
            if (_taskId != null) {
              // 有下载任务不关闭弹窗
              return Future.value(false);
            }
            closeApp(context);
            return Future.value(true);
          },
          //填充布局的容器
          child: GestureDetector(
            //点击背景消失
            onTap: () {
              //非强制升级下起作用
              //并且用户设置了点击背景升级弹框消失
              if (!widget.isForce && widget.isBackDismiss) {
                closeApp(context);
              }
            },
            //升级内容区域
            child: buildBodyContainer(context),
          ),
        ),
      ),
    );
  }

  Container buildBodyContainer(BuildContext context) {
    //充满屏幕的透明容器
    return Container(
      width: double.infinity,
      height: double.infinity,
      //线性布局
      child: Column(
        //子Widget水平方向居中
        crossAxisAlignment: CrossAxisAlignment.center,
        //子Widget垂直方向居中
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildContainer(context),
        ],
      ),
    );
  }

  ///构建白色区域的弹框
  Widget buildContainer(BuildContext context) {
    return ClipRRect(
      //裁剪的圆角背景
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
      child: Container(
        width: 280, height: 320,
        color: Colors.white,
        //弹框标题、内容、按钮 线性排列
        child: buildColumn(context),
      ),
    );
  }

  //白色圆角框中线性排列的升级说明
  Column buildColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      //包裹子Widget
      mainAxisSize: MainAxisSize.min,
      children: [
        //显示标题
        buildHeaderWidget(context),
        SizedBox(height: 12),
        // 标题
        Text(
          "${widget.upgradTitle}",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 12),
        //中间显示的更新内容 可滑动
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 14),
              child: Text(
                "${widget.upgradText}",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
        //底部的按钮区域
        buildBottomButton()
      ],
    );
  }

  //底部的按钮区域  构建StreamBuilder
  StreamBuilder<double> buildBottomButton() {
    return StreamBuilder<double>(
      stream: _streamController.stream,
      initialData: 0.0,
      builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
        return Container(
          child: Stack(
            children: [
              //自定义按钮
              buildMaterial(context, snapshot),
              //结合 Align 实现的裁剪动画
              ClipRect(
                child: Align(
                  alignment: Alignment.centerLeft,
                  widthFactor: (snapshot.data!) * 0.01,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  //自定义按钮
  Material buildMaterial(BuildContext context, AsyncSnapshot<double> snapshot) {
    return Material(
      color: Color(0xff76B6FF),
      child: Ink(
        child: InkWell(
          //点击事件
          onTap: onTapFunction,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: Text(
              //不同状态显示不同的文本内容
              buildButtonText(snapshot.data!),
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  //一个标题 、一个按钮
  Container buildHeaderWidget(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 24,
            child: Text(
              "版本更新",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
          ),
          //右上角
          Positioned(
            right: 0,
            child: CloseButton(
              onPressed: () {
                closeApp(context);
              },
            ),
          )
        ],
      ),
    );
  }

  void closeApp(BuildContext context) {
    // 如果正在下载中,则取消当前下载任务
    if (_taskId != null) {
      RUpgrade.cancel(_taskId!);
    }

    //如果是强制升级 点击物理返回键退出应用程序
    if (widget.isForce) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    } else {
      Navigator.of(context).pop();
    }
  }

  StreamController<double> _streamController = new StreamController();

  //当前状态
  InstallStatues _installStatues = InstallStatues.none;

  //apk保存的路径
  String? appLocalPath;

  // 下载任务id
  int? _taskId;

  void downApkFunction() async {
    // 下载apk
    _taskId = await RUpgrade.upgrade(
      widget.apkUrl,
      fileName: 'xiaomanyao.apk',
      // 关闭自动安装
      isAutoRequestInstall: false,
      // 不显示状态栏通知
      notificationVisibility: NotificationVisibility.VISIBILITY_HIDDEN,
    );
    // 监听进度
    RUpgrade.stream.listen((DownloadInfo info) {
      double? percent = info.percent;
      // 下载中
      if (info.status == DownloadStatus.STATUS_RUNNING) {
        LogUtils.e('当前下载进度$percent');
        _streamController.add(percent!);
        setState(() {});
        return;
      }
      // 下载成功
      if (info.status == DownloadStatus.STATUS_SUCCESSFUL) {
        _installStatues = InstallStatues.downFinish;
        installApkFunction();
        print("下载完成");
        setState(() {
          _streamController.add(0.0);
        });
        return;
      }

      // 下载失败
      if (info.status == DownloadStatus.STATUS_FAILED) {
        //取消网络请求
        //下载失败都会在这回调
        //可自行处理
        _installStatues = InstallStatues.downFaile;
        setState(() {});
        return;
      }
    });
  }

  void installApkFunction() async {
    if (_taskId != null) {
      bool? installSuccess = await RUpgrade.install(_taskId!);
      if (installSuccess == true) {
        LogUtils.e('安装完成');
        return;
      }
      //安装失败
      _installStatues = InstallStatues.installFaile;
      setState(() {});
    }
  }

  String buildButtonText(double progress) {
    String buttonText = "";
    switch (_installStatues) {
      case InstallStatues.none:
        buttonText = '升级';
        break;
      case InstallStatues.downing:
        buttonText = '下载中' + (progress).toStringAsFixed(0) + "%";
        break;
      case InstallStatues.downFinish:
        buttonText = '点击安装';
        break;
      case InstallStatues.downFaile:
        buttonText = '重新下载';
        break;
      case InstallStatues.installFaile:
        buttonText = '重新安装';
        break;
    }
    return buttonText;
  }

  void onTapFunction() {
    //如果是iOS手机就跳转APPStore
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      RUpgrade.upgradeFromAppStore('appid');
      return;
    }
    //第一次下载
    //下载失败点击重试
    if (_installStatues == InstallStatues.none ||
        _installStatues == InstallStatues.downFaile) {
      _installStatues = InstallStatues.downing;
      downApkFunction();
    } else if (_installStatues == InstallStatues.downFinish ||
        _installStatues == InstallStatues.installFaile) {
      //安装失败时
      //下载完成时 点击触发安装
      installApkFunction();
    }
  }
}

enum InstallStatues {
  //无状态
  none,
  //下载中
  downing,
  //下载完成
  downFinish,
  //下载失败
  downFaile,
  //安装失败
  installFaile,
}
