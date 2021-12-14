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
import 'package:flutter_car_live/widgets/upload_file/upload_file_img.dart';

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
  GlobalKey _formKey = GlobalKey<FormState>();
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
                SizedBox(height: 10)
              ],
            ),
            buildFormContainer(),
            buildAreaBox(
              children: [
                buildLicenseImg(vehicleLicenseBean?.licenseCopyImage,
                    vehicleLicenseBean?.licenseImage),
                SizedBox(height: 10)
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: CommonBtn(
                label: '提交',
                ontap: submitBtn,
              ),
            )
          ],
        ),
      ),
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

  // 表单输入框
  Widget buildTextFieldLine(
      {String? label,
      required String prop,
      String? errText,
      String? initValue}) {
    return Row(
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label ?? '',
          ),
        ),
        Expanded(
          child: TextFormField(
            style: TextStyle(color: Color(0xff808080)),
            textAlign: TextAlign.end,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Colors.yellow.withOpacity(.1),
                filled: true),
            initialValue: tempInfo?["vehicleLicense"][prop],
            onSaved: (v) {
              tempInfo?['vehicleLicense'][prop] = v;
            },
          ),
        )
      ],
    );
  }

  // 表单容器
  Widget buildFormContainer() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
      decoration: BoxDecoration(color: Colors.white),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          key: UniqueKey(), // 否则表单不刷新
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTextFieldLine(label: '车辆类型', prop: 'vehicleType'),
            Divider(),
            buildTextFieldLine(label: '所有人', prop: 'ownerName'),
            Divider(),
            buildTextFieldLine(label: '品牌型号', prop: 'model'),
            Divider(),
            buildTextFieldLine(label: '使用性质', prop: 'useCharacter'),
            Divider(),
            buildTextFieldLine(label: '车辆识别代号', prop: 'vin'),
            Divider(),
            buildTextFieldLine(label: '发动机号', prop: 'engineNum'),
            Divider(),
          ],
        ),
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

  // 显示行
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
              UploadFileImg(
                initialNetUrl: eviBean?.insideImage ?? '',
                displayOnly: true,
              ),
              SizedBox(width: 10),
              UploadFileImg(
                initialNetUrl: eviBean?.outsideImage ?? '',
                displayOnly: true,
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
          child: UploadFileImg(
            initialNetUrl: vehicleLicenseBean?.licenseImage ?? '',
            width: double.infinity,
            height: 150,
            getUrl: (String url) {
              print('vehicleLicense>>>>>>>>>>>>');
              print(url);
              tempInfo?["vehicleLicense"]["licenseImage"] = url;
              print(tempInfo?["vehicleLicense"]["licenseImage"]);
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: UploadFileImg(
            initialNetUrl: vehicleLicenseBean?.licenseImage ?? '',
            width: double.infinity,
            height: 150,
            getUrl: (String url) {
              print('licenseCopyImage>>>>>>>>>>>>');
              print(url);
              tempInfo?["vehicleLicense"]["licenseCopyImage"] = url;
              print(tempInfo?["vehicleLicense"]["licenseCopyImage"]);
            },
          ),
        ),
      ],
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
        if (mounted) {
          setState(() {});
        }
      }
    } else {
      Navigator.of(context).pop();
    }
  }

  // 校验字段
  bool textFielValid() {
    var isPass = true;
    var mapValue = tempInfo?["vehicleLicense"];
    var map = {
      "vehicleType": "车辆类型",
      "ownerName": "所有人",
      "model": "品牌型号",
      "useCharacter": "使用性质",
      "vin": "车辆识别代号",
      "engineNum": "发动机号"
    };
    for (var item in map.keys) {
      if (mapValue[item].trim().length == 0) {
        isPass = false;
        ToastUtils.showToast('请填写${map[item]}');
        break;
      }
    }
    return isPass;
  }

  // 提交按钮
  submitBtn() async {
    if (tempInfo == null) return;
    // 保存表单内容,表单校验
    (_formKey.currentState as FormState).save();
    if (!textFielValid()) return;
    Map temp = {
      ...tempInfo?["evi"],
      ...tempInfo?["vehicle"],
      ...tempInfo?["vehicleLicense"]
    };
    print('temp>>>>>>>>>>>>>>>>>>');
    print(tempInfo?["vehicleLicense"]);
    print(temp["licenseImage"]);
    ResponseInfo responseInfo =
        await Fetch.post(url: HttpHelper.verifyElecInfo, data: temp);
    if (responseInfo.success) {
      ToastUtils.showToast('核验成功');
      Navigator.of(context).pop();
    }
  }
}
