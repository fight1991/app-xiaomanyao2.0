// import 'package:flutter_car_live/utils/toast_utils.dart';
// import 'package:location/location.dart';

// class LocationUtils {
//   late Location _location;

//   // 工厂模式
//   factory LocationUtils() => _getInstance();

//   static LocationUtils get instance => _getInstance();
//   static LocationUtils? _instance;

//   LocationUtils._internal() {
//     // 初始化
//     _location = new Location();
//   }

//   static LocationUtils _getInstance() {
//     if (_instance == null) {
//       _instance = new LocationUtils._internal();
//     }
//     return _instance!;
//   }

//   Future<LocationData?> get() async {
//     bool _serviceEnabled = await _location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await _location.requestService();
//       if (!_serviceEnabled) {
//         ToastUtils.showToast('请开启位置服务');
//         return null;
//       }
//     }
//     PermissionStatus? _permissionGranted = await _location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await _location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         ToastUtils.showToast('未授权位置权限');
//         return null;
//       }
//     }
//     LocationData _locationData = await _location.getLocation();
//     return _locationData;
//   }
// }
