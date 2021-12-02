import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_live/src/subpages/checkcard/check_card.dart';
import 'package:flutter_car_live/src/subpages/order/order.dart';
import 'package:flutter_car_live/src/subpages/scrap/scrap.dart';
import 'package:flutter_car_live/utils/navigator_utils.dart';

/// @Author: Tiancong
/// @Date: 2021-11-30 10:07:03
/// @Description: 首页
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
          buildAcceptMoney(),
          buildOrderCard()
        ],
      ),
    );
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
    return GestureDetector(
      onTap: () {
        NavigatorUtils.pushPageByFade(
          context: context,
          targPage: CheckCard(pageTitle: '卡片核验', pageFlag: 'check'),
        );
      },
      child: Container(
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
              onTap: () {
                NavigatorUtils.pushPageByFade(
                  context: context,
                  targPage: CheckCard(pageTitle: '卡片解绑', pageFlag: 'unbind'),
                );
              }),
          SizedBox(width: 12),
          buildCardOpItem(
              label: '卡片报废',
              bg: 'assets/images/card/home-box3.png',
              onTap: () {
                NavigatorUtils.pushPageByFade(
                  context: context,
                  targPage: Scrap(),
                );
              }),
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

  // 发起收款区域
  buildAcceptMoney() {
    return GestureDetector(
      onTap: () {
        NavigatorUtils.pushPageByFade(
          context: context,
          targPage: CheckCard(pageTitle: '发起收款', pageFlag: 'money'),
        );
      },
      child: Container(
        height: 150,
        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(top: 25, left: 12, right: 12),
        padding: EdgeInsets.only(left: 30, top: 25),
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
            image: AssetImage('assets/images/owner/pay-bg.png'),
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/images/owner/pay-icon.png',
              width: 60,
            ),
            SizedBox(width: 15),
            Text('发起收款', style: TextStyle(fontSize: 16))
          ],
        ),
      ),
    );
  }

  // 订单管理区域
  Widget buildOrderCard() {
    return GestureDetector(
      onTap: () {
        NavigatorUtils.pushPageByFade(
          context: context,
          targPage: Order(),
        );
      },
      child: Container(
        height: 100,
        margin: EdgeInsets.only(top: 20, left: 12, right: 12),
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
            image: AssetImage('assets/images/owner/order-bg.png'),
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/images/owner/order-icon.png',
              width: 60,
            ),
            SizedBox(width: 15),
            Text('订单管理', style: TextStyle(fontSize: 16))
          ],
        ),
      ),
    );
  }
}
