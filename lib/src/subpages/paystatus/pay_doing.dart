import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_car_live/net/dio_utils.dart';
import 'package:flutter_car_live/net/fetch_methods.dart';
import 'package:flutter_car_live/net/response_data.dart';
import 'package:flutter_car_live/src/bean/bean_trade.dart';
import 'package:flutter_car_live/src/subpages/paystatus/pay_status.dart';
import 'package:flutter_car_live/utils/navigator_utils.dart';

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
  AnimationController? controller;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('交易处理中'),
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
    ResponseInfo responseInfo =
        await Fetch.post(url: HttpHelper.getTrade, data: widget.orderNo);
    if (responseInfo.data) {
      TradeBean tradeBean = TradeBean.fromJson(responseInfo.data);
      // doing 进行中
      //  payErrorCode:
      //    D0102001 等待付款，用户未开通免密支付
      //    D0102002 等待付款，金额超出免密额度，需要用户手动付款
      //    D0102003 等待付款，用户还没有绑定银行卡
      //    D0103001 // 扣款失败，支付渠道返回错误原因，取值payRemark【新加】
      // done 扣款成功
      // closed 已关闭
      if (tradeBean.status == 'done') {
        NavigatorUtils.pushPageByFade(
          context: context,
          isReplace: true,
          targPage: PayStatus(
            status: 'successs',
            orderNo: widget.orderNo,
          ),
        );
        return;
      }
      if (tradeBean.status == 'doing') {
        Map<String, String> waitPayReason = {
          "D0102001": "用户未开通免密支付",
          "D0102002": "金额超出免密额度，需要用户手动付款",
          "D0102003": "用户还没有绑定银行卡",
          "D0103001": "", // +payRemark
        };
        String? code = tradeBean.payErrorCode;
        String? reason = waitPayReason[code];
        if (code == 'D0103001') {
          reason = tradeBean.payRemark;
          NavigatorUtils.pushPageByFade(
            context: context,
            isReplace: true,
            targPage: PayStatus(
              status: 'fail',
              orderNo: widget.orderNo,
              reason: reason,
            ),
          );
          return;
        }
        NavigatorUtils.pushPageByFade(
          context: context,
          isReplace: true,
          targPage: PayStatus(
            status: 'wait',
            orderNo: widget.orderNo,
            reason: reason,
          ),
        );
        return;
      }
      // 失败
      NavigatorUtils.pushPageByFade(
        context: context,
        isReplace: true,
        targPage: PayStatus(
          status: 'fail',
          orderNo: widget.orderNo,
          reason: tradeBean.closeReason,
        ),
      );
      return;
    }
  }
}
