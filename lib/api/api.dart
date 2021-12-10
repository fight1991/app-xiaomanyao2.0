import 'package:flutter_car_live/net/fetch_methods.dart';
import 'package:flutter_car_live/net/http_helper.dart';
import 'package:flutter_car_live/net/response_data.dart';
import 'package:flutter_car_live/src/bean/bean_carInfo_by_cid.dart';

class Api {
  // 获取车牌号信息
  static Future<VehicleBean?> getCarInfo({data}) async {
    ResponseInfo responseInfo =
        await Fetch.post(url: HttpHelper.getPlateNoByElec, data: data);
    if (responseInfo.success) {
      VehicleBean vehicleBean = VehicleBean.fromJson(responseInfo.data);
      return vehicleBean;
    }
    return null;
  }
}
