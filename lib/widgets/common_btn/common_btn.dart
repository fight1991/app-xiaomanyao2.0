import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonBtn extends StatelessWidget {
  final ontap;
  final label;
  final bg;
  final radius;
  CommonBtn(
      {Function()? this.ontap,
      String? this.label = '确定',
      bool this.radius = true,
      Color? this.bg});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 46,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: bg == null
              ? LinearGradient(
                  colors: [Color(0xff0BBAFB), Color(0xff4285EC)],
                )
              : null,
          color: bg,
          borderRadius: BorderRadius.circular(radius ? 6 : 0),
          // color: Theme.of(context).accentColor,
        ),
        child: Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
