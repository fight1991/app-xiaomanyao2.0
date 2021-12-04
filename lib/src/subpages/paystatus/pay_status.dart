import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_car_live/src/subpages/order/orderDetail.dart';
import 'package:flutter_car_live/src/subpages/order/orderTab.dart';
import 'package:flutter_car_live/utils/confirm_utils.dart';
import 'package:flutter_car_live/utils/navigator_utils.dart';
import 'package:flutter_car_live/widgets/outline_btn/outline_btn.dart';

/// @Author: Tiancong
/// @Date: 2021-12-03 17:32:07
/// @Description: 扣款状态

class PayStatus extends StatefulWidget {
  final status; // success成功 fail失败 wait等待付款
  const PayStatus({Key? key, String? this.status = 'fail'}) : super(key: key);
  @override
  _PayStatusState createState() => _PayStatusState();
}

class _PayStatusState extends State<PayStatus> {
  late TopImgSource _topImgSource;
  String textContent = '3333';
  @override
  void initState() {
    _topImgSource = TopImgSource(widget.status);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (widget.status == 'success') {
            // 返回拦截
            backHome();
            return false;
          }
          bool flag = await ConfirmDialogUtils.show(
            context: context,
            title: '提示',
            content: '确定要退出当前页面?',
            cancelColor: Color(0xff2B9DF0),
            confirmColor: Colors.red,
          );
          if (flag) {
            backHome();
          }
          return false;
        },
        child: Container(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned(
                    child: Image.asset(
                      _topImgSource.topBg,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  Transform(
                    transform: Matrix4.translationValues(0, 30, 0),
                    child: Image.asset(
                      _topImgSource.topIcon,
                      width: 70,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 60),
                child: Text(
                  _topImgSource.text,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: buildTextContent(widget.status, textContent),
              ),
              Container(
                padding: EdgeInsets.only(top: 80),
                child: buildButtonBar(widget.status),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 关掉所有页面返回首页
  Future backHome() async {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/main',
      (route) => false, // 不保留当前页面
    );
  }

  // 再次发起按钮
  submitAginBtn() {}
  // 刷新按钮
  refreshBtn() {}
  // 查看订单按钮
  lookOrderBtn() {
    NavigatorUtils.pushPageByFade(
      context: context,
      targPage: OrderDetail(status: widget.status),
    );
  }

  // 文字内容
  buildTextContent(String? status, String content) {
    switch (status) {
      case 'success':
        return Text(
          content,
          style: TextStyle(fontSize: 16, color: Color(0xff447fff)),
        );
      case 'fail':
        return Text(
          '失败原因: $content',
          style: TextStyle(fontSize: 16, color: Color(0xffFB7267)),
        );
      default:
        return Text(
          content,
          style: TextStyle(color: Color(0xff447fff)),
        );
    }
  }

  // 按钮组
  buildButtonBar(String? status) {
    switch (status) {
      case 'success':
        return OutlineBtn(
          label: '返回首页',
          ontap: () {
            backHome();
          },
        );
      case 'fail':
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlineBtn(
              label: '再次发起',
              color: Color(0xffFB7267),
              ontap: submitAginBtn,
            ),
            SizedBox(width: 40),
            OutlineBtn(
              label: '查看订单',
              ontap: lookOrderBtn,
            ),
          ],
        );
      default:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlineBtn(
                label: '刷新', color: Color(0xff447fff), ontap: refreshBtn),
            SizedBox(width: 40),
            OutlineBtn(
              label: '查看订单',
              ontap: lookOrderBtn,
            ),
          ],
        );
    }
  }
}

class TopImgSource {
  String? status;
  TopImgSource(this.status);
  static String _public = 'assets/images/owner/';
  static String successBg = _public + 'check-bg.png';
  static String successIcon = _public + 'check-fill.png';
  static String failBg = _public + 'close-bg.png';
  static String failIcon = _public + 'close-fill.png';

  String get topBg => _getBg();
  String get topIcon => _getIcon();
  String get text => _getText();

  String _getBg() {
    switch (status) {
      case 'fail':
        return failBg;
      default:
        return successBg;
    }
  }

  String _getIcon() {
    switch (status) {
      case 'fail':
        return failIcon;
      default:
        return successIcon;
    }
  }

  String _getText() {
    switch (status) {
      case 'fail':
        return '扣款失败';
      case 'success':
        return '扣款成功';
      default:
        return '等待付款';
    }
  }
}
