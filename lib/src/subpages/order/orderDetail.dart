import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            ListFormItem(title: '车牌号', trailing: '21212'),
            ListFormItem(title: '交易金额', trailing: '21212'),
            ListFormItem(title: '实付金额', trailing: '21212'),
            ListFormItem(title: '优惠金额', trailing: '21212'),
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
            )
          ],
        ),
      ),
    );
  }
}
