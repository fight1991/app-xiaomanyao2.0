import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmDialogUtils {
  // 显示弹框
  static Future<bool> show(
      {String title = '温馨提示',
      required context,
      String content = '',
      String cancelText = '取消',
      String confirmText = '确认',
      Color? cancelColor,
      Color? confirmColor}) async {
    return await showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            title,
            style: TextStyle(fontSize: 14),
          ),
          content: Container(
            padding: EdgeInsets.only(top: 16, left: 12, right: 12, bottom: 10),
            child: Text(content),
          ),
          actions: [
            // 左边按钮
            CupertinoDialogAction(
              child: Text(
                cancelText,
                style:
                    TextStyle(color: cancelColor ?? Colors.red, fontSize: 14),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            CupertinoDialogAction(
              child: Text(
                confirmText,
                style: TextStyle(
                    color: confirmColor ?? Color(0xff18AEF7), fontSize: 14),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}
