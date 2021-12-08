import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_car_live/widgets/common_btn/common_btn.dart';

/// @Author: Tiancong
/// @Date: 2021-12-08 18:15:42
/// @Description: 无

class BottomBtn extends StatelessWidget {
  final ontap;
  BottomBtn({Function? this.ontap});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 0,
      right: 0,
      child: Padding(
        child: CommonBtn(
          ontap: ontap,
        ),
        padding: EdgeInsets.only(
          left: 30,
          right: 30,
        ),
      ),
    );
  }
}
