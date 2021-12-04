import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OutlineBtn extends StatelessWidget {
  final ontap;
  final label;
  final color;
  final width;
  OutlineBtn(
      {Function()? this.ontap,
      String? this.label = '确定',
      double? this.width = 100,
      Color? this.color = Colors.black54});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: color)
            // color: Theme.of(context).accentColor,
            ),
        child: Text(
          label,
          style: TextStyle(color: color),
        ),
      ),
    );
  }
}
