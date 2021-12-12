import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_car_live/net/fetch_methods.dart';
import 'package:flutter_car_live/net/http_helper.dart';
import 'package:flutter_car_live/net/response_data.dart';
import 'package:flutter_car_live/src/bean/bean_order.dart';
import 'package:flutter_car_live/src/bean/bean_page.dart';
import 'package:flutter_car_live/src/subpages/order/orderDetail.dart';
import 'package:flutter_car_live/utils/navigator_utils.dart';
import 'package:flutter_car_live/widgets/empty/empty.dart';
import 'package:flutter_car_live/widgets/refresh_config/refresh_footer.dart';
import 'package:flutter_car_live/widgets/refresh_config/refresh_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

/// @Author: Tiancong
/// @Date: 2021-12-02 16:40:46
/// @Description: Tab内容

class TabContent extends StatefulWidget {
  final status;
  const TabContent({Key? key, String? this.status}) : super(key: key);
  @override
  _TabContentState createState() => _TabContentState();
}

class _TabContentState extends State<TabContent> {
  EasyRefreshController easyRefreshController = new EasyRefreshController();
  Map labelMap = {"doing": "待支付", "done": "已完成", "closed": "已关闭"};
  @override
  void initState() {
    // 需要延时,否则不执行
    Future.delayed(Duration.zero, () {
      // 触发刷新
      easyRefreshController.callRefresh();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: EasyRefresh.custom(
        controller: easyRefreshController, //上面创建的刷新控制器
        header: RefreshHeader(), //自定义刷新头
        footer: RefreshFooter(), //自定义加载尾
        emptyWidget: total == 0 ? Empty() : null,
        onRefresh: () async {
          await getOrderList('refresh');
        },
        onLoad: () async {
          await getOrderList('upper');
        },
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                var map = dataList[index];
                OrderBean order = OrderBean.fromMap(map);
                // 这里为iOS UITableViewCell （android的adapter）,样式大家自定义即可
                return buildListItem(order);
              },
              // 设置返回数据个数
              childCount: dataList.length,
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
          targPage: OrderDetail(orderNo: item.tradeOrderNo),
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
                '订单号${item.tradeOrderNo}',
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
              trailing: Text(
                '${labelMap[item.status]}',
                style: TextStyle(
                  color:
                      item.status == 'doing' ? Color(0xffFF7F24) : Colors.black,
                ),
              ),
            ),
            Divider(),
            ListTile(
              dense: true,
              title: Text(
                '${item.plateNo}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              trailing: Text(
                '${item.totalAmount.toString()}',
                style: TextStyle(
                  color:
                      item.status == 'doing' ? Color(0xffFF7F24) : Colors.black,
                ),
              ),
            ),
            ListTile(
              dense: true,
              title: Text(
                '创建时间:${item.createdTime}',
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 请求订单列表
  int pageSize = 10;
  int pageIndex = 0;
  int total = 0;
  bool isLoading = false; // 是否正在加载
  List dataList = [];
  bool hasMore = true;
  // 进行中:doing 已完成:done 已关闭:closed
  getOrderList(String? type) async {
    if (isLoading) return;
    if (type == 'refresh') {
      pageIndex = 0;
    }
    isLoading = true;
    pageIndex++;
    ResponseInfo responseInfo = await Fetch.post(
      url: HttpHelper.getTradeList,
      data: {"payStatus": widget.status},
      page: {"pageIndex": pageIndex, "pageSize": pageSize},
    );
    if (responseInfo.success) {
      if (responseInfo.page != null) {
        PageBean pageBean = PageBean.fromJson(responseInfo.page!);
        total = pageBean.total ?? 0;
        hasMore = total <= pageIndex * pageSize;
      }
      isLoading = false;
      // 没有数据了
      if (responseInfo.data.length == 0) {
        pageIndex--;
      }
      List _dataList = responseInfo.data;
      if (type == 'upper') {
        dataList = [...dataList, ..._dataList];
        print(dataList);
      } else {
        dataList = _dataList;
      }
    }
    if (type == 'refresh') {
      easyRefreshController.finishRefresh(success: true);
    } else {
      easyRefreshController.finishLoad(
        success: true,
        noMore: hasMore,
      );
    }
    setState(() {});
  }
}
