import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_car_live/src/subpages/paystatus/common/public_req.dart';

/// @Author: Tiancong
/// @Date: 2021-12-10 17:41:05
/// @Description: 交易处理中页面

class PayDoing extends StatefulWidget {
  final orderNo;
  const PayDoing({Key? key, String? this.orderNo}) : super(key: key);
  @override
  _PayDoingState createState() => _PayDoingState();
}

class _PayDoingState extends State<PayDoing>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // 5秒后查询订单状态
    Future.delayed(Duration(seconds: 5), () {
      getStatus();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('交易处理中'),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/owner/wait.png',
              width: 100,
              height: 100,
            ),
            Text('交易处理中')
          ],
        ),
      ),
    );
  }

  void getStatus() async {
    PublicReq.getStatus(context, orderNo: widget.orderNo, withLoading: false);
  }
}
