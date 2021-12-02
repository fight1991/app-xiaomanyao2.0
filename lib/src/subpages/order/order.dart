import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// @Author: Tiancong
/// @Date: 2021-12-02 15:56:14
/// @Description: 订单管理页面

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('订单管理'),
        elevation: 0,
      ),
    );
  }
}
