import 'package:flutter/services.dart';
import 'package:flutter_car_live/common/eventBus.dart';
import 'package:flutter_car_live/utils/log_utils.dart';

import 'constant.dart';

class AppEventChannel {
  static void registerPushEvent() {
    LogUtils.e('注册事件通道');
    EventChannel _eventChannel;
    _eventChannel = EventChannel(Constant.homePageEventChannel);
    _eventChannel.receiveBroadcastStream().listen(_onData, onError: _onError);
  }

  // 接收事件
  static void _onData(data) {
    if (data is Map) {
      String _eventName = data['event'];
      LogUtils.e('native发送事件成功|事件名称$_eventName');
      // 设备扫描电子车牌的事件名称为bn_cid
      if (_eventName == 'bn_cid') {
        //cid => data['cid']
        // 发送事件
        String cid = data['cid'];
        eventBus.emit('getBnCid', cid);
        return;
      }
    }
  }

  // 接收错误
  static void _onError(err) {
    print('native发送事件失败-------------------------');
    print(err);
  }
  // static void doUriEvent(String uriStr) {
  //   if(uriStr==null||uriStr.isEmpty){
  //     return;
  //   }
  //   Uri uri = Uri.parse(uriStr);
  //   print("uri.path = "+uri.path);
  //   if("/pwdlogin"==uri.path){
  //     //跳转密码登录
  //     Global.navigatorKey.currentState.pushNamed(PageName.passwordLogin);
  //   }
  // }
}
