import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_car_live/api/api.dart';
import 'package:flutter_car_live/channel/app_method_channel.dart';
import 'package:flutter_car_live/net/fetch_methods.dart';
import 'package:flutter_car_live/net/http_helper.dart';
import 'package:flutter_car_live/net/response_data.dart';
import 'package:flutter_car_live/providers/location_model.dart';
import 'package:flutter_car_live/src/bean/bean_gun.dart';
import 'package:flutter_car_live/src/bean/bean_location.dart';
import 'package:flutter_car_live/src/subpages/checkcard/widgets/add_oil_dropdown.dart';
import 'package:flutter_car_live/src/subpages/checkcard/widgets/bottom_btn.dart';
import 'package:flutter_car_live/src/subpages/checkcard/widgets/form_box.dart';
import 'package:flutter_car_live/src/subpages/checkcard/widgets/top_bg.dart';
import 'package:flutter_car_live/src/subpages/paystatus/pay_doing.dart';
import 'package:flutter_car_live/src/subpages/paystatus/pay_status.dart';
import 'package:flutter_car_live/utils/navigator_utils.dart';
import 'package:flutter_car_live/utils/toast_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

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
  String _plateNo = ''; // 车牌号
  GunBean? _gunBean;
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
  void confirmBtn() async {
    if (_gunBean == null) {
      ToastUtils.showToast('请选择枪号');
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
    // 扣款
    goPay();
  }

  // 加油时获取选择枪信息
  getSelectedGun(GunBean gunBean) {
    _gunBean = gunBean;
    // 收起键盘
    FocusScope.of(context).requestFocus(FocusNode());
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

  // 加油支付
  goPay() async {
    // 获取设备号
    String deviceNo = await AppMethodChannel.getBNDeviceCode();
    // 获取经纬度信息
    LocationBean location =
        Provider.of<LocationModel>(context, listen: false).locationInfo;
    ResponseInfo responseInfo = await Fetch.post(
      url: HttpHelper.addTrade,
      data: {
        "amount": _price,
        "cid": widget.cid,
        "deviceNo": deviceNo,
        "goodsId": '',
        "latitude": location.latitude,
        "longitude": location.longitude,
        "oilGunId": _gunBean?.oilGunId,
        "orgServiceType": "refueling"
      },
    );
    if (responseInfo.success) {
      // 返回订单号
      // 跳转到交易等待页面
      // 5s中之后查询订单详情
      // 拿到结果再跳转到相应的页面
      NavigatorUtils.pushPage(
          context: context, targPage: PayDoing(orderNo: responseInfo.data));
    }
  }
}
