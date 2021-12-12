import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// @Author: Tiancong
/// @Date: 2021-12-12 11:25:31
/// @Description: 暂无数据占位组件

class Empty extends StatelessWidget {
  const Empty({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 80),
        child: Image.asset('assets/images/owner/no.png', width: 200),
      ),
    );
  }
}
