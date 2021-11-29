import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_live/src/subpages/maint/maint_list_page.dart';
import 'package:flutter_car_live/src/subpages/parking/parking_list_page.dart';
import 'package:flutter_car_live/src/subpages/refuel/refuel_list_page.dart';
import 'package:flutter_car_live/src/subpages/wash/wash_list_page.dart';
import 'package:flutter_car_live/utils/log_utils.dart';
import 'package:flutter_car_live/utils/navigator_utils.dart';
import 'package:flutter_car_live/widgets/iconfont/iconfont.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(IconFont.icon_position),
            SizedBox(width: 5),
            Text('恒大财富中心'),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: ListView(
          children: [
            buildCouponBox(), //优惠券轮播区域
            buildGridBox(), //业务按钮区域
            buildBtnBox(), //电子车牌申领区域
          ],
        ),
      ),
    );
  }

  Widget buildCouponBox() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      height: MediaQuery.of(context).size.width * (178 / 690),
      // width: MediaQuery.of(context).size.width,
      child: Swiper(
          itemCount: 3,
          // viewportFraction: 0.8,
          // scale: 0.9,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Image.asset(
                'assets/images/banner1.png',
                fit: BoxFit.fill,
              ),
            );
          },
          pagination: SwiperPagination(alignment: Alignment.bottomCenter),
          onTap: (int index) {
            LogUtils.e('点击轮播图$index');
          }),
    );
  }

  Widget buildGridBox() {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          girdBtnItem(
            iconName: 'oil.png',
            label: '无感加油',
            targPage: RefuelListPage(),
          ),
          girdBtnItem(
            iconName: 'maintenance.png',
            label: '维修保养',
            targPage: MaintListPage(),
          ),
          girdBtnItem(
            iconName: 'wash.png',
            label: '洗车美容',
            targPage: WashListPage(),
          ),
          girdBtnItem(
            iconName: 'parking.png',
            label: '智慧停车',
            targPage: ParkingListPage(),
          ),
        ],
      ),
    );
  }

  Widget girdBtnItem(
      {String iconName = 'oil.png',
      String label = '',
      required Widget targPage}) {
    return GestureDetector(
      onTap: () {
        NavigatorUtils.pushPage(context: context, targPage: targPage);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/$iconName',
            width: 56,
            height: 56,
          ),
          SizedBox(height: 5),
          Text(label)
        ],
      ),
    );
  }

  Widget buildBtnBox() {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 15, bottom: 15),
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: buildBtnItem(bg: 'plate-bg.png', label: '电子车牌'),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: buildBtnItem(bg: 'car-bg.png', label: '我的车辆'),
                  ),
                  Container(
                    child: buildBtnItem(bg: 'scan-bg.png', label: '扫一扫'),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildBtnItem({required String bg, String label = ''}) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/$bg',
          fit: BoxFit.fill,
        ),
        Positioned(
          left: 10,
          top: 12,
          child: Text(
            label,
            style: TextStyle(fontSize: 18),
          ),
        )
      ],
    );
  }
}
