import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonBtn extends StatelessWidget {
  final ontap;
  final label;
  CommonBtn({Function()? this.ontap, String? this.label = '确定'});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 46,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff0BBAFB), Color(0xff4285EC)],
          ),
          borderRadius: BorderRadius.circular(6),
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
