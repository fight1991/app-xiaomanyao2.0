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
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            image: AssetImage('assets/images/common/home-bg.png'),
          ),
        ),
        child: Column(
          children: [
            buildLeadTitle(),
            buildCheckCard(),
            buildCardOp(),
          ],
        ));
  }

  // 顶部背景区域
  Widget buildTopBg() {
    return Positioned(
      child: Image.asset('assets/images/common/home-bg.png'),
    );
  }

  // 发卡点区域
  Widget buildLeadTitle() {
    double statusH = MediaQuery.of(context).padding.top;
    return Container(
      padding: EdgeInsets.only(top: 20 + statusH),
      child: ListTile(
        leading: ClipOval(
          child: Image.asset(
            'assets/images/common/home-avatar.png',
            width: 50,
            height: 50,
          ),
        ),
        title: Text(
          '大同检测站发卡点',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  // 卡片核验区域
  Widget buildCheckCard() {
    return Container(
      height: 100,
      margin: EdgeInsets.only(top: 25, left: 12, right: 12, bottom: 12),
      padding: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 1.0,
          )
        ],
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/card/home-box1.png'),
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/card/heyan-home.png',
            width: 40,
          ),
          SizedBox(width: 10),
          Text('卡片核验', style: TextStyle(fontSize: 16))
        ],
      ),
    );
  }

  // 卡片操作区域
  Widget buildCardOp() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          buildCardOpItem(
            label: '卡片解绑',
            bg: 'assets/images/card/home-box2.png',
          ),
          SizedBox(width: 12),
          buildCardOpItem(
            label: '卡片报废',
            bg: 'assets/images/card/home-box3.png',
          ),
        ],
      ),
    );
  }

  // 卡片解绑
  buildCardOpItem({String? label, String? bg, Function()? onTap}) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 100,
          padding: EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 1.0,
              )
            ],
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(bg ?? 'assets/images/card/home-box2.png'),
            ),
          ),
          child: Text(label ?? '', style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
