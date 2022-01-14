import 'package:json2dart_safe/json2dart.dart';

class LocationBean {
  int? errorCode;
  String? errorInfo;
  double? longitude;
  double? latitude;
  String? country;
  String? province;
  String? city;
  String? district;
  String? street;
  String? address;

  LocationBean({
    this.errorCode,
    this.errorInfo,
    this.longitude,
    this.latitude,
    this.country,
    this.province,
    this.city,
    this.district,
    this.street,
    this.address,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('errorCode', this.latitude)
      ..put('errorInfo', this.latitude)
      ..put('country', this.latitude)
      ..put('province', this.latitude)
      ..put('city', this.latitude)
      ..put('district', this.latitude)
      ..put('street', this.latitude)
      ..put('address', this.longitude);
  }

  LocationBean.fromJson(Map<String, dynamic> json) {
    this.errorCode = json.asInt('errorCode');
    this.errorInfo = json.asString('errorInfo');
    this.country = json.asString('country');
    this.province = json.asString('province');
    this.city = json.asString('city');
    this.district = json.asString('district');
    this.street = json.asString('street');
    this.address = json.asString('address');
    this.longitude = json.asDouble('longitude');
    this.latitude = json.asDouble('latitude');
  }

  static LocationBean toBean(Map<String, dynamic> json) =>
      LocationBean.fromJson(json);
}
