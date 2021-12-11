import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_car_live/src/subpages/checkcard/widgets/top_bg.dart';
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
  @override
  void initState() {
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
          children: [TopBg(), buildGoodsListBox()],
        ),
      ),
    );
  }

  buildGoodsListBox() {
    return Container(
      // color: Colors.white,
      child: EasyRefresh.custom(
        controller: easyRefreshController, //上面创建的刷新控制器
        header: RefreshHeader(), //自定义刷新头
        footer: RefreshFooter(), //自定义加载尾
        onRefresh: () async {},
        onLoad: () async {
          // easyRefreshController.finishLoad(success: true);
        },
        slivers: <Widget>[
          // 这里设置列表
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return buildselectItem();
              },
              // 设置返回数据个数
              childCount: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildselectItem() {
    return Text('1212');
  }
}
