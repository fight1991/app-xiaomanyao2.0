import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_live/widgets/iconfont/iconfont.dart';

import 'DropdownNotification.dart';

// dropdown部件
class Dropdown extends StatefulWidget {
  final List<DropdownItem> items;
  final Function? onTap;
  final int? selected;
  Dropdown({Key? key, required this.items, this.selected, this.onTap});
  @override
  _Dropdown createState() => _Dropdown();
}

class _Dropdown extends State<Dropdown> {
  GlobalKey _nodeKey = GlobalKey();
  double layoutH = 0; //遮罩高度
  bool isOpen = false; // 是否打开遮罩
  @override
  void initState() {
    _getBingPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<DropdownNotification>(
      onNotification: (notification) {
        print(notification.index);
        widget.onTap!(notification.index);
        return true;
      },
      child: Container(
        key: _nodeKey,
        padding: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: widget.items,
            ),
            Positioned(
              top: 40,
              left: 0,
              child: Opacity(
                opacity: .4,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: isOpen ? layoutH : 0,
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Text('遮罩'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _getBingPosition() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final RenderBox renderBox =
          _nodeKey.currentContext!.findRenderObject() as RenderBox;
      var position = renderBox.localToGlobal(Offset.zero);
      print(position.dy);
      print(renderBox.size);
      layoutH = MediaQuery.of(context).size.height - position.dy;
    });
  }
}

/// dropdown下拉子部件
class DropdownItem extends StatefulWidget {
  final String label;
  final int index;
  final int? currentIndex;
  DropdownItem({required this.label, required this.index, this.currentIndex});
  @override
  _DropdownItem createState() => _DropdownItem();
}

class _DropdownItem extends State<DropdownItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        DropdownNotification(widget.index).dispatch(context);
      },
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        height: 30,
        decoration: BoxDecoration(
            color: Color(0xffff5f5f5), borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Text(
              widget.label,
              style: TextStyle(
                color: widget.currentIndex == widget.index
                    ? Theme.of(context).accentColor
                    : Colors.black,
              ),
            ),
            SizedBox(
              width: 3,
            ),
            Icon(
              IconFont.icon_arrow_down,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
