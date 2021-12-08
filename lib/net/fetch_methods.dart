import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_car_live/net/dio_utils.dart';
import 'package:flutter_car_live/net/response_data.dart';
import 'package:flutter_car_live/stream/loading_stream.dart';
import 'package:flutter_car_live/utils/loading_utils.dart';
import 'package:flutter_car_live/utils/log_utils.dart';

/// 一般post请求
/// [url]请求地址
/// [data]入参
/// [widthLoading]是否添加loading
/// [showToast]非0000是否弹框
/// 文件上传
/// [uploadProgress]监听上传进度
class Fetch {
  // 一般post请求
  static Future<ResponseInfo> post(
      {required String url,
      dynamic data,
      bool? showToast,
      Map<String, int>? page,
      bool withLoading = true}) {
    return DioUtils.instance.postRequest(
      url: url,
      data: data,
      page: page,
      withLoading: withLoading,
    );
  }

  // 文件上传请求
  static Future<ResponseInfo> upload({
    required String url,
    bool withLoading = true,
    bool? showToast,
    FormData? data,
    Function(int, int)? uploadProgress,
  }) {
    return DioUtils.instance.postRequest(
      url: url,
      formData: data,
      onSendProgress: uploadProgress,
      withLoading: withLoading,
    );
  }

  // 批量请求
  static Future<bool> all<T>(Iterable<Future<T>> futures) async {
    try {
      LogUtils.e('开始22222222222oooooooooooooooo');
      LoadingUtils.show();
      await Future.wait(futures).then((value) {
        return true;
      }).catchError((err) {
        return false;
      });
      LogUtils.e('开始33333333333oooooooooooooooo');
      LoadingUtils.dismiss();
      return true;
    } catch (err) {
      LoadingUtils.dismiss();
      return false;
    }
  }
}
