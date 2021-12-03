import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_car_live/widgets/iconfont/iconfont.dart';

/// @Author: Tiancong
/// @Date: 2021-12-03 10:51:29
/// @Description: 收费加油页面

class ChargeCard extends StatefulWidget {
  final cid;
  const ChargeCard({Key? key, String? this.cid}) : super(key: key);
  @override
  _ChargeCardState createState() => _ChargeCardState();
}

class _ChargeCardState extends State<ChargeCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F6F7),
      appBar: AppBar(
        title: Text('收费信息'),
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff0BBAFB), Color(0xff4285EC)],
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Container(),
        ),
      ),
      body: Flex(
        direction: Axis.vertical,
        children: [buildFormBox()],
      ),
    );
  }

  Widget buildFormBox() {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, -2),
            spreadRadius: 1.0,
          )
        ],
      ),
      child: Column(
        children: [
          ListTile(
            dense: true,
            title: Text('选择枪号'),
            contentPadding: EdgeInsets.zero,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Text(
                  '枪号',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Expanded(
                  child: Text(
                    '2121',
                    style: TextStyle(
                      color: Color(0xff447fff),
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Icon(
                  IconFont.icon_arrow_down_line,
                  size: 20,
                ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            dense: true,
            title: Text('输入金额'),
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
