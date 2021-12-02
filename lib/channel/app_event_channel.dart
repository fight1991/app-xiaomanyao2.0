import 'package:flutter/services.dart';

import 'constant.dart';

class AppEventChannel {
  static void registerPushEvent() {
    print("registerPushEvent");
    EventChannel _eventChannel;
    _eventChannel = EventChannel(Constant.homePageEventChannel);
    _eventChannel.receiveBroadcastStream().listen((event) {
      if (event is Map) {
        String eName = event["event"];
        print("======eventChannel==>$eName");
      }
    });
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
