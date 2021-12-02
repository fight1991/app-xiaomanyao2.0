import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_car_live/utils/navigator_utils.dart';
import 'package:flutter_car_live/widgets/common_btn/common_btn.dart';
import 'package:flutter_car_live/widgets/photo_view/photo_view.dart';

/// @Author: Tiancong
/// @Date: 2021-12-01 18:20:48
/// @Description: 无

class CheckInfo extends StatefulWidget {
  final cid;
  CheckInfo({Key? key, String? this.cid}) : super(key: key);
  @override
  _CheckInfoState createState() => _CheckInfoState();
}

class _CheckInfoState extends State<CheckInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('核验信息'),
        elevation: 0,
      ),
      backgroundColor: Color(0xfff7f7f7),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(15),
          child: Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    buildAreaBox(
                      children: [
                        buildLineInfo('卡号', '121221'),
                        Divider(),
                        buildLineInfo('车牌号', '121221'),
                        Divider(),
                        buildInstallImg(
                          'https://cdn.wwads.cn/creatives/jA87ghlAnCDo3K6k5oTfACNlt038G3mNVfjklifg.jpg',
                          'https://cdn.wwads.cn/creatives/jA87ghlAnCDo3K6k5oTfACNlt038G3mNVfjklifg.jpg',
                        ),
                        SizedBox(height: 10)
                      ],
                    ),
                    SizedBox(height: 10),
                    buildAreaBox(
                      children: [
                        buildLineInfo('信息核对', '', color: Color(0xff0FB5F9)),
                        Divider(),
                        buildLineInfo('车辆类型', '121221'),
                        Divider(),
                        buildLineInfo('所有人', '121221'),
                        Divider(),
                        buildLineInfo('品牌型号', '121221'),
                        Divider(),
                        buildLineInfo('使用性质', '121221'),
                        Divider(),
                        buildLineInfo('车辆识别代号', '121221'),
                        Divider(),
                        buildLineInfo('发动机号', '121221'),
                        Divider(),
                        buildLicenseImg(
                          'https://cdn.wwads.cn/creatives/jA87ghlAnCDo3K6k5oTfACNlt038G3mNVfjklifg.jpg',
                          'https://cdn.wwads.cn/creatives/jA87ghlAnCDo3K6k5oTfACNlt038G3mNVfjklifg.jpg',
                        ),
                        SizedBox(height: 10)
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: CommonBtn(
                  label: '提交',
                  ontap: submitBtn,
                ),
              )
            ],
          )),
    );
  }

  // 容器
  Widget buildAreaBox({List<Widget> children = const <Widget>[]}) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: children,
      ),
    );
  }

  Widget buildLineInfo(String title, String? trailing, {Color? color}) {
    return Container(
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(color: color),
        ),
        trailing: Text(trailing ?? ''),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  // 安装图片区域
  Widget buildInstallImg(String src1, String src2) {
    return Column(
      children: [
        buildLineInfo('安装照片', ''),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  previewImg(list: [src1, src2], initIndex: 0);
                },
                child: Image.network(
                  src1,
                  width: 100,
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  previewImg(list: [src1, src2], initIndex: 1);
                },
                child: Image.network(
                  src2,
                  width: 100,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  // 行驶证图片区域
  Widget buildLicenseImg(String src1, String src2) {
    return Column(
      children: [
        buildLineInfo('行驶证', ''),
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: GestureDetector(
            onTap: () {
              previewImg(list: [src1, src2], initIndex: 0);
            },
            child: Container(
              color: Colors.black12,
              child: Image.network(
                src1,
                width: double.infinity,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: GestureDetector(
            onTap: () {
              previewImg(list: [src1, src2], initIndex: 1);
            },
            child: Container(
              color: Colors.black12,
              child: Image.network(
                src1,
                width: double.infinity,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 图片预览
  previewImg({List<String> list = const <String>[], int initIndex = 0}) {
    List<GalleryViewItem> galleryItems = list
        .map(
          (v) => GalleryViewItem(id: v, resource: v, resoureType: 'network'),
        )
        .toList();
    NavigatorUtils.pushPageByFade(
      context: context,
      targPage: PhotoView(
        galleryItems: galleryItems,
        initialIndex: initIndex,
      ),
    );
  }

  // 提交按钮
  submitBtn() {}
}
