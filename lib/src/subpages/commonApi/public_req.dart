import 'package:flutter/cupertino.dart';
import 'package:flutter_car_live/channel/app_method_channel.dart';
import 'package:flutter_car_live/net/fetch_methods.dart';
import 'package:flutter_car_live/net/http_helper.dart';
import 'package:flutter_car_live/net/response_data.dart';
import 'package:flutter_car_live/providers/location_model.dart';
import 'package:flutter_car_live/src/bean/bean_location.dart';
import 'package:flutter_car_live/src/bean/bean_trade.dart';
import 'package:flutter_car_live/src/subpages/paystatus/pay_doing.dart';
import 'package:flutter_car_live/src/subpages/paystatus/pay_status.dart';
import 'package:flutter_car_live/utils/navigator_utils.dart';
import 'package:provider/provider.dart';

class PublicReq {
  static void getStatus(BuildContext context,
      {required String orderNo, bool withLoading = true}) async {
    ResponseInfo responseInfo = await Fetch.post(
        url: HttpHelper.getTrade, data: orderNo, withLoading: withLoading);
    if (responseInfo.success) {
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
            status: 'success',
            orderNo: orderNo,
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
              orderNo: orderNo,
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
            orderNo: orderNo,
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
          orderNo: orderNo,
          reason: tradeBean.closeReason,
        ),
      );
      return;
    }
    NavigatorUtils.pushPageByFade(
      context: context,
      isReplace: true,
      targPage: PayStatus(
        status: 'fail',
        orderNo: orderNo,
        reason: responseInfo.message,
      ),
    );
    return;
  }

  // 支付api
  static void goPay(
    BuildContext context, {
    required dynamic price,
    required String cid,
    required dynamic goodsId,
    required dynamic oilGunId,
    required String orgServiceType,
  }) async {
    // 获取设备号
    String deviceNo = await AppMethodChannel.getBNDeviceCode();
    // 获取经纬度信息
    LocationBean location =
        Provider.of<LocationModel>(context, listen: false).locationInfo;
    ResponseInfo responseInfo = await Fetch.post(
      url: HttpHelper.addTrade,
      data: {
        "amount": price,
        "cid": cid,
        "deviceNo": deviceNo,
        "goodsId": goodsId,
        "latitude": location.latitude,
        "longitude": location.longitude,
        "oilGunId": oilGunId,
        "orgServiceType": orgServiceType
      },
    );
    if (responseInfo.success) {
      // 返回订单号
      // 跳转到交易等待页面
      // 5s中之后查询订单详情
      // 拿到结果再跳转到相应的页面
      NavigatorUtils.pushPage(
        context: context,
        targPage: PayDoing(orderNo: responseInfo.data),
        isReplace: true,
      );
    }
  }
}
