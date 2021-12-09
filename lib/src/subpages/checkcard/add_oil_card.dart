import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_car_live/src/bean/bean_gun.dart';
import 'package:flutter_car_live/src/subpages/checkcard/widgets/add_oil_dropdown.dart';
import 'package:flutter_car_live/src/subpages/checkcard/widgets/bottom_btn.dart';
import 'package:flutter_car_live/src/subpages/checkcard/widgets/form_box.dart';
import 'package:flutter_car_live/src/subpages/checkcard/widgets/top_bg.dart';
import 'package:flutter_car_live/src/subpages/paystatus/pay_status.dart';
import 'package:flutter_car_live/utils/log_utils.dart';
import 'package:flutter_car_live/utils/navigator_utils.dart';
import 'package:flutter_car_live/utils/toast_utils.dart';

/// @Author: Tiancong
/// @Date: 2021-12-03 10:51:29
/// @Description: 收费加油页面

class AddOilCard extends StatefulWidget {
  final cid;
  const AddOilCard({Key? key, String? this.cid}) : super(key: key);
  @override
  _AddOilCardState createState() => _AddOilCardState();
}

class _AddOilCardState extends State<AddOilCard> {
  String? _price;
  String _plateNo = '1212'; // 车牌号
  dynamic _selectValue = ''; // 当前枪号
  GunBean? _gunBean;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
      body: WillPopScope(
        onWillPop: () async {
          // 先收起键盘再返回
          FocusScope.of(context).requestFocus(FocusNode());
          return await Future.delayed(Duration.zero, () {
            return true;
          });
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              TopBg(),
              FormBox(
                itemSubTitle: OilDropdown(
                  getSelected: getSelectedGun,
                ),
                itemTitle: _plateNo,
                getValue: getInputValue,
              ),
              BottomBtn(ontap: confirmBtn),
            ],
          ),
        ),
      ),
    );
  }

  // 点击确定按钮
  void confirmBtn() {
    if (_selectValue == null || _selectValue == '') {
      ToastUtils.showToast('请选择项目或枪号');
      return;
    }
    if (_price?.length == 0) {
      ToastUtils.showToast('请输入金额');
      return;
    }
    RegExp reg = new RegExp(r"^\d+(\.)?(\d+)?$");
    if (!reg.hasMatch(_price!)) {
      ToastUtils.showToast('请输入正确格式的金额');
      return;
    }
    NavigatorUtils.pushPage(context: context, targPage: PayStatus());
    LogUtils.e('交易处理中');
  }

  // 加油时获取选择枪信息
  getSelectedGun(GunBean gunBean) {
    _selectValue = gunBean.oilGunName;
    _gunBean = gunBean;
    // 收起键盘
    FocusScope.of(context).requestFocus(FocusNode());
  }

  // 获取表单值
  getInputValue(String value) {
    _price = value;
  }
}
