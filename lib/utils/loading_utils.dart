// import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class LoadingUtils {
  static show({String? msg = '正在加载...'}) {
    SmartDialog.showLoading(msg: msg);
  }

  static dismiss() {
    SmartDialog.dismiss();
  }
}
