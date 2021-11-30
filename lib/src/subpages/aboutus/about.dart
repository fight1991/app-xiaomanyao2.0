import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// @Author: Tiancong
/// @Date: 2021-11-30 16:05:23
/// @Description: 关于我们页面

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  String _graphFirst =
      '航天吉光科技有限公司是深圳航天科技创新研究院作为投资主体，江阴市高新技术开发区管理委员会参与投资建设的，是航天科技集团和地方政府央地合作的典范。';
  String _graphTwo =
      '小蛮腰 APP 是航天吉光科技有限公司精心打造的基于电子车牌的涉车支付商户平台，实现停洗车、加油、保险、维修保养等涉车消费商户功能。';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('关于我们'),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Image.asset(
              'assets/images/common/about-icon1.png',
              width: 80,
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              child: Text(_graphFirst),
            ),
            Container(
              child: Text(_graphTwo),
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/images/common/about-icon.png',
                    width: 120,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('v1.0.0'),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
