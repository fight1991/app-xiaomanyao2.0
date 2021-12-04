import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// @Author: Tiancong
/// @Date: 2021-12-03 17:32:07
/// @Description: 扣款状态

class PayStatus extends StatefulWidget {
  const PayStatus({Key? key}) : super(key: key);
  @override
  _PayStatusState createState() => _PayStatusState();
}

class _PayStatusState extends State<PayStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Positioned(
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/owner/check-bg.png'),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
