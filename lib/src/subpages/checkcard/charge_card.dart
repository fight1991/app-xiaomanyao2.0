import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_car_live/widgets/common_btn/common_btn.dart';
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
  TextEditingController _priceController = TextEditingController();
  String _plateNo = '苏B3939';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F6F7),
      resizeToAvoidBottomInset: false,
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
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(80),
        //   child: Container(),
        // ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            buildTopBg(),
            buildFormBox(),
            buildBtnBox(),
          ],
        ),
      ),
    );
  }

  // 点击按钮
  void confirmBtn() {}
  // 头部背景
  Widget buildTopBg() {
    return Positioned(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff0BBAFB), Color(0xff4285EC)],
          ),
        ),
      ),
    );
  }

  // 表单区域
  Widget buildFormBox() {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(left: 15, right: 15, top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 2),
            spreadRadius: 1.0,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              _plateNo,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
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
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Text(
                  '¥',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: _priceController,
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
                Visibility(
                  visible: false,
                  child: Icon(
                    IconFont.icon_arrow_down_line,
                    size: 20,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 按钮区域
  Widget buildBtnBox() {
    return Positioned(
      bottom: 30,
      left: 0,
      right: 0,
      child: Padding(
        child: CommonBtn(
          ontap: confirmBtn,
        ),
        padding: EdgeInsets.only(
          left: 30,
          right: 30,
        ),
      ),
    );
  }
}
