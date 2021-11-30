import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_live/src/pages/login/login_page.dart';
import 'package:flutter_car_live/src/subpages/aboutus/about.dart';
import 'package:flutter_car_live/src/subpages/wechatserver/wechatserver.dart';
import 'package:flutter_car_live/utils/log_utils.dart';
import 'package:flutter_car_live/utils/navigator_utils.dart';
import 'package:flutter_car_live/utils/toast_utils.dart';
import 'package:flutter_car_live/widgets/iconfont/iconfont.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePage createState() => _MinePage();
}

class _MinePage extends State<MinePage> {
  String appVersion = 'v1.0.0';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF8F6F9),
        image: DecorationImage(
          alignment: Alignment.topCenter,
          fit: BoxFit.fitWidth,
          image: AssetImage('assets/images/common/mine-bg.png'),
        ),
      ),
      child: ListView(
        children: [
          buildTopTitle(),
          buildListViewBox(
            children: [
              buildListTitleItem(
                  title: '客服微信',
                  leadingIconColor: Color(0xff0DD7BE),
                  leadingIcon: IconFont.icon_server,
                  ontap: () => listTitleTap('wechat')),
              buildListTitleItem(
                  leadingIconColor: Color(0xffFFC960),
                  title: '检查更新',
                  trailingText: appVersion,
                  leadingIcon: IconFont.icon_refresh,
                  ontap: () => listTitleTap('refresh')),
              buildListTitleItem(
                  leadingIconColor: Color(0xff0769DFF),
                  title: '关于我们',
                  leadingIcon: IconFont.icon_aboutUs,
                  ontap: () => listTitleTap('aboutUs')),
            ],
          ),
          SizedBox(height: 12),
          buildListViewBox(
            children: [
              buildListTitleItem(
                  leadingIconColor: Colors.red,
                  title: '修改密码',
                  leadingIcon: IconFont.icon_edit,
                  ontap: () => listTitleTap('editPw')),
            ],
          ),
          SizedBox(height: 12),
          buildListViewBox(
            children: [
              buildListTitleItem(
                  leadingIconColor: Colors.red,
                  title: '退出登录',
                  leadingIcon: IconFont.icon_logout,
                  trailingShow: false,
                  ontap: () => listTitleTap('logout')),
            ],
          )
        ],
      ),
    );
  }

  // 卡点详情
  Widget buildTopTitle() {
    return Container(
      margin: EdgeInsets.only(top: 45, left: 12, right: 12, bottom: 15),
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 1.0,
          )
        ],
      ),
      child: ListTile(
        leading: Image.asset('assets/images/common/mine-avatar.png'),
        title: Text('大同检测站发卡网点'),
        subtitle: Text('121212121'),
      ),
    );
  }

  // listTilte列表集合
  Widget buildListViewBox({required Iterable<Widget> children}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      ),
      child: Column(
        children: ListTile.divideTiles(
          context: context,
          tiles: children,
        ).toList(),
      ),
    );
  }

  Widget buildListTitleItem(
      {String? title,
      IconData? leadingIcon,
      bool trailingShow = true,
      Function()? ontap,
      Color? leadingIconColor,
      String trailingText = ''}) {
    return Container(
      child: ListTile(
        onTap: ontap,
        leading: Icon(
          leadingIcon,
          color: leadingIconColor,
          size: 30,
        ),
        title: Align(child: Text(title ?? ''), alignment: Alignment(-1.1, 0)),
        trailing: trailingShow
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    trailingText,
                    style: TextStyle(color: Colors.black87),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(IconFont.icon_arrow_right),
                ],
              )
            : Text(''),
      ),
    );
  }

  // 点击事件
  void listTitleTap(String tab) {
    switch (tab) {
      case 'wechat':
        NavigatorUtils.pushPageByFade(
          context: context,
          targPage: ServerPage(),
        );
        break;
      case 'refresh':
        checkVersion();
        break;
      case 'aboutUs':
        NavigatorUtils.pushPageByFade(
          context: context,
          targPage: About(),
        );
        break;
      case 'editPw':
        break;
      case 'logout':
        logOutBtn();
        break;
    }
  }

  // 检查更新
  void checkVersion() async {
    // 有新版本显示弹框
    String version = 'v1.0.1';
    bool flag = await showCommonDialog(
      title: '检查更新',
      content: '发现新版本$version',
      cancelColor: Colors.black54,
      cancelText: '暂不更新',
      confirmText: '立即更新',
    );
    if (flag) {
      LogUtils.e('下载新版本');
    }
  }

  // 退出登录
  void logOutBtn() async {
    var flag = await showCommonDialog(
        title: '温馨提示',
        content: '您确定要退出吗?',
        cancelColor: Colors.red,
        confirmText: '退出');
    if (flag) {
      // 点击确定按钮
      LogUtils.e('确定退出');
      NavigatorUtils.pushPageByFade(
        context: context,
        targPage: LoginPage(),
        isReplace: true,
      );
      ToastUtils.showToast('退出成功!');
    }
  }

  // 显示弹框
  Future<bool> showCommonDialog(
      {String title = '温馨提示',
      String content = '',
      String cancelText = '取消',
      String confirmText = '确认',
      Color? cancelColor,
      Color? confirmColor}) async {
    return await showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            title,
            style: TextStyle(fontSize: 14),
          ),
          content: Container(
            padding: EdgeInsets.only(top: 16, left: 12, right: 12, bottom: 10),
            child: Text(content),
          ),
          actions: [
            // 左边按钮
            CupertinoDialogAction(
              child: Text(
                cancelText,
                style:
                    TextStyle(color: cancelColor ?? Colors.red, fontSize: 14),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            CupertinoDialogAction(
              child: Text(
                confirmText,
                style: TextStyle(
                    color: confirmColor ?? Color(0xff18AEF7), fontSize: 14),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}
