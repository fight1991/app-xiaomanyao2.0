import 'package:json2dart_safe/json2dart.dart';

class GunBean {
  int? createdBy;
  String? createdByName;
  String? createdTime;
  int? oilGunId;
  String? oilGunName;
  String? oilType;
  int? orgId;
  int? updatedBy;
  String? updatedByName;
  String? updatedTime;

  GunBean({
    this.createdBy,
    this.createdByName,
    this.createdTime,
    this.oilGunId,
    this.oilGunName,
    this.oilType,
    this.orgId,
    this.updatedBy,
    this.updatedByName,
    this.updatedTime,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('createdBy', this.createdBy)
      ..put('createdByName', this.createdByName)
      ..put('createdTime', this.createdTime)
      ..put('oilGunId', this.oilGunId)
      ..put('oilGunName', this.oilGunName)
      ..put('oilType', this.oilType)
      ..put('orgId', this.orgId)
      ..put('updatedBy', this.updatedBy)
      ..put('updatedByName', this.updatedByName)
      ..put('updatedTime', this.updatedTime);
  }

  GunBean.fromJson(Map<String, dynamic> json) {
    this.createdBy = json.asInt('createdBy');
    this.createdByName = json.asString('createdByName');
    this.createdTime = json.asString('createdTime');
    this.oilGunId = json.asInt('oilGunId');
    this.oilGunName = json.asString('oilGunName');
    this.oilType = json.asString('oilType');
    this.orgId = json.asInt('orgId');
    this.updatedBy = json.asInt('updatedBy');
    this.updatedByName = json.asString('updatedByName');
    this.updatedTime = json.asString('updatedTime');
  }

  static GunBean toBean(Map<String, dynamic> json) => GunBean.fromJson(json);
}
