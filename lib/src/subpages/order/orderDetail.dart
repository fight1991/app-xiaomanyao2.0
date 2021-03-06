import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_car_live/net/fetch_methods.dart';
import 'package:flutter_car_live/net/http_helper.dart';
import 'package:flutter_car_live/net/response_data.dart';
import 'package:flutter_car_live/src/bean/bean_trade.dart';
import 'package:flutter_car_live/utils/confirm_utils.dart';
import 'package:flutter_car_live/utils/toast_utils.dart';
import 'package:flutter_car_live/widgets/common_btn/common_btn.dart';
import 'package:flutter_car_live/widgets/list_form_item/list_form_item.dart';

/// @Author: Tiancong
/// @Date: 2021-12-02 18:06:40
/// @Description: 订单详情页面

class OrderDetail extends StatefulWidget {
  final orderNo;
  const OrderDetail({Key? key, String? this.orderNo}) : super(key: key);
  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  Map _barTitle = {'done': '已完成', 'doing': '待付款', 'closed': '已关闭'};
  Map<String, String> serviceType = {
    'carWash': '洗车',
    'refueling': '加油',
    'upkeep': '保养',
    'repair': '维修',
    'custom': '自定义'
  };
  String? status;
  TradeBean? _tradeBean;
  ExtendObject? _extendObject;
  @override
  void initState() {
    getOrderDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color colorsTextStatus = status == 'done' ? Colors.white : Colors.black;
    Color colorsBgStatus =
        status == 'done' ? Theme.of(context).accentColor : Colors.white;
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: colorsTextStatus, //修改返回按钮颜色
          ),
          title: Text(
            '订单详情',
            style: TextStyle(color: colorsTextStatus),
          ),
          elevation: 0,
          backgroundColor: colorsBgStatus),
      body: Container(
          child: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            child: Container(
              child: ListView(
                children: [
                  Offstage(
                    child: buildTopTitle(
                      title: '待付款',
                      trailing: '¥${_tradeBean?.totalAmount}',
                    ),
                    offstage: status != 'doing',
                  ),
                  Offstage(
                    child: buildTopTitle(
                      title: '已关闭',
                      bgColor: Colors.black12,
                      trailing: '¥${_tradeBean?.totalAmount}',
                    ),
                    offstage: status != 'closed',
                  ),
                  ListFormItem(title: '车牌号', trailing: _tradeBean?.plateNo),
                  ListFormItem(
                    title: '交易金额',
                    trailing: '¥${_tradeBean?.totalAmount}',
                  ),
                  // 加油时隐藏此项
                  Offstage(
                    child: ListFormItem(
                      title: '项目',
                      trailing: serviceType[_tradeBean?.merchantService],
                    ),
                    offstage: _tradeBean?.merchantService == 'refueling',
                  ),
                  // 加油时隐藏此项
                  Offstage(
                    child: ListFormItem(
                      title: '商品名称',
                      trailing: _tradeBean?.goodsSummary,
                    ),
                    offstage: _tradeBean?.merchantService == 'refueling',
                  ),
                  Offstage(
                    child: ListFormItem(
                      title: '实付金额',
                      trailing: '¥${_tradeBean?.payAmount}',
                    ),
                    offstage: status != 'done',
                  ),
                  Offstage(
                    child: ListFormItem(
                      title: '优惠金额',
                      trailing: '¥${_tradeBean?.couponAmount}',
                    ),
                    offstage: status != 'done',
                  ),
                  Offstage(
                    child: ListFormItem(
                      title: '枪号',
                      trailing: _extendObject?.oilGunName.toString(),
                    ),
                    offstage: _tradeBean?.merchantService != 'refueling',
                  ),
                  Offstage(
                    child: ListFormItem(
                      title: '油号',
                      trailing: _extendObject?.oilType,
                    ),
                    offstage: _tradeBean?.merchantService != 'refueling',
                  ),
                  Offstage(
                    child: ListFormItem(
                      title: '加油升数',
                      trailing: '${(_extendObject?.liters ?? 0) * 0.001}L',
                    ),
                    offstage: _tradeBean?.merchantService != 'refueling',
                  ),
                  ListFormItem(
                    title: '订单号',
                    trailing: _tradeBean?.tradeOrderNo,
                  ),
                  ListFormItem(
                    title: '创建时间',
                    trailing: _tradeBean?.createdTime,
                  ),
                  Offstage(
                    child: ListFormItem(
                      title: '交易时间',
                      trailing: _tradeBean?.payDate,
                    ),
                    offstage: status != 'done',
                  ),
                  Offstage(
                    child: ListFormItem(
                      title: '关闭时间',
                      trailing: _tradeBean?.closeDate,
                    ),
                    offstage: status != 'closed',
                  ),
                  SizedBox(height: 30)
                ],
              ),
            ),
          ),
          Offstage(
            offstage: status != 'doing',
            child: buildCancelBtn(),
          )
        ],
      )),
    );
  }

  // 顶部订单状态title
  Widget buildTopTitle(
      {String? title,
      String? trailing,
      Color color = Colors.white,
      Color? bgColor = const Color(0xffFF7E24)}) {
    return Container(
      decoration: BoxDecoration(color: bgColor),
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(
          title ?? '',
          style: TextStyle(color: color),
        ),
        trailing: Text(
          trailing ?? '',
          style: TextStyle(color: color, fontSize: 16),
        ),
      ),
    );
  }

  // 取消订单按钮
  Widget buildCancelBtn() {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8,
          offset: Offset(0, -2),
          spreadRadius: 1.0,
        )
      ]),
      child: CommonBtn(
        bg: Color(0xffFF7E24),
        label: '取消订单',
        radius: false,
        ontap: cancelOrderBtn,
      ),
    );
  }

  // 点击取消订单按钮
  void cancelOrderBtn() async {
    bool flag = await ConfirmDialogUtils.show(
      context: context,
      title: '取消订单',
      content: '是否确认执行此操作',
      cancelColor: Color(0xff2B9DF0),
      confirmColor: Colors.red,
    );
    if (flag) {
      cacelOrder();
    }
  }

  // 取消订单
  // 有2个入口跳转过来
  // 支付状态页面--> 查看订单-->订单详情
  // 订单列表--> 订单详情
  // 如果是从订单列表跳转过来,取消订单成功后刷新列表
  // 方案: 在2列表监听路由返回并刷新
  cacelOrder() async {
    ResponseInfo responseInfo = await Fetch.post(
      url: HttpHelper.closeTrade,
      data: widget.orderNo,
    );
    if (responseInfo.success) {
      ToastUtils.showToast('取消成功');
      Future.delayed(Duration(seconds: 1), () {
        // 返回列表页并刷新
        Navigator.of(context).pop(true);
      });
    }
  }

  // 获取订单详情
  void getOrderDetail() async {
    ResponseInfo responseInfo = await Fetch.post(
      url: HttpHelper.getTrade,
      data: widget.orderNo,
    );
    if (responseInfo.success) {
      TradeBean tradeBean = TradeBean.fromJson(responseInfo.data);
      var extend = responseInfo.data["extendObject"];
      ExtendObject? extendObject;
      if (extend != null) {
        extendObject = ExtendObject.fromJson(responseInfo.data["extendObject"]);
      }
      if (mounted) {
        setState(() {
          _tradeBean = tradeBean;
          _extendObject = extendObject;
          status = tradeBean.status;
        });
      }
    }
  }
}
