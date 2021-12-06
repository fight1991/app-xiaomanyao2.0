import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_live/common/global.dart';
import 'package:flutter_car_live/net/dio_utils.dart';
import 'package:flutter_car_live/net/fetch_methods.dart';
import 'package:flutter_car_live/net/response_data.dart';
import 'package:flutter_car_live/providers/user_model.dart';
import 'package:flutter_car_live/src/bean/bean_app_version.dart';
import 'package:flutter_car_live/src/pages/login/login_page.dart';
import 'package:flutter_car_live/src/subpages/aboutus/about.dart';
import 'package:flutter_car_live/src/subpages/editPw/edit_pw.dart';
import 'package:flutter_car_live/src/subpages/wechatserver/wechatserver.dart';
import 'package:flutter_car_live/utils/confirm_utils.dart';
import 'package:flutter_car_live/utils/log_utils.dart';
import 'package:flutter_car_live/utils/navigator_utils.dart';
import 'package:flutter_car_live/utils/toast_utils.dart';
import 'package:flutter_car_live/widgets/app_upgrade/app_upgrade.dart';
import 'package:flutter_car_live/widgets/iconfont/iconfont.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePage createState() => _MinePage();
}

class _MinePage extends State<MinePage> {
  AppVersionBean? appVersion;
  String? localVersion;
  PackageInfo? packageInfo;
  @override
  void initState() {
    initVersionInfo();
    // // 查看本地有没有app版本信息
    // String? hasVersion = await SPUtil.getString('appVersion');
    // if (hasVersion != null) {
    //   setState(() {
    //     localVersion = hasVersion;
    //   });
    // } else {
    //   AppVersionBean temp = await getAppVersionApi();
    //   localVersion = temp.version;
    //   SPUtil.save('appVersion', localVersion);
    // }
    super.initState();
  }

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
                  trailingText: localVersion ?? '',
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
                ontap: () => listTitleTap('logout'),
              ),
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
      padding: EdgeInsets.symmetric(vertical: 20),
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
      child: Consumer<UserModel>(
        builder: (context, state, child) => ListTile(
          leading: Image.asset('assets/images/common/mine-avatar.png'),
          title: Text('${state.user.orgName}'),
          subtitle: Text('${state.user.userId}'),
        ),
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
        NavigatorUtils.pushPageByFade(
          context: context,
          targPage: EditPassword(),
        );
        break;
      case 'logout':
        logOutBtn();
        break;
    }
  }

  // 检查更新
  void checkVersion() async {
    // AppVersionBean _version = await getAppVersionApi();
    // if (_version.version == localVersion) {
    //   ToastUtils.showToast('已是最新版本');
    //   return;
    // }
    // // 有新版本显示弹框
    // bool flag = await ConfirmDialogUtils.show(
    //   context: context,
    //   title: '检查更新',
    //   content: '发现新版本${_version.version}',
    //   cancelColor: Colors.black54,
    //   cancelText: '暂不更新',
    //   confirmText: '立即更新',
    // );
    // if (flag) {
    //   SPUtil.remove('appVersion');
    //   checkAppVersion(context, showToast: true);
    // }
    //获取当前App的版本信息
    String? appName = packageInfo?.appName;
    String? packageName = packageInfo?.packageName;
    String? version = packageInfo?.version;
    String? buildNumber = packageInfo?.buildNumber;

    LogUtils.e("appName $appName");
    LogUtils.e("packageName $packageName");
    LogUtils.e("version $version");
    LogUtils.e("buildNumber $buildNumber");
    checkAppVersion(context, showToast: true);
  }

  // 初始化版本信息
  initVersionInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      localVersion = packageInfo?.version;
    });
  }

  // 获取软件版本
  Future<AppVersionBean> getAppVersionApi() async {
    AppVersionBean? _version;
    ResponseInfo responseInfo = await Fetch.post(url: HttpHelper.checkApp);
    if (responseInfo.success) {
      _version = AppVersionBean.fromJson(responseInfo.data);
    }
    return _version!;
  }

  // 退出登录
  void logOutBtn() async {
    var flag = await ConfirmDialogUtils.show(
        context: context,
        title: '温馨提示',
        content: '您确定要退出吗?',
        cancelColor: Colors.red,
        confirmText: '退出');
    if (flag) {
      // 点击确定按钮
      ResponseInfo responseInfo = await Fetch.post(url: HttpHelper.logout);
      if (responseInfo.success) {
        ToastUtils.showToast('退出成功!');
        Global.profile.token = '';
        Global.saveProfile();
        NavigatorUtils.pushPageByFade(
          context: context,
          targPage: LoginPage(),
          isReplace: true,
        );
      }
    }
  }
}
