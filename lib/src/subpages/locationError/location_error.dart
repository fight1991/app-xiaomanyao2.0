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
          backgroundColor: Colors.redAccent,
          title: Text('位置信息异常'),
          elevation: 0.0,
        ),
        body: WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 40),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        '错误代码',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                    Expanded(child: Text('${widget.errorCode}'))
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        '错误原因',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                    Expanded(child: Text(widget.solution ?? ''))
                  ],
                ),
                SizedBox(height: 120),
                CommonBtn(
                  label: '返回',
                  bg: Colors.redAccent.withOpacity(.5),
                  ontap: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/index',
                      (route) => false,
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}
