import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_car_live/utils/bottomsheet_utils.dart';
import 'package:flutter_car_live/utils/log_utils.dart';
import 'package:flutter_car_live/utils/navigator_utils.dart';
import 'package:flutter_car_live/utils/toast_utils.dart';
import 'package:flutter_car_live/widgets/common_btn/common_btn.dart';
import 'package:flutter_car_live/widgets/iconfont/iconfont.dart';
import 'package:flutter_car_live/widgets/photo_view/photo_view.dart';
import 'package:image_picker/image_picker.dart';
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
  TextEditingController reasonTextController = TextEditingController();
  String licenseUrl = '';
  File? file; // 预览地址
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('卡片报废'),
        elevation: 0,
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
          Row(
            children: [
              buildPreviewImg(file),
              // 上传组件
              GestureDetector(
                onTap: showPickerBtn,
                child: Image.asset(
                  'assets/images/card/add.png',
                  width: 100,
                  height: 100,
                ),
              ),
            ],
          ),
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

  // 上传的文件预览
  Widget buildPreviewImg(File? file) {
    return file == null
        ? Container()
        : Container(
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(color: Colors.black12),
            child: GestureDetector(
              onTap: previewImg,
              onLongPress: longPressdeleteImg,
              child: Image.file(
                file,
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
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

  // 报废按钮
  void scrapBtn() async {
    if (_cardNo.trim().length == 0) {
      ToastUtils.showToast('请扫描卡号');
      return;
    }
    if (reasonTextController.text.trim().length == 0) {
      ToastUtils.showToast('请填写原因');
      return;
    }
    if (file == null) {
      ToastUtils.showToast('请上传附件图片');
      return;
    }
  }

  // 底部弹出拍照/从相册中选择
  void showPickerBtn() {
    List<String> listOp = ['拍照', '从相册中选择'];
    BottomSheetUtils.show(
        context: context, list: listOp, action: chooseImgFrom);
  }

  // 预览图片
  void previewImg() {
    NavigatorUtils.pushPageByFade(
      context: context,
      targPage: PhotoViewSimpleScreen(
        imageProvider: FileImage(file!),
        heroTag: 'simple',
      ),
    );
  }

  // 长按删除
  void longPressdeleteImg() {
    List<String> list = ['删除'];
    BottomSheetUtils.show(
      context: context,
      list: list,
      action: (int index) {
        setState(() {
          file = null;
        });
      },
    );
  }

  // 选择照片
  void chooseImgFrom(int index) async {
    ImagePicker _picker = ImagePicker();
    XFile? imageInfo;
    // 打开摄像头
    if (index == 0) {
      LogUtils.e('打开摄像头');
      imageInfo = await _picker.pickImage(source: ImageSource.camera);
    }
    // 从本地取
    if (index == 1) {
      LogUtils.e('打开相册');
      imageInfo = await _picker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      file = File(imageInfo?.path ?? '');
    });
    return;
  }
}
