import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomSheetItem extends StatelessWidget {
  final label;
  final onTap;
  final index;
  final showBottomBorder;
  BottomSheetItem(
      {required String this.label,
      Function(int index)? this.onTap,
      bool? this.showBottomBorder = true,
      int? this.index});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: 14, bottom: 14),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: showBottomBorder ? Colors.black12 : Colors.transparent,
            ),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
        ),
      ),
      onTap: () {
        if (onTap != null) {
          onTap(index);
        }
        Navigator.of(context).pop();
      },
    );
  }
}

class BottomSheetUtils {
  static void show(
      {required BuildContext context,
      required List<String> list,
      required Function(int index) action}) {
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
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...List.generate(
                list.length,
                (index) => BottomSheetItem(
                  label: list[index],
                  index: index,
                  onTap: action,
                ),
              ).toList(),
              BottomSheetItem(
                label: '取消',
                showBottomBorder: false,
              )
            ],
          ),
        );
      },
    );
  }
}
