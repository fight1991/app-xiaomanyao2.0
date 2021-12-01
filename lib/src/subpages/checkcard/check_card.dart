import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// @Author: Tiancong
/// @Date: 2021-12-01 09:21:00
/// @Description: 卡片核验页面

class CheckCard extends StatefulWidget {
  final pageTitle;
  final pageFlag; // check卡片核验,unbind为卡片解绑
  CheckCard({Key? key, String? this.pageTitle, String? this.pageFlag})
      : super(key: key);
  @override
  _CheckCardState createState() => _CheckCardState();
}

class _CheckCardState extends State<CheckCard> {
  @override
  void initState() {
    // 监听扫描跳转相关页面
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageTitle ?? '卡片核验验'),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 60),
            Image.asset(
              'assets/images/common/scan-photo.png',
              width: 120,
            ),
            SizedBox(height: 25),
            Text(
              '准备扫描',
              style: TextStyle(
                color: Color(0xff10B4F9),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 50),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(color: Color(0xffF1F9FF)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/common/about.png',
                    width: 30,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '请靠近车头对准电子车牌',
                        style: TextStyle(color: Color(0xff10B4F9)),
                      ),
                      Text(
                        '请按扫描键',
                        style: TextStyle(color: Color(0xff10B4F9)),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
