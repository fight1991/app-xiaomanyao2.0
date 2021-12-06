import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_live/channel/app_method_channel.dart';
import 'package:flutter_car_live/common/global.dart';
import 'package:flutter_car_live/net/dio_utils.dart';
import 'package:flutter_car_live/net/fetch_methods.dart';
import 'package:flutter_car_live/net/response_data.dart';
import 'package:flutter_car_live/src/bean/bean_token.dart';
import 'package:flutter_car_live/src/mixins/init_user.dart';
import 'package:flutter_car_live/src/pages/home/home_page.dart';
import 'package:flutter_car_live/utils/navigator_utils.dart';
import 'package:flutter_car_live/utils/toast_utils.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> with InitUser {
  // 用户名焦点控制器
  FocusNode _userNameFocusNode = new FocusNode();
  // 密码焦点控制器
  FocusNode _pwFocusNode = new FocusNode();
  // 用户名输入框控制器
  TextEditingController _userNameEditController = new TextEditingController();
  // 密码输入框控制器
  TextEditingController _pwController = new TextEditingController();
  bool _pwdShow = false;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    String? lastLoginUserId = Global.profile.lastLogin;
    if (lastLoginUserId != null) {
      _pwFocusNode.requestFocus();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [buildTopBg(), buildFormContainer(), buildSubmitBtn()],
          ),
        ),
      ),
    );
  }

  // 头部区域
  Widget buildTopBg() {
    return Container(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned(
            child: Image.asset(
              'assets/images/common/login-bg.png',
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Image.asset(
            'assets/images/common/login-logo.png',
            width: 80,
            height: 80,
          ),
        ],
      ),
    );
  }

  // 表单区域
  Widget buildFormContainer() {
    return Container(
      padding: EdgeInsets.only(top: 60, left: 40, right: 40, bottom: 40),
      child: Column(
        children: [
          //用户名
          TextField(
            controller: _userNameEditController,
            focusNode: _userNameFocusNode,
            decoration: InputDecoration(hintText: '请输入用户名'),
          ),
          SizedBox(
            height: 18,
          ),
          TextField(
            controller: _pwController,
            focusNode: _pwFocusNode,
            obscureText: !_pwdShow,
            decoration: InputDecoration(
              hintText: '请输入密码',
              suffixIcon: IconButton(
                icon: Icon(
                  _pwdShow ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _pwdShow = !_pwdShow;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 登录api
  loginApi(String username, String password) async {
    // 获取本能设备号
    String deviceCode = await AppMethodChannel.getBNDeviceCode();
    ResponseInfo responseInfo = await Fetch.post(
      url: HttpHelper.login,
      data: {"userId": username, "password": password, "deviceNo": deviceCode},
    );
    if (responseInfo.success) {
      TokenBean tokenInfo = TokenBean.fromJson(responseInfo.data);
      print(tokenInfo.token);
      // 持久化token
      Global.profile.token = tokenInfo.token;
      Global.saveProfile();
      // 查询用户信息
      await getUserInfo(context);
      // 查询权限信息
      await getPermissions(context);
      // 跳转到tab页面
      NavigatorUtils.pushPageByFade(
        context: context,
        targPage: HomePage(),
        isReplace: true,
      );
    }
  }

  // 按钮
  Widget buildSubmitBtn() {
    return GestureDetector(
      onTap: () {
        String username = _userNameEditController.text;
        String pw = _pwController.text;
        if (textFieldValid(username, pw)) {
          loginApi(username, pw);
        }
      },
      child: Container(
        height: 46,
        margin: EdgeInsets.only(top: 50, left: 40, right: 40, bottom: 30),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff0BBAFB), Color(0xff4285EC)],
          ),
          borderRadius: BorderRadius.circular(6),
          // color: Theme.of(context).accentColor,
        ),
        child: Text(
          '登录',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  bool textFieldValid(String username, String pw) {
    if (username.trim().length == 0) {
      ToastUtils.showToast('用户名不能为空');
      return false;
    }
    if (pw.trim().length == 0) {
      ToastUtils.showToast('验证码不能为空');
      return false;
    }
    return true;
  }
}
