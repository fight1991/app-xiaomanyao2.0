class AppVersionBean {
  String? appName;
  String? appOs;
  String? buildNum;
  String? createdBy;
  String? createdByName;
  String? createdTime;
  String? description;
  String? downloadUrl;
  String? frequencyUnit;
  String? id;
  String? packageMd5;
  String? publishDate;
  String? publishScope;
  int? remindFrequency;
  bool? requireInstall;
  String? status;
  String? title;
  String? updatedBy;
  String? updatedByName;
  String? updatedTime;
  String? version;

  AppVersionBean(
      {this.appName,
      this.appOs,
      this.buildNum,
      this.createdBy,
      this.createdByName,
      this.createdTime,
      this.description,
      this.downloadUrl,
      this.frequencyUnit,
      this.id,
      this.packageMd5,
      this.publishDate,
      this.publishScope,
      this.remindFrequency,
      this.requireInstall,
      this.status,
      this.title,
      this.updatedBy,
      this.updatedByName,
      this.updatedTime,
      this.version});

  AppVersionBean.fromJson(Map<String, dynamic> json) {
    appName = json['appName'];
    appOs = json['appOs'];
    buildNum = json['buildNum'];
    createdBy = json['createdBy'];
    createdByName = json['createdByName'];
    createdTime = json['createdTime'];
    description = json['description'];
    downloadUrl = json['downloadUrl'];
    frequencyUnit = json['frequencyUnit'];
    id = json['id'];
    packageMd5 = json['packageMd5'];
    publishDate = json['publishDate'];
    publishScope = json['publishScope'];
    remindFrequency = json['remindFrequency'];
    requireInstall = json['requireInstall'];
    status = json['status'];
    title = json['title'];
    updatedBy = json['updatedBy'];
    updatedByName = json['updatedByName'];
    updatedTime = json['updatedTime'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appName'] = this.appName;
    data['appOs'] = this.appOs;
    data['buildNum'] = this.buildNum;
    data['createdBy'] = this.createdBy;
    data['createdByName'] = this.createdByName;
    data['createdTime'] = this.createdTime;
    data['description'] = this.description;
    data['downloadUrl'] = this.downloadUrl;
    data['frequencyUnit'] = this.frequencyUnit;
    data['id'] = this.id;
    data['packageMd5'] = this.packageMd5;
    data['publishDate'] = this.publishDate;
    data['publishScope'] = this.publishScope;
    data['remindFrequency'] = this.remindFrequency;
    data['requireInstall'] = this.requireInstall;
    data['status'] = this.status;
    data['title'] = this.title;
    data['updatedBy'] = this.updatedBy;
    data['updatedByName'] = this.updatedByName;
    data['updatedTime'] = this.updatedTime;
    data['version'] = this.version;
    return data;
  }
}
