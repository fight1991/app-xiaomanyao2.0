import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_car_live/net/dio_utils.dart';
import 'package:flutter_car_live/net/fetch_methods.dart';
import 'package:flutter_car_live/net/response_data.dart';
import 'package:flutter_car_live/src/bean/bean_page.dart';
import 'package:flutter_car_live/src/subpages/checkcard/widgets/top_bg.dart';
import 'package:flutter_car_live/src/subpages/commonApi/public_req.dart';
import 'package:flutter_car_live/utils/toast_utils.dart';
import 'package:flutter_car_live/widgets/common_btn/common_btn.dart';
import 'package:flutter_car_live/widgets/empty/empty.dart';
import 'package:flutter_car_live/widgets/refresh_config/refresh_footer.dart';
import 'package:flutter_car_live/widgets/refresh_config/refresh_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

/// @Author: Tiancong
/// @Date: 2021-12-03 10:51:29
/// @Description: 维保套餐类目

class MaintCategoryCard extends StatefulWidget {
  final cid;
  final orgServiceType;
  const MaintCategoryCard({
    Key? key,
    String? this.cid,
    String? this.orgServiceType,
  }) : super(key: key);
  @override
  _MaintCategoryCardState createState() => _MaintCategoryCardState();
}

class _MaintCategoryCardState extends State<MaintCategoryCard> {
  EasyRefreshController easyRefreshController = EasyRefreshController();
  int? currentSelect;
  @override
  void initState() {
    // 触发刷新
    easyRefreshController.callRefresh();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F6F7),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('商品选择'),
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff0BBAFB), Color(0xff4285EC)],
            ),
          ),
        ),
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(80),
        //   child: Container(),
        // ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [TopBg(), buildGoodsListBox(), buildBottomBtn()],
        ),
      ),
    );
  }

  // 确定按钮去支付
  void cofirmBtnClick() {
    if (currentSelect == null) {
      ToastUtils.showToast('请选择商品');
      return;
    }
    var map = dataList[currentSelect!];
    var price = map["goodsPlatPrice"];
    var cid = widget.cid;
    var goodsId = map["goodsId"];
    var orgServiceType = widget.orgServiceType;
    PublicReq.goPay(
      context,
      price: price,
      cid: cid,
      goodsId: goodsId,
      oilGunId: '',
      orgServiceType: orgServiceType,
    );
  }

  // 确定按钮区域
  Widget buildBottomBtn() {
    return Positioned(
      child: Offstage(
        offstage: total == 0,
        child: CommonBtn(radius: false, ontap: cofirmBtnClick),
      ),
      bottom: 0,
      left: 0,
      right: 0,
    );
  }

  // 滚动区域
  Widget buildGoodsListBox() {
    return Container(
      // color: Colors.white,
      margin: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 50),
      child: EasyRefresh.custom(
        controller: easyRefreshController, //上面创建的刷新控制器
        header: RefreshHeader(textColor: Colors.white), //自定义刷新头
        footer: RefreshFooter(), //自定义加载尾
        emptyWidget: total == 0 ? Empty() : null,
        onRefresh: () async {
          await getGoodList('refresh');
        },
        onLoad: () async {
          await getGoodList('upper');
        },
        slivers: <Widget>[
          SliverGrid(
            //子Widget布局
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                String goodsName = dataList[index]["goodsName"];
                double goodsPlatPrice = dataList[index]["goodsPlatPrice"];
                return buildselectItem(goodsName, goodsPlatPrice, index);
              },
              childCount: dataList.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, //四列
              mainAxisSpacing: 15, //item上下间隔
              crossAxisSpacing: 15, //item左右间隔
              childAspectRatio: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildselectItem(String goodsName, double price, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentSelect = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              width: 2,
              color: currentSelect == index
                  ? Color(0xff76B6FF)
                  : Colors.transparent),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              spreadRadius: 1.0,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              price.toString(),
              style: TextStyle(color: Color(0xff76B6FF), fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(goodsName),
          ],
        ),
      ),
    );
  }

  // 请求列表
  int pageSize = 10;
  int pageIndex = 0;
  int total = 0;
  bool isLoading = false; // 是否正在加载
  List dataList = [];
  bool hasMore = true;

  getGoodList(String? type) async {
    if (isLoading) return;
    if (type == 'refresh') {
      pageIndex = 0;
    }
    isLoading = true;
    pageIndex++;
    ResponseInfo responseInfo = await Fetch.post(
      url: HttpHelper.getPagedGoodsList,
      data: {"orgServiceType": widget.orgServiceType},
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
