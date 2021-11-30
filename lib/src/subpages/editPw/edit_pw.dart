import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_car_live/widgets/common_btn/common_btn.dart';

/// @Author: Tiancong
/// @Date: 2021-11-30 17:13:03
/// @Description: 修改密码页面

class EditPassword extends StatefulWidget {
  const EditPassword({Key? key}) : super(key: key);
  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7F7F7),
      appBar: AppBar(
        title: Text('修改密码'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 10),
        child: Container(
          child: Column(
            children: [
              buildFormBox(),
              Expanded(
                child: buildBtn(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFormBox() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(hintText: '请输入原密码'),
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            decoration: InputDecoration(hintText: '请输入新密码'),
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            decoration:
                InputDecoration(hintText: '请再次输入新密码', border: InputBorder.none),
          ),
        ],
      ),
    );
  }

  Widget buildBtn() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
        child: CommonBtn(
          ontap: confirmBtn,
        ),
      ),
    );
  }

  void confirmBtn() {}
}
