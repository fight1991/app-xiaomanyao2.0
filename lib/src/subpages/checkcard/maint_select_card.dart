import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_car_live/src/subpages/checkcard/maint_category_card.dart';
import 'package:flutter_car_live/src/subpages/checkcard/maint_form_card.dart';
import 'package:flutter_car_live/src/subpages/checkcard/widgets/top_bg.dart';
import 'package:flutter_car_live/utils/navigator_utils.dart';
import 'package:flutter_car_live/widgets/iconfont/iconfont.dart';

/// @Author: Tiancong
/// @Date: 2021-12-03 10:51:29
/// @Description: 维保选项

class MaintSelectCard extends StatefulWidget {
  final cid;
  const MaintSelectCard({Key? key, String? this.cid}) : super(key: key);
  @override
  _MaintSelectCardState createState() => _MaintSelectCardState();
}

class _MaintSelectCardState extends State<MaintSelectCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE9ECF1),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('项目选择'),
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff0BBAFB), Color(0xff4285EC)],
            ),
          ),
        ),
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(80),
        //   child: Container(),
        // ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [TopBg(), buildListTitleBox()],
        ),
      ),
    );
  }

  itemBtnClick(String? type) {
    String cid = widget.cid;
    List<String> serverList = ['repair', 'custom'];
    if (serverList.contains(type)) {
      NavigatorUtils.pushPageByFade(
        context: context,
        targPage: MaintFormCard(
          orgServiceType: type,
          cid: cid,
        ),
      );
      return;
    }
    NavigatorUtils.pushPageByFade(
      context: context,
      targPage: MaintCategoryCard(
        orgServiceType: type,
        cid: cid,
      ),
    );
  }

  Widget buildListTitleBox() {
    return Container(
      margin: EdgeInsets.only(top: 25, left: 15, right: 15),
      decoration: BoxDecoration(
        boxShadow: [
          // BoxShadow(
          //   color: Colors.black12,
          //   blurRadius: 10,
          //   offset: Offset(0, 2),
          //   spreadRadius: 1.0,
          // )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildListItem(
            label: '洗车',
            value: 'carWash',
            imgName: "wash",
          ),
          buildListItem(
            label: '维修',
            value: 'repair',
            imgName: "repair",
          ),
          buildListItem(
            label: '保养',
            value: 'upkeep',
            imgName: "maint",
            bgColor: Colors.green,
          ),
          SizedBox(height: 10),
          buildListItem(
            label: '自定义',
            value: 'custom',
            imgName: "self",
            bgColor: Color(0xff447fff),
          ),
        ],
      ),
    );
  }

  Widget buildListItem(
      {String? label,
      String? value,
      String imgName = "standard",
      Color? bgColor}) {
    return GestureDetector(
      onTap: () {
        itemBtnClick(value);
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: ListTile(
          leading: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor ?? Colors.transparent,
            ),
            child: Image.asset(
              'assets/images/$imgName-card.png',
              width: 40,
              fit: BoxFit.fitWidth,
            ),
          ),
          title: Text(label ?? ''),
          trailing: Icon(IconFont.icon_arrow_right),
        ),
      ),
    );
  }
}
