import 'package:json2dart_safe/json2dart.dart';

class TokenInfo {
  bool? enable;
  int? maxAge;
  int? maxCount;

  TokenInfo({
    this.enable,
    this.maxAge,
    this.maxCount,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('enable', this.enable)
      ..put('maxAge', this.maxAge)
      ..put('maxCount', this.maxCount);
  }

  TokenInfo.fromJson(Map<String, dynamic> json) {
    this.enable = json.asBool('enable');
    this.maxAge = json.asInt('maxAge');
    this.maxCount = json.asInt('maxCount');
  }

  static TokenInfo toBean(Map<String, dynamic> json) =>
      TokenInfo.fromJson(json);
}
