import 'package:json2dart_safe/json2dart.dart';

class AppVersionBean {
  int? deleted;
  int? revision;
  int? createdBy;
  String? createdByName;
  String? createdTime;
  String? updatedBy;
  String? updatedByName;
  String? updatedTime;
  String? id;
  String? appName;
  String? appOs;
  String? version;
  String? buildNum;
  String? downloadUrl;
  String? title;
  String? description;
  String? packageMd5;
  String? remindFrequency;
  bool? requireInstall;
  String? publishDate;
  String? status;
  String? publishScope;
  String? frequencyUnit;

  AppVersionBean({
    this.deleted,
    this.revision,
    this.createdBy,
    this.createdByName,
    this.createdTime,
    this.updatedBy,
    this.updatedByName,
    this.updatedTime,
    this.id,
    this.appName,
    this.appOs,
    this.version,
    this.buildNum,
    this.downloadUrl,
    this.title,
    this.description,
    this.packageMd5,
    this.remindFrequency,
    this.requireInstall,
    this.publishDate,
    this.status,
    this.publishScope,
    this.frequencyUnit,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('deleted', this.deleted)
      ..put('revision', this.revision)
      ..put('createdBy', this.createdBy)
      ..put('createdByName', this.createdByName)
      ..put('createdTime', this.createdTime)
      ..put('updatedBy', this.updatedBy)
      ..put('updatedByName', this.updatedByName)
      ..put('updatedTime', this.updatedTime)
      ..put('id', this.id)
      ..put('appName', this.appName)
      ..put('appOs', this.appOs)
      ..put('version', this.version)
      ..put('buildNum', this.buildNum)
      ..put('downloadUrl', this.downloadUrl)
      ..put('title', this.title)
      ..put('description', this.description)
      ..put('packageMd5', this.packageMd5)
      ..put('remindFrequency', this.remindFrequency)
      ..put('requireInstall', this.requireInstall)
      ..put('publishDate', this.publishDate)
      ..put('status', this.status)
      ..put('publishScope', this.publishScope)
      ..put('frequencyUnit', this.frequencyUnit);
  }

  AppVersionBean.fromJson(Map<String, dynamic> json) {
    this.deleted = json.asInt('deleted');
    this.revision = json.asInt('revision');
    this.createdBy = json.asInt('createdBy');
    this.createdByName = json.asString('createdByName');
    this.createdTime = json.asString('createdTime');
    this.updatedBy = json.asString('updatedBy');
    this.updatedByName = json.asString('updatedByName');
    this.updatedTime = json.asString('updatedTime');
    this.id = json.asString('id');
    this.appName = json.asString('appName');
    this.appOs = json.asString('appOs');
    this.version = json.asString('version');
    this.buildNum = json.asString('buildNum');
    this.downloadUrl = json.asString('downloadUrl');
    this.title = json.asString('title');
    this.description = json.asString('description');
    this.packageMd5 = json.asString('packageMd5');
    this.remindFrequency = json.asString('remindFrequency');
    this.requireInstall = json.asBool('requireInstall');
    this.publishDate = json.asString('publishDate');
    this.status = json.asString('status');
    this.publishScope = json.asString('publishScope');
    this.frequencyUnit = json.asString('frequencyUnit');
  }

  static AppVersionBean toBean(Map<String, dynamic> json) =>
      AppVersionBean.fromJson(json);
}
