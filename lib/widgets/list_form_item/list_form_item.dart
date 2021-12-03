import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// @Author: Tiancong
/// @Date: 2021-12-02 18:12:28
/// @Description: 无
class ListFormItem extends StatelessWidget {
  final String? title;
  final String? trailing;
  final Color? titleColor;
  final bool? showBottomBorder;
  final EdgeInsetsGeometry? margin;
  ListFormItem(
      {this.title,
      this.trailing,
      this.titleColor,
      this.margin: const EdgeInsets.symmetric(horizontal: 20),
      this.showBottomBorder: true});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                color: showBottomBorder == true
                    ? Colors.black12
                    : Colors.transparent)),
      ),
      child: ListTile(
        title: Text(
          title ?? '',
          style: TextStyle(color: titleColor),
        ),
        trailing: Text(trailing ?? ''),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
