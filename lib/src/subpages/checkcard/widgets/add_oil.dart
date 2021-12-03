import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_car_live/widgets/iconfont/iconfont.dart';

/// @Author: Tiancong
/// @Date: 2021-12-03 16:21:28
/// @Description: 无

class AddOil extends StatefulWidget {
  const AddOil({Key? key}) : super(key: key);
  @override
  _AddOilState createState() => _AddOilState();
}

class _AddOilState extends State<AddOil> {
  int? _currentGun; // 当前枪号
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showBottomSelect,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Text(
              '枪号',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Expanded(
              child: Text(
                '${_currentGun ?? ""}',
                style: TextStyle(
                  color: Color(0xff447fff),
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Icon(
              IconFont.icon_arrow_down_line,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  // 底部弹出选择按钮
  void showBottomSelect() {
    showModalBottomSheet(
      context: context,
      // backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      builder: (BuildContext context) {
        return buildBottomBox();
      },
    );
  }

  // 底部弹框widget
  Widget buildBottomBox() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
      height: MediaQuery.of(context).size.height * 0.4,
      child: GridView.builder(
          itemCount: 20,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 2,
          ),
          itemBuilder: (BuildContext context, int index) {
            return bottomSelectItem(index);
          }),
    );
  }

  // 选择枪号按钮
  void selectBtn(int index) {
    setState(() {
      _currentGun = index;
    });
    Navigator.of(context).pop();
  }

  // 底部选择项
  Widget bottomSelectItem(int index) {
    return GestureDetector(
      onTap: () {
        selectBtn(index);
        // 收起键盘
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3),
          border: Border.all(
              color: _currentGun == index ? Color(0xff3E89EB) : Colors.black12),
        ),
        child: Text(
          '$index',
          style: TextStyle(
              color: _currentGun == index ? Color(0xff3E89EB) : Colors.black),
        ),
      ),
    );
  }
}
