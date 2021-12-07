import 'package:dio/dio.dart';
import 'package:flutter_car_live/net/dio_utils.dart';
import 'package:flutter_car_live/net/response_data.dart';

class Fetch {
  // 一般post请求
  static Future<ResponseInfo> post(
      {required String url,
      dynamic data,
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
}
