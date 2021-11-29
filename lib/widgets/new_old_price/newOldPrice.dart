import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewOldPrice extends StatelessWidget {
  final String newPrice;
  final String oldPrice;
  NewOldPrice({required this.newPrice, required this.oldPrice});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 2, bottom: 3),
      child: Text.rich(
        TextSpan(children: [
          TextSpan(
            text: '¥$newPrice',
            style: TextStyle(color: Color(0xffFF7E37)),
          ),
          TextSpan(text: '  '),
          TextSpan(
            text: '油站¥$oldPrice',
            style: TextStyle(
              color: Color(0xff808080),
              decoration: TextDecoration.lineThrough,
            ),
          )
        ]),
      ),
    );
  }
}
