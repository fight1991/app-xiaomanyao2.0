import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
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
  int? _currentGun; // 当前枪号
  String? _ownerType; // 商户类型
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // 收起键盘
    FocusScope.of(context).requestFocus(FocusNode());
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

  // 点击确定按钮
  void confirmBtn() {
    if (_currentGun == null) {
      ToastUtils.showToast('请选择枪号');
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

  // 选择枪号按钮
  void selectBtn(int index) {
    setState(() {
      _currentGun = index;
    });
    Navigator.of(context).pop();
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
          ListTile(
            dense: true,
            title: Text('选择枪号'),
            contentPadding: EdgeInsets.zero,
          ),
          GestureDetector(
            onTap: showBottomSelect,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: buildOwnerType(),
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
    Widget oil = GestureDetector(
      onTap: showBottomSelect,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Text(
              '枪号',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Expanded(
              child: Text(
                '${_currentGun ?? ""}',
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
    );
    return oil;
  }

  // 底部弹框widget
  Widget buildBottomBox() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
      height: MediaQuery.of(context).size.height * 0.4,
      child: GridView.builder(
          itemCount: 20,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 2,
          ),
          itemBuilder: (BuildContext context, int index) {
            return bottomSelectItem(index);
          }),
    );
  }

  // 底部选择项
  Widget bottomSelectItem(int index) {
    return GestureDetector(
      onTap: () {
        selectBtn(index);
        // 收起键盘
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3),
          border: Border.all(
              color: _currentGun == index ? Color(0xff3E89EB) : Colors.black12),
        ),
        child: Text(
          '$index',
          style: TextStyle(
              color: _currentGun == index ? Color(0xff3E89EB) : Colors.black),
        ),
      ),
    );
  }

  // 底部弹出选择按钮
  void showBottomSelect() {
    showModalBottomSheet(
      context: context,
      // backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      builder: (BuildContext context) {
        return buildBottomBox();
      },
    );
  }
}
