import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_car_live/net/dio_utils.dart';
import 'package:flutter_car_live/net/fetch_methods.dart';
import 'package:flutter_car_live/net/response_data.dart';
import 'package:flutter_car_live/utils/log_utils.dart';
import 'package:flutter_car_live/utils/toast_utils.dart';
import 'package:flutter_car_live/widgets/common_btn/common_btn.dart';
import 'package:flutter_car_live/widgets/iconfont/iconfont.dart';
import 'package:flutter_car_live/widgets/upload_file/upload_file.dart';
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
  TextEditingController reasonTextController = TextEditingController();
  // 电子标牌卡号,可编辑
  TextEditingController _cardNoController = TextEditingController();
  FocusNode _cardNoFocusNode = FocusNode();
  String licenseUrl = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('卡片报废'),
        elevation: 0,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // 点击空白区域收起键盘
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          margin: EdgeInsets.all(20),
          child: ListView(
            children: [buildFormBox(), buildBtn()],
          ),
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
                  child: TextField(
                    controller: _cardNoController,
                    keyboardType: TextInputType.number,
                    focusNode: _cardNoFocusNode,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(border: InputBorder.none),
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
              controller: reasonTextController,
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
          // 文件上传组件
          UploadFile(getUrl: (String url) => {licenseUrl = url}),
          SizedBox(height: 30)
        ],
      ),
    );
  }

  // 报废按钮
  Widget buildBtn() {
    return Container(
      margin: EdgeInsets.only(top: 60, bottom: 20),
      child: CommonBtn(
        label: '确认报废',
        ontap: scrapBtn,
      ),
    );
  }

  // 扫描卡号电子车牌中的二维码,是个链接http://RFID.122.GOV.CN/RFID/900000000..
  void scanCardNo() async {
    LogUtils.e('点击了');
    _cardNoFocusNode.unfocus();
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
      _cardNoController.text = temp;
    });
  }

  // 报废按钮
  void scrapBtn() async {
    String _cardNo = _cardNoController.text;
    if (_cardNo.trim().length == 0) {
      ToastUtils.showToast('请输入卡号');
      return;
    }
    String reason = reasonTextController.text.trim();
    if (reason.length == 0) {
      ToastUtils.showToast('请填写原因');
      return;
    }
    if (licenseUrl == '') {
      ToastUtils.showToast('请上传附件图片');
      return;
    }
    scrapApi(reason, licenseUrl);
  }

  // 报废api
  scrapApi(String reason, String url) async {
    ResponseInfo responseInfo = await Fetch.post(url: HttpHelper.scrap, data: {
      "eviNo": _cardNoController.text.trim(),
      "reason": reasonTextController.text.trim(),
      "url": licenseUrl
    });
    if (responseInfo.success) {
      ToastUtils.showToast('报废成功');
      Navigator.of(context).pop();
    }
  }
}
