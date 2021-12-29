import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_car_live/utils/toast_utils.dart';
import 'package:flutter_car_live/widgets/keep_alive_wrapper/keep_alive_wrapper.dart';

import 'home_main_page.dart';
import 'home_mine_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  PageController _pageController = PageController();
  DateTime? lastPopTime;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          // 点击返回键的操作
          if (lastPopTime == null ||
              DateTime.now().difference(lastPopTime!) > Duration(seconds: 2)) {
            lastPopTime = DateTime.now();
            ToastUtils.showToast('再按一次退出程序');
          } else {
            lastPopTime = DateTime.now();
            await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          }
          return Future.value(false);
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: PageView(
            controller: _pageController,
            // 不可左右滑动
            physics: NeverScrollableScrollPhysics(),
            children: [
              KeepAliveWrapper(child: MainPage()),
              KeepAliveWrapper(child: MinePage()),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int value) {
          setState(() {
            _currentIndex = value;
            _pageController.jumpToPage(value);
          });
        },
        // 显示文字
        type: BottomNavigationBarType.fixed,
        // 选中的颜色
        selectedItemColor: Theme.of(context).accentColor,
        // 未选中的颜色
        unselectedItemColor: Colors.black54,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
        ],
      ),
    );
  }
}
