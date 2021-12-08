import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_car_live/utils/bottomsheet_utils.dart';
import 'package:flutter_car_live/widgets/iconfont/iconfont.dart';

/// @Author: Tiancong
/// @Date: 2021-12-03 16:21:28
/// @Description: 洗车维保项目选择

class MaintDropdown extends StatefulWidget {
  final getSelected;
  const MaintDropdown({Key? key, Function(dynamic index)? this.getSelected})
      : super(key: key);
  @override
  _MaintDropdownState createState() => _MaintDropdownState();
}

class _MaintDropdownState extends State<MaintDropdown> {
  String? serveType;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          dense: true,
          title: Text('选择项目'),
          contentPadding: EdgeInsets.zero,
        ),
        GestureDetector(
          onTap: showBottomSelect,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Text(
                  '项目',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Expanded(
                  child: Text(
                    '${serveType ?? ""}',
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
    List<String> listOp = ['洗车', '保养', '维修'];
    BottomSheetUtils.show(
      context: context,
      list: listOp,
      action: (int index) {
        setState(() {
          serveType = listOp[index];
        });
        widget.getSelected(index);
      },
    );
  }
}
