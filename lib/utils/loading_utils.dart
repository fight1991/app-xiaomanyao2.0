import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

bool loadingStatus = false;

class LoadingUtils {
  static show() {
    EasyLoading.instance..maskColor = Colors.white;
    EasyLoading.show();
  }

  static dismiss() {
    EasyLoading.dismiss();
  }
}
