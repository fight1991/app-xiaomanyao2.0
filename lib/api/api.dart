import 'package:flutter_car_live/net/fetch_methods.dart';
import 'package:flutter_car_live/net/http_helper.dart';
import 'package:flutter_car_live/net/response_data.dart';
import 'package:flutter_car_live/src/bean/bean_carInfo_by_cid.dart';

class Api {
  // 发卡场景获取车辆信息
  static Future<VehicleBean?> getCarInfo({data}) async {
    ResponseInfo responseInfo =
        await Fetch.post(url: HttpHelper.getPlateNoByElec, data: data);
    if (responseInfo.success) {
      VehicleBean vehicleBean = VehicleBean.fromJson(responseInfo.data);
      return vehicleBean;
    }
    return null;
  }

  // 加油场景获取车牌号
  static Future<VehicleBean?> getPlateNoByCid({data}) async {
    ResponseInfo responseInfo =
        await Fetch.post(url: HttpHelper.getPlateNoByCid, data: data);
    if (responseInfo.success) {
      VehicleBean vehicleBean = VehicleBean.fromJson(responseInfo.data);
      return vehicleBean;
    }
    return null;
  }
}
