import 'package:flutter/foundation.dart';
import 'package:flutter_car_live/src/bean/bean_location.dart';

class LocationModel extends ChangeNotifier {
  LocationBean? _locationBean;
  LocationBean get locationInfo => _locationBean!;
  set locationInfo(LocationBean location) {
    _locationBean = location;
    notifyListeners();
  }
}
