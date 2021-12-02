import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_car_live/src/bean/bean_order.dart';
import 'package:flutter_car_live/src/subpages/order/orderDetail.dart';
import 'package:flutter_car_live/utils/navigator_utils.dart';
import 'package:flutter_car_live/widgets/refresh_config/refresh_footer.dart';
import 'package:flutter_car_live/widgets/refresh_config/refresh_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

/// @Author: Tiancong
/// @Date: 2021-12-02 16:40:46
/// @Description: Tab内容

class TabContent extends StatefulWidget {
  final type;
  const TabContent({Key? key, String? this.type}) : super(key: key);
  @override
  _TabContentState createState() => _TabContentState();
}

class _TabContentState extends State<TabContent> {
  EasyRefreshController easyRefreshController = new EasyRefreshController();
  List _dataList = [1, 2, 3, 4, 5, 6, 7];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: EasyRefresh.custom(
        controller: easyRefreshController, //上面创建的刷新控制器
        header: RefreshHeader(), //自定义刷新头
        footer: RefreshFooter(), //自定义加载尾
        onRefresh: () async {
          // 设置两秒后关闭刷新，时间可以随便设置，根据项目需求，正常在请求成功后，也要关闭
          await Future.delayed(const Duration(seconds: 2), () {
            setState(() {
              // 控制器关闭刷新功能
              easyRefreshController.finishRefresh(success: true);
            });
          });
        },
        onLoad: () async {
          // 设置两秒后关闭加载，时间可以随便设置，根据项目需求，正常在请求成功后，也要关闭
          await Future.delayed(const Duration(seconds: 2), () {
            setState(() {
              // 控制器关闭加载功能，还可以设置没有更多数据noMore，可以根据需求自己变更，这里同样也需要在数据请求成功进行关闭。
              easyRefreshController.finishLoad(success: true);
            });
          });
        },
        slivers: <Widget>[
          // 这里设置列表
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                OrderBean order = OrderBean.fromMap({"demo": '123'});
                // 这里为iOS UITableViewCell （android的adapter）,样式大家自定义即可
                return buildListItem(order);
              },
              // 设置返回数据个数
              childCount: _dataList.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListItem(OrderBean item) {
    return GestureDetector(
      onTap: () {
        NavigatorUtils.pushPageByFade(
          context: context,
          targPage: OrderDetail(),
        );
      },
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(1, 1),
            spreadRadius: 1.0,
          )
        ]),
        child: Column(
          children: [
            ListTile(
              dense: true,
              title: Text(
                '订单号${item.orderNo}',
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
              trailing: Text('${item.status}'),
            ),
            Divider(),
            ListTile(
              dense: true,
              title: Text(
                '${item.plateNo}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              trailing: Text('${item.price}'),
            ),
            ListTile(
              dense: true,
              title: Text(
                '创建时间:${item.orderNo}',
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
              trailing: Text('${item.price}'),
            ),
          ],
        ),
      ),
    );
  }
}
