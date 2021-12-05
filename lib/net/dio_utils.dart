import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_car_live/common/global.dart';
import 'package:flutter_car_live/net/status_code.dart';
import 'package:flutter_car_live/routes/router_key.dart';
import 'package:flutter_car_live/utils/loading_utils.dart';
import 'package:flutter_car_live/utils/toast_utils.dart';
import 'package:package_info/package_info.dart';

import 'log_interceptor.dart';
export 'http_helper.dart';

///代码清单
class DioUtils {
  late Dio _dio;

  // 工厂模式
  factory DioUtils() => _getInstance();

  static DioUtils get instance => _getInstance();
  static DioUtils? _instance;

  //配置代理标识 false 不配置
  bool isProxy = false;

  //网络代理地址
  String proxyIp = "192.168.1.20";

  //网络代理端口
  String proxyPort = "8888";

  DioUtils._internal() {
    BaseOptions options = new BaseOptions();
    //请求时间
    options.connectTimeout = 20000;
    options.receiveTimeout = 2 * 60 * 1000;
    options.sendTimeout = 2 * 60 * 1000;
    // 初始化
    _dio = new Dio(options);
    //当App运行在Release环境时，inProduction为true；
    // 当App运行在Debug和Profile环境时，inProduction为false。
    bool inProduction = bool.fromEnvironment("dart.vm.product");
    if (!inProduction) {
      debugFunction();
    }
  }

  static DioUtils _getInstance() {
    if (_instance == null) {
      _instance = new DioUtils._internal();
    }
    return _instance!;
  }

  void debugFunction() {
    // 添加log
    _dio.interceptors.add(LogsInterceptors());
    //配置代理
    if (isProxy) {
      _setupPROXY();
    }
  }

  /// 配置代理
  void _setupPROXY() {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.findProxy = (uri) {
        //proxyIp 地址  proxyPort 端口
        return 'PROXY $proxyIp : $proxyPort';
      };
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        //忽略证书
        return true;
      };
    };
  }

  /// get 请求
  ///[url]请求链接
  ///[queryParameters]请求参数
  ///[cancelTag] 取消网络请求的标识
  Future<ResponseInfo> getRequest({
    required String url,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelTag,
  }) async {
    //发起get请求
    try {
      _dio.options = await buildOptions(_dio.options);
      _dio.options.headers["content-type"] = "application/json";
      Response response = await _dio.get(url,
          queryParameters: queryParameters, cancelToken: cancelTag);
      //响应数据
      dynamic responseData = response.data;
      //数据解析
      if (responseData is Map<String, dynamic>) {
        //转换
        Map<String, dynamic> responseMap = responseData;
        String code = responseMap["code"];
        String message = responseMap["message"];
        dynamic data = responseMap["data"];
        // 正常
        if (code == StatusCode.success) {
          return ResponseInfo(data: data);
        }
        ToastUtils.showToast(message);
        // 业务报错
        if (code == StatusCode.other) {
          return ResponseInfo(data: data);
        }
        // token失效、异常
        if (code == StatusCode.tokenValid) {
          RouterKey.navigatorKey.currentState
              ?.pushNamedAndRemoveUntil('/login', ModalRoute.withName('/'));
          return ResponseInfo(data: data);
        }
        // 系统异常 9999
        return ResponseInfo.error(
            code: responseMap["code"], message: responseMap["message"]);
      }
      return ResponseInfo.error(code: '未知', message: "数据格式无法识别");
    } catch (e, s) {
      //异常
      return errorController(e, s);
    }
  }

  /// post 请求
  ///[url]请求链接
  ///[formDataMap]formData 请求参数
  ///[jsonMap] JSON 格式
  Future<ResponseInfo> postRequest({
    required String url,
    bool withLoading = true,
    Map<String, dynamic>? formDataMap,
    Map<String, dynamic>? jsonMap,
    CancelToken? cancelTag,
  }) async {
    FormData? form;
    if (formDataMap != null) {
      form = FormData.fromMap(formDataMap);
    }
    try {
      if (withLoading) {
        LoadingUtils.show();
      }
      _dio.options = await buildOptions(_dio.options);
      // _dio.options.headers["content-type"]="multipart/form-data";
      //发起post请求
      Response response = await _dio.post(url,
          data: form == null ? jsonMap : form, cancelToken: cancelTag);
      if (withLoading) {
        LoadingUtils.show();
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
          return ResponseInfo(data: data);
        }
        // 系统异常 9999
        return ResponseInfo.error(
            code: responseMap["code"], message: responseMap["message"]);
      }
      return ResponseInfo.error(code: '未知', message: "数据格式无法识别");
    } catch (e, s) {
      if (withLoading) {
        LoadingUtils.show();
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
    options.headers["productId"] = Platform.isAndroid ? "Android" : "IOS";
    options.headers["application"] = "xiaomanyao";
    options.headers["token"] = Global.profile.token;
    //获取当前App的版本信息
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    options.headers["appVersion"] = "$version";

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
