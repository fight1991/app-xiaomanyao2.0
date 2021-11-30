import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// @Author: Tiancong
/// @Date: 2021-11-30 15:55:24
/// @Description: 客服微信

class ServerPage extends StatefulWidget {
  final wechatcount;
  const ServerPage({Key? key, String? this.wechatcount}) : super(key: key);
  @override
  _ServerPageState createState() => _ServerPageState();
}

class _ServerPageState extends State<ServerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('微信客服'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
            ),
            Text(
              '客服微信号: ${widget.wechatcount ?? "xxxxxxx"}',
              style: TextStyle(color: Color(0xff2B9DF1)),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 200,
              width: 200,
              color: Colors.pink,
            )
          ],
        ),
      ),
    );
  }
}
