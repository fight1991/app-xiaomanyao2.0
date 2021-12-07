import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_car_live/net/dio_utils.dart';
import 'package:flutter_car_live/net/fetch_methods.dart';
import 'package:flutter_car_live/net/response_data.dart';
import 'package:flutter_car_live/src/bean/bean_carInfo_by_cid.dart';
import 'package:flutter_car_live/utils/toast_utils.dart';
import 'package:flutter_car_live/widgets/common_btn/common_btn.dart';

/// @Author: Tiancong
/// @Date: 2021-12-02 10:19:52
/// @Description: 无

class UnbindCard extends StatefulWidget {
  final cid;
  UnbindCard({Key? key, String? this.cid}) : super(key: key);
  @override
  _UnbindCardState createState() => _UnbindCardState();
}

class _UnbindCardState extends State<UnbindCard> {
  String plateNo = '';
  @override
  void initState() {
    getBindCarInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('解绑确认'),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            '卡号',
                            style: TextStyle(
                              color: Color(0xff0FB5F9),
                            ),
                          ),
                          trailing: Text(widget.cid),
                        ),
                        Divider(height: 1),
                        ListTile(
                          title: Text(
                            '车牌号',
                            style: TextStyle(
                              color: Color(0xff0FB5F9),
                            ),
                          ),
                          trailing: Text(plateNo),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            CommonBtn(
              label: '确认解绑',
              ontap: confirmBtn,
            )
          ],
        ),
      ),
    );
  }

  // 获取绑定的车辆信息
  getBindCarInfo() async {
    ResponseInfo responseInfo =
        await Fetch.post(url: HttpHelper.getPlateNoByElec, data: widget.cid);
    if (responseInfo.success) {
      VehicleBean vehicleBean = VehicleBean.fromJson(responseInfo.data);
      setState(() {
        plateNo = vehicleBean.plateNo ?? '';
      });
    }
  }

  // 确认解绑按钮
  confirmBtn() async {
    ResponseInfo responseInfo =
        await Fetch.post(url: HttpHelper.getPlateNoByElec, data: widget.cid);
    if (responseInfo.success) {
      ToastUtils.showToast('解绑成功');
      Navigator.of(context).pop();
    }
  }
}
