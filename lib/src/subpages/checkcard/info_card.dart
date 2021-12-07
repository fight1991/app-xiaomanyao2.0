import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_car_live/net/dio_utils.dart';
import 'package:flutter_car_live/net/fetch_methods.dart';
import 'package:flutter_car_live/net/response_data.dart';
import 'package:flutter_car_live/src/bean/bean_carInfo_by_cid.dart';
import 'package:flutter_car_live/utils/navigator_utils.dart';
import 'package:flutter_car_live/utils/toast_utils.dart';
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
  EviBean? eviBean;
  VehicleBean? vehicleBean;
  VehicleLicenseBean? vehicleLicenseBean;
  Map<String, dynamic>? tempInfo;
  @override
  void initState() {
    getCarInfoByCid();
    super.initState();
  }

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
                        buildLineInfo('卡号', eviBean?.eviNo.toString()),
                        Divider(),
                        buildPlateNoColor('车牌号', vehicleBean),
                        Divider(),
                        buildInstallImg(
                          eviBean?.insideImage,
                          eviBean?.outsideImage,
                        ),
                        SizedBox(height: 10)
                      ],
                    ),
                    SizedBox(height: 10),
                    buildAreaBox(
                      children: [
                        buildLineInfo('信息核对', '', color: Color(0xff0FB5F9)),
                        Divider(),
                        buildLineInfo('车辆类型', vehicleLicenseBean?.vehicleType),
                        Divider(),
                        buildLineInfo('所有人', vehicleLicenseBean?.ownerName),
                        Divider(),
                        buildLineInfo('品牌型号', vehicleLicenseBean?.model),
                        Divider(),
                        buildLineInfo('使用性质', vehicleLicenseBean?.useCharacter),
                        Divider(),
                        buildLineInfo('车辆识别代号', vehicleLicenseBean?.vin),
                        Divider(),
                        buildLineInfo('发动机号', vehicleLicenseBean?.engineNum),
                        Divider(),
                        buildLicenseImg(vehicleLicenseBean?.licenseCopyImage,
                            vehicleLicenseBean?.licenseImage),
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

  // 车牌颜色组件
  Widget buildPlateNoColor(String title, VehicleBean? vehicleBean) {
    Widget widget;
    String type = vehicleBean?.plateColor ?? '';
    Color? _color;
    switch (type) {
      case 'blue':
        _color = Colors.blue;
        break;
      case 'green':
        _color = Colors.green;
        break;
      case 'yellow':
        _color = Colors.yellow;
        break;
      default:
        _color = null;
        break;
    }
    widget = Container(
      decoration: _color == null
          ? BoxDecoration(
              gradient: LinearGradient(colors: [Colors.yellow, Colors.green]),
              borderRadius: BorderRadius.circular(3))
          : BoxDecoration(
              color: _color,
              borderRadius: BorderRadius.circular(3),
            ),
      child: Text(
        vehicleBean?.plateNo ?? '',
        style: TextStyle(color: Colors.white),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8),
    );

    return Container(
      child: ListTile(
        title: Text(title),
        trailing: type == '' ? null : widget,
        contentPadding: EdgeInsets.zero,
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
        trailing: Text(
          trailing ?? '',
          overflow: TextOverflow.ellipsis,
        ),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  // 安装图片区域
  Widget buildInstallImg(String? src1, String? src2) {
    if (src1 == null || src2 == null) {
      return Container();
    }
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
  Widget buildLicenseImg(String? src1, String? src2) {
    if (src1 == null || src2 == null) {
      return Container();
    }
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
    if (list.length == 0) return;
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

  // 获取绑定的车辆信息
  getCarInfoByCid() async {
    ResponseInfo responseInfo =
        await Fetch.post(url: HttpHelper.getElecInfo, data: widget.cid);
    if (responseInfo.success) {
      var data = responseInfo.data;
      if (data != null) {
        tempInfo = data;
        eviBean = EviBean.fromJson(data["evi"]);
        vehicleBean = VehicleBean.fromJson(data["vehicle"]);
        vehicleLicenseBean =
            VehicleLicenseBean.fromJson(data["vehicleLicense"]);
        setState(() {});
      }
    } else {
      Navigator.of(context).pop();
    }
  }

  // 提交按钮
  submitBtn() async {
    if (tempInfo == null) return;
    Map temp = {
      ...tempInfo?["evi"],
      ...tempInfo?["vehicle"],
      ...tempInfo?["vehicleLicense"]
    };
    ResponseInfo responseInfo =
        await Fetch.post(url: HttpHelper.verifyElecInfo, data: temp);
    if (responseInfo.success) {
      ToastUtils.showToast('核验成功');
    }
  }
}
