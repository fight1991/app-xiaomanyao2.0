import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_car_live/utils/confirm_utils.dart';
import 'package:flutter_car_live/widgets/common_btn/common_btn.dart';
import 'package:flutter_car_live/widgets/list_form_item/list_form_item.dart';

/// @Author: Tiancong
/// @Date: 2021-12-02 18:06:40
/// @Description: 订单详情页面

class OrderDetail extends StatefulWidget {
  final String? status;
  const OrderDetail({Key? key, this.status}) : super(key: key);
  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  Map _barTitle = {'done': '已完成', 'doing': '待付款', 'closed': '已关闭'};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('订单详情'),
      ),
      body: Container(
          child: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            child: Container(
              child: ListView(
                children: [
                  Offstage(
                    child: buildTopTitle(title: '待付款', trailing: '¥200'),
                    offstage: widget.status == 'doing',
                  ),
                  Offstage(
                    child: buildTopTitle(
                      title: '已关闭',
                      bgColor: Colors.black12,
                      trailing: '¥200',
                    ),
                    offstage: widget.status == 'closed',
                  ),
                  ListFormItem(title: '车牌号', trailing: '21212'),
                  ListFormItem(title: '交易金额', trailing: '21212'),
                  Offstage(
                    child: ListFormItem(title: '实付金额', trailing: '21212'),
                    offstage: widget.status == 'done',
                  ),
                  Offstage(
                    child: ListFormItem(title: '优惠金额', trailing: '21212'),
                    offstage: widget.status == 'done',
                  ),
                  ListFormItem(title: '枪号', trailing: '21212'),
                  ListFormItem(title: '油号', trailing: '21212'),
                  ListFormItem(title: '加油升数', trailing: '21212'),
                  ListFormItem(title: '订单号', trailing: '21212'),
                  ListFormItem(title: '创建时间', trailing: '21212'),
                  Offstage(
                    child: ListFormItem(title: '交易时间', trailing: '21212'),
                    offstage: widget.status == 'done',
                  ),
                  Offstage(
                    child: ListFormItem(title: '关闭时间', trailing: '21212'),
                    offstage: widget.status == 'closed',
                  ),
                  SizedBox(height: 30)
                ],
              ),
            ),
          ),
          Offstage(
            offstage: widget.status == 'doing',
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
          ontap: cancelOrderBtn),
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
    if (flag) {}
  }
}
