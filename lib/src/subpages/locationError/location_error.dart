import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_car_live/widgets/common_btn/common_btn.dart';

/// @Author: Tiancong
/// @Date: 2022-01-14 09:56:29
/// @Description: 定位异常页面

class LocationError extends StatefulWidget {
  final errorCode;
  final solution;
  const LocationError({Key? key, int? this.errorCode, String? this.solution})
      : super(key: key);
  @override
  _LocationErrorState createState() => _LocationErrorState();
}

class _LocationErrorState extends State<LocationError> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('位置信息异常'),
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text('错误代码'),
                ),
                Expanded(child: Text('${widget.errorCode}:'))
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text('错误原因'),
                ),
                Expanded(child: Text(widget.solution ?? ''))
              ],
            ),
            CommonBtn(
              label: '返回',
              ontap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/index', (route) => false);
              },
            )
          ],
        ),
      ),
    );
  }
}
