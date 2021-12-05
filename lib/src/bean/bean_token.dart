import 'package:json2dart_safe/json2dart.dart';

class TokenBean {
  String? accessType;
  int? expireTime;
  String? token;

  TokenBean({
    this.accessType,
    this.expireTime,
    this.token,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('accessType', this.accessType)
      ..put('expireTime', this.expireTime)
      ..put('token', this.token);
  }

  TokenBean.fromJson(Map<String, dynamic> json) {
    this.accessType = json.asString('accessType');
    this.expireTime = json.asInt('expireTime');
    this.token = json.asString('token');
  }

  static TokenBean toBean(Map<String, dynamic> json) =>
      TokenBean.fromJson(json);
}
