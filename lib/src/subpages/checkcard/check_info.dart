import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// @Author: Tiancong
/// @Date: 2021-12-01 18:20:48
/// @Description: 无

class CheckInfo extends StatefulWidget {
  final cid;
  CheckInfo({Key? key, String? this.cid}) : super(key: key);
  @override
  _CheckInfoState createState() => _CheckInfoState();
}

class _CheckInfoState extends State<CheckInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('核验信息'),
        elevation: 0,
      ),
      backgroundColor: Color(0xfff7f7f7),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            buildLineInfo('卡号', '121221'),
            Divider(),
            buildLineInfo('车牌号', '121221'),
            Divider(),
            buildInstallImg(
              'https://cdn.wwads.cn/creatives/jA87ghlAnCDo3K6k5oTfACNlt038G3mNVfjklifg.jpg',
              'https://cdn.wwads.cn/creatives/jA87ghlAnCDo3K6k5oTfACNlt038G3mNVfjklifg.jpg',
            )
          ],
        ),
      ),
    );
  }

  Widget buildLineInfo(String title, [String? trailing]) {
    return ListTile(
      title: Text(title),
      trailing: Text(trailing ?? ''),
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget buildInstallImg(String src1, String src2) {
    return Column(
      children: [
        buildLineInfo('安装照片'),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Image.network(
                src1,
                width: 100,
              ),
              SizedBox(width: 10),
              Image.network(
                src2,
                width: 100,
              )
            ],
          ),
        )
      ],
    );
  }
}
