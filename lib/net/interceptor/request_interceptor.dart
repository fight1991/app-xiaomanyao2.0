import 'package:dio/dio.dart';
import 'package:flutter_car_live/common/global.dart';

/*
 * 页面说明：dio 拦截
 * 功能性修改记录：
 */
class RequestInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.data = {"accessType": "android-app", "data": options.data};
    //请求header的配置
    options.headers["token"] = Global.profile.token;
    return handler.next(options);
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  onError(DioError e, ErrorInterceptorHandler handler) {
    return handler.next(e);
  }
}
