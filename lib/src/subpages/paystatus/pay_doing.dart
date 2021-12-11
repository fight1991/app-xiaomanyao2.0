import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_car_live/src/subpages/commonApi/public_req.dart';

/// @Author: Tiancong
/// @Date: 2021-12-10 17:41:05
/// @Description: 交易处理中页面

class PayDoing extends StatefulWidget {
  final orderNo;
  const PayDoing({Key? key, String? this.orderNo}) : super(key: key);
  @override
  _PayDoingState createState() => _PayDoingState();
}

class _PayDoingState extends State<PayDoing>
    with SingleTickerProviderStateMixin {
  Animation<double>? animation;
  AnimationController? controller;

  @override
  void initState() {
    // 5秒后查询订单状态
    // Future.delayed(Duration(seconds: 5), () {
    //   getStatus();
    // });
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    //匀速
    //图片宽高从0变到300
    Future.delayed(Duration.zero, () {
      controller?.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          //动画从 controller.forward() 正向执行 结束时会回调此方法
          print("status is completed");
          //重置起点
          controller?.reset();
          //开启
          controller?.forward();
        } else if (status == AnimationStatus.dismissed) {
          //动画从 controller.reverse() 反向执行 结束时会回调此方法
          print("status is dismissed");
        } else if (status == AnimationStatus.forward) {
          print("status is forward");
          //执行 controller.forward() 会回调此状态
        } else if (status == AnimationStatus.reverse) {
          //执行 controller.reverse() 会回调此状态
          print("status is reverse");
        }
      });
      //启动动画(正向执行)
      controller?.forward();
    });

    super.initState();
  }

  @override
  void dispose() {
    //路由销毁时需要释放动画资源
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('交易处理中'),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            controller == null
                ? Image.asset(
                    'assets/images/loading.png',
                    width: 100,
                    height: 100,
                  )
                : RotationTransition(
                    turns: controller!,
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/loading.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
            SizedBox(height: 15),
            Text(
              '交易处理中',
              style: TextStyle(
                color: Color(0xff447fff),
              ),
            )
          ],
        ),
      ),
    );
  }

  void getStatus() async {
    PublicReq.getStatus(context, orderNo: widget.orderNo, withLoading: false);
  }
}
