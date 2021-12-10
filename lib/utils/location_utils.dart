import 'package:flutter_car_live/utils/toast_utils.dart';
import 'package:location/location.dart';

class LocationUtils {
  Location location = new Location();
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;
  Future<LocationData?> get() async {
    bool _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        ToastUtils.showToast('请开启位置服务');
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        ToastUtils.showToast('未授权位置权限');
        return null;
      }
    }
    _locationData = await location.getLocation();
    return _locationData;
  }
}
