import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_car_live/widgets/outline_btn/outline_btn.dart';

/// @Author: Tiancong
/// @Date: 2021-12-03 17:32:07
/// @Description: 扣款状态

class PayStatus extends StatefulWidget {
  final status; // success成功 fail失败 wait等待付款
  const PayStatus({Key? key, String? this.status}) : super(key: key);
  @override
  _PayStatusState createState() => _PayStatusState();
}

class _PayStatusState extends State<PayStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          // 返回拦截
          return await backHome();
        },
        child: Container(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned(
                    child: Image.asset(
                      'assets/images/owner/check-bg.png',
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  Transform(
                    transform: Matrix4.translationValues(0, 30, 0),
                    child: Image.asset(
                      'assets/images/owner/check-fill.png',
                      width: 70,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 60),
                child: Text(
                  '扣款成功',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  '¥ 30.00',
                  style: TextStyle(fontSize: 16, color: Color(0xff447fff)),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 60),
                child: OutlineBtn(
                  label: '返回首页',
                  ontap: () {
                    backHome();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 关掉所有页面返回首页
  Future backHome() async {
    await Navigator.pushNamedAndRemoveUntil(
      context,
      '/main',
      (route) => false, // 不保留当前页面
    );
    return true;
  }
}
