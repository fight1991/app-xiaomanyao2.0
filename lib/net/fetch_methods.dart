import 'package:flutter_car_live/net/dio_utils.dart';
import 'package:flutter_car_live/net/response_data.dart';

class Fetch {
  static Future<ResponseInfo> post(
      {required String url,
      Map<String, dynamic>? data,
      Map<String, int>? page}) {
    return DioUtils.instance.postRequest(url: url, data: data, page: page);
  }
}
