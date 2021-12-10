import 'package:json2dart_safe/json2dart.dart';

class LocationBean {
  bool? success;
  String? message;
  double? longitude;
  double? latitude;

  LocationBean({
    this.success,
    this.message,
    this.longitude,
    this.latitude,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('success', this.success)
      ..put('message', this.message)
      ..put('longitude', this.longitude)
      ..put('latitude', this.latitude);
  }

  LocationBean.fromJson(Map<String, dynamic> json) {
    this.success = json.asBool('success');
    this.message = json.asString('message');
    this.longitude = json.asDouble('longitude');
    this.latitude = json.asDouble('latitude');
  }

  static LocationBean toBean(Map<String, dynamic> json) =>
      LocationBean.fromJson(json);
}
