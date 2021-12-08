import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_car_live/net/fetch_methods.dart';
import 'package:flutter_car_live/net/http_helper.dart';
import 'package:flutter_car_live/net/response_data.dart';
import 'package:flutter_car_live/src/bean/bean_gun.dart';
import 'package:flutter_car_live/widgets/iconfont/iconfont.dart';

/// @Author: Tiancong
/// @Date: 2021-12-03 16:21:28
/// @Description: 无

class OilDropdown extends StatefulWidget {
  final getSelected;
  const OilDropdown({Key? key, Function(GunBean gunBean)? this.getSelected})
      : super(key: key);
  @override
  _OilDropdownState createState() => _OilDropdownState();
}

class _OilDropdownState extends State<OilDropdown> {
  GunBean? _currentGun; // 当前枪
  int? _currentIndex;
  List<Map<String, dynamic>>? _gunList;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          dense: true,
          title: Text('选择枪号'),
          contentPadding: EdgeInsets.zero,
        ),
        GestureDetector(
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
                    '${_currentGun?.oilGunName}',
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
        )
      ],
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
          itemCount: _gunList?.length,
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
      _currentIndex = index;
    });
    Navigator.of(context).pop();
  }

  // 底部选择项
  Widget bottomSelectItem(int index) {
    return GestureDetector(
      onTap: () {
        selectBtn(index);
        Map<String, dynamic> _map = _gunList![index];
        GunBean gunBean = GunBean.fromJson(_map);
        widget.getSelected(gunBean);
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3),
          border: Border.all(
              color:
                  _currentIndex == index ? Color(0xff3E89EB) : Colors.black12),
        ),
        child: Text(
          '$index',
          style: TextStyle(
              color: _currentIndex == index ? Color(0xff3E89EB) : Colors.black),
        ),
      ),
    );
  }

  // 获取油枪列表
  getGunListApi() async {
    ResponseInfo responseInfo = await Fetch.post(url: HttpHelper.gunList);
    if (responseInfo.success) {
      List<Map<String, dynamic>> gunList =
          responseInfo.data.map((item) => GunBean.fromJson(item)).toList();
    }
  }
}
