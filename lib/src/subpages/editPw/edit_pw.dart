import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_car_live/common/global.dart';
import 'package:flutter_car_live/net/dio_utils.dart';
import 'package:flutter_car_live/net/fetch_methods.dart';
import 'package:flutter_car_live/net/response_data.dart';
import 'package:flutter_car_live/utils/toast_utils.dart';
import 'package:flutter_car_live/widgets/common_btn/common_btn.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// @Author: Tiancong
/// @Date: 2021-11-30 17:13:03
/// @Description: 修改密码页面

class EditPassword extends StatefulWidget {
  const EditPassword({Key? key}) : super(key: key);
  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  TextEditingController _oldPwTextController = TextEditingController();
  TextEditingController _newPwTextController = TextEditingController();
  TextEditingController _newPwAginTextController = TextEditingController();

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
            controller: _oldPwTextController,
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            decoration: InputDecoration(hintText: '请输入新密码'),
            controller: _newPwAginTextController,
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            controller: _newPwAginTextController,
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

  void confirmBtn() {
    // 表单校验
    String oldPw = _oldPwTextController.text.trim();
    String newPw = _newPwTextController.text.trim();
    String newPwAgin = _newPwAginTextController.text.trim();
    if (oldPw.length == 0) {
      ToastUtils.showToast('请输入原密码');
      return;
    }
    if (newPw.length == 0) {
      ToastUtils.showToast('请输入新密码');
    }
    if (newPwAgin.length == 0) {
      ToastUtils.showToast('请再次输入新密码');
    }
    RegExp reg = new RegExp(r"^[a-zA-Z0-9_]{6,32}$");
    if (!reg.hasMatch(newPw)) {
      ToastUtils.showToast('请输入至少6位由数字或字母组成的密码');
      return;
    }
    if (newPwAgin != newPw) {
      ToastUtils.showToast('2次输入的密码不一致');
      return;
    }
  }

  changPwApi(String oldP, String newP) async {
    ResponseInfo responseInfo = await Fetch.post(
      url: HttpHelper.changePassword,
      data: {"password": oldP, "passwordNew": newP},
    );
    if (responseInfo.success) {
      ToastUtils.showToast('修改成功,请重新登录');
      Global.profile.token = '';
      Global.saveProfile();
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }
}
