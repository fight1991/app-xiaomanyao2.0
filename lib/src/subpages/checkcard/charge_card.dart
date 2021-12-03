import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_car_live/src/subpages/checkcard/widgets/add_oil_dropdown.dart';
import 'package:flutter_car_live/src/subpages/checkcard/widgets/maint_dropdown.dart';
import 'package:flutter_car_live/utils/log_utils.dart';
import 'package:flutter_car_live/utils/toast_utils.dart';
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
  FocusNode _priceFocusNode = FocusNode();
  String _plateNo = '1212'; // 车牌号
  dynamic _selectValue = ''; // 当前枪号
  String? _ownerType = 'other'; // 商户类型
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // 收起键盘
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
              buildTopBg(),
              buildFormBox(),
              buildBtnBox(),
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
    String price = _priceController.text.trim();
    if (price.length == 0) {
      ToastUtils.showToast('请输入金额');
      return;
    }
    RegExp reg = new RegExp(r"^\d+(\.)?(\d+)?$");
    if (!reg.hasMatch(price)) {
      ToastUtils.showToast('请输入正确格式的金额');
      return;
    }
    LogUtils.e('交易处理中');
  }

  // 获取选择的值
  getSelectedValue(value) {
    _selectValue = value;
    // 收起键盘
    FocusScope.of(context).requestFocus(FocusNode());
  }

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
          buildOwnerType(),
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
                    style: TextStyle(color: Color(0xff447fff)),
                    textAlign: TextAlign.center,
                    controller: _priceController,
                    focusNode: _priceFocusNode,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
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

  // 加油/(洗车,保养,维修)
  Widget buildOwnerType() {
    print(_ownerType);
    if (_ownerType == 'oil') {
      return OilDropdown(getSelected: getSelectedValue);
    } else if (_ownerType == 'other') {
      return MaintDropdown(getSelected: getSelectedValue);
    } else {
      return Container();
    }
  }
}
