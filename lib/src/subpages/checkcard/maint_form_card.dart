import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_car_live/api/api.dart';
import 'package:flutter_car_live/src/subpages/checkcard/widgets/bottom_btn.dart';
import 'package:flutter_car_live/src/subpages/checkcard/widgets/form_box.dart';
import 'package:flutter_car_live/src/subpages/checkcard/widgets/top_bg.dart';
import 'package:flutter_car_live/src/subpages/commonApi/public_req.dart';
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
    getCarInfo();
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
                itemSubTitle: buildSubTitle(),
                itemTitle: _plateNo,
                getValue: getInputValue,
              ),
              BottomBtn(ontap: confirmBtn)
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
    PublicReq.goPay(
      context,
      price: _price,
      cid: widget.cid,
      goodsId: '',
      oilGunId: '',
      orgServiceType: 'repair',
    );
  }

  // 获取表单值
  getInputValue(String value) {
    _price = value;
  }

  // 获取车牌号信息
  getCarInfo() async {
    var vehicleBean = await Api.getPlateNoByCid(data: widget.cid);
    if (vehicleBean != null) {
      if (mounted) {
        setState(() {
          _plateNo = vehicleBean.plateNo ?? '';
        });
      }
    }
  }

  // 头部信息
  Widget buildSubTitle() {
    return Column(
      children: [
        ListTile(
          dense: true,
          title: Text('选择项目'),
          contentPadding: EdgeInsets.zero,
        ),
        Row(
          children: [
            Text(
              '项目',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Expanded(
              child: Text(
                widget.orgServiceType == 'repair' ? '维修' : '自定义',
                style: TextStyle(
                  color: Color(0xff447fff),
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
