import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// @Author: Tiancong
/// @Date: 2021-12-01 18:20:48
/// @Description: 无

class CheckInfo extends StatefulWidget {
  const CheckInfo({Key? key}) : super(key: key);
  @override
  _CheckInfoState createState() => _CheckInfoState();
}

class _CheckInfoState extends State<CheckInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('核验信息'),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            ListTile(title: Text('卡号'), leading: Text('11')),
            ListTile(title: Text('卡号'), leading: Text('11')),
            ListTile(title: Text('卡号'), leading: Text('11')),
            ListTile(title: Text('卡号'), leading: Text('11'))
          ],
        ),
      ),
    );
  }
}
