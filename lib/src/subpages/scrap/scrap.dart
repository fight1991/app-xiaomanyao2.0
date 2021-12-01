import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_car_live/utils/bottomsheet_utils.dart';
import 'package:flutter_car_live/utils/log_utils.dart';
import 'package:flutter_car_live/utils/toast_utils.dart';
import 'package:flutter_car_live/widgets/common_btn/common_btn.dart';
import 'package:flutter_car_live/widgets/iconfont/iconfont.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

/// @Author: Tiancong
/// @Date: 2021-12-01 09:50:41
/// @Description: 卡片报废页面

class Scrap extends StatefulWidget {
  Scrap({Key? key}) : super(key: key);
  @override
  _ScrapState createState() => _ScrapState();
}

class _ScrapState extends State<Scrap> {
  String _cardNo = ''; // 卡号
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('卡片报废'),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: ListView(
          children: [buildFormBox(), buildBtn()],
        ),
      ),
    );
  }

  Widget buildFormBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Text('卡号'),
                Expanded(
                  child: Text(
                    _cardNo,
                    textAlign: TextAlign.end,
                  ),
                ),
                GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(
                      IconFont.icon_scan,
                      color: Color(0xff2A9AEC),
                      size: 40,
                    ),
                  ),
                  onTap: scanCardNo,
                )
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              '报废原因',
            ),
          ),
          Container(
            child: TextField(
              maxLines: 4,
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
          Divider(
            height: 1,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              '上传附件',
            ),
          ),
          // 上传组件
          GestureDetector(
            onTap: showPickerBtn,
            child: Image.asset(
              'assets/images/card/add.png',
              width: 100,
            ),
          ),
          SizedBox(height: 30)
        ],
      ),
    );
  }

  Widget buildBtn() {
    return Container(
      margin: EdgeInsets.only(top: 60, bottom: 20),
      child: CommonBtn(
        label: '确认报废',
      ),
    );
  }

  // 扫描卡号电子车牌中的二维码,是个链接http://RFID.122.GOV.CN/RFID/900000000..
  void scanCardNo() async {
    LogUtils.e('点击了');
    String? res = await scanner.scan();

    if (res == null) {
      ToastUtils.showToast('扫描失败');
      return;
    }
    // 以http://RFID开头
    if (!res.startsWith('HTTP://RFID')) {
      ToastUtils.showToast('无效的二维码');
      return;
    }
    int index = res.indexOf('/RFID/');
    if (index < 0) {
      ToastUtils.showToast('未获取到卡号信息');
      return;
    }
    String temp = res.substring(index + 6, index + 6 + 12);
    setState(() {
      _cardNo = temp;
    });
  }

  // 底部弹出拍照/从相册中选择
  void showPickerBtn() {
    List<String> listOp = ['拍照', '从相册中选择'];
    BottomSheetUtils.show(
        context: context, list: listOp, action: chooseImgFrom);
  }

  void chooseImgFrom(int index) {
    // 打开摄像头
    if (index == 0) {
      LogUtils.e('打开摄像头');
      return;
    }
    // 从本地取
    if (index == 1) {
      LogUtils.e('打开相册');
      return;
    }
    return;
  }
}
