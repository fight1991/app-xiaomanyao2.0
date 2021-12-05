import 'package:json2dart_safe/json2dart.dart';

class Permission {
  bool? enable;
  int? maxAge;
  int? maxCount;

  Permission({
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

  Permission.fromJson(Map<String, dynamic> json) {
    this.enable = json.asBool('enable');
    this.maxAge = json.asInt('maxAge');
    this.maxCount = json.asInt('maxCount');
  }

  static Permission toBean(Map<String, dynamic> json) =>
      Permission.fromJson(json);
}
