import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_car_live/src/subpages/checkcard/widgets/bottom_btn.dart';
import 'package:flutter_car_live/src/subpages/checkcard/widgets/form_box.dart';
import 'package:flutter_car_live/src/subpages/checkcard/widgets/top_bg.dart';
import 'package:flutter_car_live/src/subpages/paystatus/pay_status.dart';
import 'package:flutter_car_live/utils/log_utils.dart';
import 'package:flutter_car_live/utils/navigator_utils.dart';
import 'package:flutter_car_live/utils/toast_utils.dart';

/// @Author: Tiancong
/// @Date: 2021-12-03 10:51:29
/// @Description: 维保选项

class MaintFormCard extends StatefulWidget {
  final cid;
  final orgServiceType;
  const MaintFormCard({
    Key? key,
    String? this.cid,
    String? this.orgServiceType,
  }) : super(key: key);
  @override
  _MaintFormCardState createState() => _MaintFormCardState();
}

class _MaintFormCardState extends State<MaintFormCard> {
  String? _price;
  String? _plateNo;
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
                itemSubTitle: Text('哈哈'),
                itemTitle: _plateNo,
                getValue: getInputValue,
              ),
              BottomBtn()
            ],
          ),
        ),
      ),
    );
  }

  // 点击确定按钮
  void confirmBtn() {
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

  // 获取表单值
  getInputValue(String value) {
    _price = value;
  }
}
