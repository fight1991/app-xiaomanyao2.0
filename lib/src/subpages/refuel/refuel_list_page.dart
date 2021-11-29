import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_live/net/dio_utils.dart';
import 'package:flutter_car_live/widgets/common_card/card_bean.dart';
import 'package:flutter_car_live/utils/log_utils.dart';
import 'package:flutter_car_live/utils/toast_utils.dart';
import 'package:flutter_car_live/widgets/common_card/common_card.dart';
import 'package:flutter_car_live/widgets/iconfont/iconfont.dart';
import 'package:flutter_car_live/widgets/new_old_price/newOldPrice.dart';
import 'package:flutter_car_live/widgets/tag/tag.dart';

class RefuelListPage extends StatefulWidget {
  _RefuelListPage createState() => _RefuelListPage();
}

class _RefuelListPage extends State<RefuelListPage> {
  @override
  void initState() {
    onRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('无感加油'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Color(0xffF5F9FC)),
        // decoration: BoxDecoration(color: Colors.pink[50]),
        child: Column(
          children: [
            // 搜索框
            buildInputBox(),
            // 筛选条件区域
            buildDropdownBox(),
            // 其余区域
            Expanded(
              child: Container(
                width: double.infinity,
                child: Stack(
                  children: [
                    // 列表区域
                    buildListBox(),
                    // 蒙层区域
                    buildMaskBox(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildInputBox() {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(IconFont.icon_search),
          border: InputBorder.none,
          hintText: '搜索附件的加油站',
        ),
      ),
    );
  }

  Widget buildDropdownBox() {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildSelectItem('附近', 1),
          buildSelectItem('油号', 2),
          buildSelectItem('距离', 3),
        ],
      ),
    );
  }

  Widget buildSelectItem(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_dropDownIndex == index) {
            _showMask = !_showMask;
            return;
          }
          _showMask = true;
          _dropDownIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          children: [
            Text(text),
            SizedBox(width: 3),
            Icon(
              IconFont.icon_arrow_down,
              size: 12,
            )
          ],
        ),
      ),
    );
  }

  Widget buildListBox() {
    return NotificationListener<ScrollEndNotification>(
      onNotification: (ScrollNotification notification) {
        LogUtils.e("滑动结束了了了");
        //在滑动结束的时候 判断下如果滑动了 2/3数据
        //就自动加载下一页数据
        //获取滑动的距离
        //ScrollMetrics 是保存就滑动相关的信息
        // pixels
        ScrollMetrics scrollMetrics = notification.metrics;
        //获取滑动的距离
        double pixels = scrollMetrics.pixels;
        //获取最大滑动的距离
        double maxPixels = scrollMetrics.maxScrollExtent;
        //获取滑动的方向
        // AxisDirection axisDirection = scrollMetrics.axisDirection;
        if (pixels >= maxPixels / 3 * 2) {
          //加载更多
          loadmore();
        }
        //返回true 阻止再向上发送通知
        return true;
      },
      child: RefreshIndicator(
        child: Container(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
          child: ListView.builder(
            itemCount: _listData.length,
            itemBuilder: (BuildContext context, int index) {
              CardBean oilShopBean = _listData[index];
              return CommonCard(
                cardBean: oilShopBean,
                textline3: NewOldPrice(
                  newPrice: '${oilShopBean.newPrice}',
                  oldPrice: '${oilShopBean.oldPrice}',
                ),
                textline4: Tag(
                  label: '加油$index',
                  isActive: true,
                ),
              );
            },
          ),
        ),
        onRefresh: () {
          return onRefresh();
        },
      ),
    );
  }

  // 下拉刷新,上拉加载变量
  int _pageIndex = 1;
  int _pageSize = 10;
  bool _isLoading = false;
  List _listData = [];

  // 下拉刷新
  Future<bool> onRefresh() async {
    // 最少显示一秒
    await Future.delayed(Duration(milliseconds: 1000));
    _pageIndex = 1;
    await loadingNetData();
    ToastUtils.showToast('已刷新');
    return true;
  }

  //加载更多
  loadmore() {
    if (_isLoading) return _isLoading = true;
    _pageIndex++;
    loadingNetData();
  }

  Future<void> loadingNetData() async {
    //添加一下分页请求信息
    Map<String, dynamic> map = new Map();
    //当前页数
    map['pageIndex'] = _pageIndex;
    //每页大小
    map['pageSize'] = _pageSize;
    //使用模拟数据
    ResponseInfo responseInfo =
        await Future.delayed(Duration(milliseconds: 1000), () {
      List list = [];
      for (int i = 0; i < 10; i++) {
        list.add({
          'title': '加油站$i',
          'address': '北京中南海同仁堂48号',
          'newPrice': '100',
          'oldPrice': '120',
        });
      }
      return ResponseInfo(data: list);
    });
    //加载结束标识
    _isLoading = false;
    if (responseInfo.success) {
      List list = responseInfo.data;
      //无数据时 更新索引
      if (list.length == 0 && _pageIndex != 1) {
        _pageIndex--;
      }
      if (_pageIndex == 1) {
        //清空一下数据
        _listData = [];
      }
      list.forEach((element) {
        _listData.add(CardBean.fromMap(element));
      });
      setState(() {});
    } else {
      ToastUtils.showToast('请求失败');
    }
    return;
  }

  // 蒙层区域
  int _dropDownIndex = 0;
  String _distanceValue = '3';
  String _oilTypeValue = '92#';
  String _otherValue = 'distance';

  List _distanceList = [
    {'label': '3km', 'value': '3'},
    {'label': '5km', 'value': '5'},
    {'label': '10km', 'value': '10'},
    {'label': '15km', 'value': '15'},
    {'label': '不限', 'value': '-1'}
  ];
  List _oilTypeList = [
    {'label': '92#', 'value': '92#'},
    {'label': '95#', 'value': '95#'},
    {'label': '98#', 'value': '98#'},
    {'label': '0#', 'value': '0#'}
  ];
  List _otherList = [
    {'label': '距离最近', 'value': 'distance'},
    {'label': '价格最低', 'value': 'price'}
  ];
  bool _showMask = false;
  buildMaskBox() {
    if (_showMask) {
      return Positioned.fill(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _dropDownIndex = 0;
              Future.delayed(Duration(microseconds: 0), () {
                _showMask = false;
              });
            });
          },
          child: Container(
            decoration: BoxDecoration(color: Colors.black45),
            child: IndexedStack(
              index: _dropDownIndex,
              children: [
                Container(),
                buildDropdownItem(_distanceList, '_distance'),
                buildDropdownItem(_oilTypeList, '_oilType'),
                buildDropdownItem(_otherList, '_other'),
              ],
            ),
          ),
        ),
      );
    } else {
      setState(() {
        _dropDownIndex = 0;
      });
      return Container();
    }
  }

  buildDropdownItem(List option, String flag) {
    var itemWith = MediaQuery.of(context).size.width;
    Map<String, dynamic> map = {
      '_distance': _distanceValue,
      '_oilType': _oilTypeValue,
      '_other': _otherValue
    };
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(color: Colors.white),
      child: GridView.builder(
        itemCount: option.length,
        shrinkWrap: true, // Container跟随GridView内容变化高度
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20,
          childAspectRatio: (itemWith - 3 * 10) / 4 / 26,
        ),
        itemBuilder: (BuildContext context, int index) {
          Map temp = option[index];
          String value = temp['value'];
          String label = temp['label'];
          return Center(
            child: Tag(
              width: 70,
              height: 26,
              label: label,
              value: value,
              isActive: map[flag] == value,
              onTap: (value) {
                print(value);
                setState(() {
                  if (flag == '_distance') {
                    _distanceValue = value;
                  } else if (flag == '_oilType') {
                    _oilTypeValue = value;
                  } else {
                    _otherValue = value;
                  }
                  _dropDownIndex = 0;
                  _showMask = false;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
