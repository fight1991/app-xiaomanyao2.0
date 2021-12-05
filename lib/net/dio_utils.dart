import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_car_live/common/global.dart';
import 'package:flutter_car_live/net/status_code.dart';
import 'package:flutter_car_live/routes/router_key.dart';
import 'package:flutter_car_live/utils/loading_utils.dart';
import 'package:package_info/package_info.dart';

import 'interceptor/log_interceptor.dart';
import 'interceptor/request_interceptor.dart';
export 'http_helper.dart';

///代码清单
class DioUtils {
  late Dio _dio;

  // 工厂模式
  factory DioUtils() => _getInstance();

  static DioUtils get instance => _getInstance();
  static DioUtils? _instance;

  DioUtils._internal() {
    // 基本配置参数
    BaseOptions options = new BaseOptions();
    // 初始化
    _dio = new Dio(options);
    // 添加请求拦截器
    _dio.interceptors.add(RequestInterceptors());
    // 添加日志拦截器；
    bool inProduction = bool.fromEnvironment("dart.vm.product");
    if (!inProduction) {
      _dio.interceptors.add(LogsInterceptors());
    }
  }

  static DioUtils _getInstance() {
    if (_instance == null) {
      _instance = new DioUtils._internal();
    }
    return _instance!;
  }

  /// post 请求
  ///[url]请求链接
  ///[formDataMap]formData 请求参数
  ///[jsonMap] JSON 格式
  Future<ResponseInfo> postRequest({
    required String url,
    bool withLoading = true,
    Map<String, dynamic>? data,
    CancelToken? cancelTag,
  }) async {
    try {
      if (withLoading) {
        LoadingUtils.show();
      }
      _dio.options = await buildOptions(_dio.options);
      //发起post请求
      Response response =
          await _dio.post(url, data: data, cancelToken: cancelTag);
      if (withLoading) {
        LoadingUtils.dismiss();
      }
      //响应数据
      dynamic responseData = response.data;
      //数据解析
      if (responseData is Map<String, dynamic>) {
        //转换
        Map<String, dynamic> responseMap = responseData;
        String code = responseMap["code"];
        dynamic data = responseMap["data"];
        // 正常
        if (code == StatusCode.success) {
          return ResponseInfo(data: data);
        }
        // 业务报错
        if (code == StatusCode.other) {
          return ResponseInfo(data: data);
        }
        // token失效、异常
        if (code == StatusCode.tokenValid) {
          // RouterKey.navigatorKey.currentState
          //     ?.pushNamedAndRemoveUntil('/login', ModalRoute.withName('/'));
          return ResponseInfo(data: data);
        }
        // 系统异常 9999
        return ResponseInfo.error(
          code: responseMap["code"],
          message: responseMap["message"],
        );
      }
      return ResponseInfo.error(code: '未知', message: "数据格式无法识别");
    } catch (e, s) {
      if (withLoading) {
        LoadingUtils.dismiss();
      }
      //异常
      return errorController(e, s);
    }
  }

  Future<ResponseInfo> errorController(e, StackTrace s) {
    ResponseInfo responseInfo = ResponseInfo();
    responseInfo.success = false;

    //网络处理错误
    if (e is DioError) {
      DioError dioError = e;
      switch (dioError.type) {
        case DioErrorType.connectTimeout:
          responseInfo.message = "连接超时";
          break;
        case DioErrorType.sendTimeout:
          responseInfo.message = "请求超时";
          break;
        case DioErrorType.receiveTimeout:
          responseInfo.message = "响应超时";
          break;
        case DioErrorType.response:
          // 响应错误
          responseInfo.message = "响应错误";
          break;
        case DioErrorType.cancel:
          // 取消操作
          responseInfo.message = "已取消";
          break;
        case DioErrorType.other:
          // 默认自定义其他异常
          responseInfo.message = "网络请求异常";
          break;
      }
    } else {
      //其他错误
      responseInfo.message = "未知错误";
    }
    responseInfo.success = false;
    return Future.value(responseInfo);
  }

  Future<BaseOptions> buildOptions(BaseOptions options) async {
    ///请求header的配置
    options.headers["token"] = Global.profile.token;
    //获取当前App的版本信息
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    options.headers["appVersion"] = "$version";
    //请求时间
    options.connectTimeout = 20000;
    options.receiveTimeout = 15 * 1000;
    options.sendTimeout = 15 * 1000;
    return Future.value(options);
  }
}

class ResponseInfo {
  bool success;
  String code;
  String? message;
  dynamic data;
  dynamic page;
  ResponseInfo(
      {this.success = true,
      this.code = StatusCode.success,
      this.data,
      this.message = "请求成功"});
  ResponseInfo.error(
      {this.success = false,
      this.code = StatusCode.error,
      this.message = "系统异常"});
  ResponseInfo.other(
      {this.success = false, this.code = StatusCode.other, this.message});
  ResponseInfo.tokenInvalid(
      {this.success = false, this.code = StatusCode.tokenValid, this.message});
}
