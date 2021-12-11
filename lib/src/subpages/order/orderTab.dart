import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_car_live/src/subpages/order/tabContent.dart';

/// @Author: Tiancong
/// @Date: 2021-12-02 15:56:14
/// @Description: 订单管理页面

class OrderTab extends StatefulWidget {
  const OrderTab({Key? key}) : super(key: key);
  @override
  _OrderTabState createState() => _OrderTabState();
}

class _OrderTabState extends State<OrderTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List _tabs = [
    {'label': '待支付', 'value': 'doing'},
    {'label': '全部', 'value': ''}
  ];
  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('订单管理'),
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff0BBAFB), Color(0xff4285EC)],
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: buildTabBarStyle(),
        ),
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children:
            _tabs.map((item) => TabContent(status: item['value'])).toList(),
        controller: _tabController,
      ),
    );
  }

  // 设置appbar下面的TabBar
  Widget buildTabBarStyle() {
    return Material(
      color: Colors.white,
      child: TabBar(
        // indicator: ColorTabIndicator(Colors.black),//选中标签颜色
        indicatorSize: TabBarIndicatorSize.label, // 与字体同宽
        indicatorColor: Color(0xff4285EC), //选中下划线颜色,如果使用了indicator这里设置无效
        controller: _tabController,
        indicatorWeight: 3,
        labelColor: Color(0xff4285EC),
        unselectedLabelColor: Colors.black87,
        tabs: _tabs.map((item) => Tab(text: item['label'])).toList(),
      ),
    );
  }
}
