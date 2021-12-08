import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_car_live/widgets/iconfont/iconfont.dart';

/// @Author: Tiancong
/// @Date: 2021-12-08 18:15:42
/// @Description: 无

class FormBox extends StatelessWidget {
  final itemSubTitle;
  final itemTitle;
  final getValue;
  FormBox(
      {required Widget this.itemSubTitle,
      String? this.itemTitle,
      Function(String value)? this.getValue});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(left: 15, right: 15, top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 2),
            spreadRadius: 1.0,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              itemTitle ?? '',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          itemSubTitle,
          Divider(),
          ListTile(
            dense: true,
            title: Text('输入金额'),
            contentPadding: EdgeInsets.zero,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Text(
                  '¥',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Color(0xff447fff)),
                    textAlign: TextAlign.center,
                    onChanged: (String text) {
                      if (getValue != null) {
                        getValue(text);
                      }
                    },
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Visibility(
                  visible: false,
                  child: Icon(
                    IconFont.icon_arrow_down_line,
                    size: 20,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
