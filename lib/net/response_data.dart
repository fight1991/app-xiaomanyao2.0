import 'package:flutter_car_live/net/status_code.dart';

class ResponseInfo {
  bool success;
  String code;
  String? message;
  dynamic data;
  dynamic page;
  ResponseInfo.success({
    this.success = true,
    this.code = StatusCode.success,
    this.data,
    this.message = "请求成功",
  });
  ResponseInfo.error({
    this.success = false,
    this.data,
    this.code = StatusCode.error,
    this.message,
  });
  ResponseInfo.other({
    this.success = false,
    this.data,
    this.code = StatusCode.other,
    this.message,
  });
  ResponseInfo.tokenInvalid({
    this.success = false,
    this.data,
    this.code = StatusCode.tokenInValid,
    this.message,
  });
}