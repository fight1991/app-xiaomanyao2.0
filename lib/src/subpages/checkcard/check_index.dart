import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_car_live/channel/app_method_channel.dart';
import 'package:flutter_car_live/common/eventBus.dart';
import 'package:flutter_car_live/providers/permission_model.dart';
import 'package:flutter_car_live/src/subpages/checkcard/info_card.dart';
import 'package:flutter_car_live/src/subpages/checkcard/add_oil_card.dart';
import 'package:flutter_car_live/src/subpages/checkcard/maint_select_card.dart';
import 'package:flutter_car_live/src/subpages/checkcard/unbind_card.dart';
import 'package:flutter_car_live/utils/log_utils.dart';
import 'package:flutter_car_live/utils/navigator_utils.dart';
import 'package:flutter_car_live/utils/toast_utils.dart';
import 'package:flutter_car_live/widgets/common_btn/common_btn.dart';
import 'package:provider/provider.dart';

/// @Author: Tiancong
/// @Date: 2021-12-01 09:21:00
/// @Description: 卡片核验页面

class CheckIndex extends StatefulWidget {
  final pageTitle;
  final pageFlag; // check卡片核验,unbind为卡片解绑
  CheckIndex({Key? key, String? this.pageTitle, String? this.pageFlag})
      : super(key: key);
  @override
  _CheckIndexState createState() => _CheckIndexState();
}

class _CheckIndexState extends State<CheckIndex> {
  String? cid;
  List<String>? _permissions;
  // 加载flutter项目工程文件
  AudioCache audioCache = AudioCache(fixedPlayer: AudioPlayer());
  String? localFilePath;
  String? localAudioCacheURI;
  @override
  void initState() {
    eventBus.on('getBnCid', getCid);
    super.initState();
  }

  @override
  void dispose() {
    eventBus.off('getBnCid');
    audioCache.clearAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _permissions = Provider.of<PermissionModel>(context).permissions;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageTitle ?? '卡片核验验'),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 60),
            Image.asset(
              'assets/images/common/scan-photo.png',
              width: 120,
            ),
            SizedBox(height: 25),
            Text(
              '准备扫描',
              style: TextStyle(
                color: Color(0xff10B4F9),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 50),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(color: Color(0xffe0f2ff)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/common/about.png',
                    width: 30,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '请靠近车头对准电子车牌',
                        style: TextStyle(color: Color(0xff10B4F9)),
                      ),
                      Text(
                        '请按扫描键或点击下方按钮',
                        style: TextStyle(color: Color(0xff10B4F9)),
                      )
                    ],
                  )
                ],
              ),
            ),
            // Expanded(
            //   child: Center(
            //     child: CommonBtn(
            //       label: '扫描电子车牌',
            //       height: 56,
            //       ontap: () async {
            //         bool res = await AppMethodChannel.emitReadCid();
            //         LogUtils.e('$res');
            //       },
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  // 手持机扫描电子车牌获取cid
  void getCid(arg) async {
    cid = arg;
    LogUtils.e('cid信息$arg');
    if (cid != null) {
      await audioCache.play('video/tts.mp3');
      // 获取车牌信息
      navigatorPage();
    }
  }

  // 扫描成功跳转相关页面
  void navigatorPage() {
    if (widget.pageFlag == 'check') {
      NavigatorUtils.pushPageByFade(
        context: context,
        targPage: CheckInfo(cid: cid),
        isReplace: true,
      );
      return;
    }
    if (widget.pageFlag == 'unbind') {
      NavigatorUtils.pushPageByFade(
        context: context,
        targPage: UnbindCard(cid: cid),
        isReplace: true,
      );
      return;
    }
    if (widget.pageFlag == 'money') {
      // 如果是加油权限0802000000,则跳转到加油页面
      // 如果是普通商户0803000000(洗车,维修,保养)
      if (_permissions?.contains('0802000000') ?? false) {
        NavigatorUtils.pushPageByFade(
          context: context,
          targPage: AddOilCard(cid: cid),
          isReplace: true,
        );
        return;
      }
      if (_permissions?.contains('0803000000') ?? false) {
        NavigatorUtils.pushPageByFade(
          context: context,
          targPage: MaintSelectCard(cid: cid),
          isReplace: true,
        );
        return;
      }
      ToastUtils.showToast('您暂无访问无权限');
    }
  }
}
