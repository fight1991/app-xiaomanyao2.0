import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_live/widgets/common_card/card_bean.dart';

class CommonCard extends StatelessWidget {
  final CardBean cardBean;
  final Widget? textline3;
  final Widget? textline4;

  CommonCard({Key? key, required this.cardBean, this.textline3, this.textline4})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/maintenance.png',
            fit: BoxFit.contain,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    '${cardBean.title}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '${cardBean.subTitle}',
                    style: TextStyle(color: Color(0xff808080)),
                  ),
                  textline3 ?? Container(),
                  textline4 ?? Container()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
