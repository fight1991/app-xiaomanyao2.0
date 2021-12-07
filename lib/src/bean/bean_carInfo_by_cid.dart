import 'package:json2dart_safe/json2dart.dart';

class EviBean {
  String? bindTime;
  String? boxNo;
  int? createdBy;
  String? createdByName;
  String? createdTime;
  int? eviNo;
  String? eviNoSearch;
  String? insideImage;
  String? orgName;
  String? outsideImage;
  String? status;
  String? unbindReason;
  int? updatedBy;
  String? updatedByName;
  String? updatedTime;
  String? urlEviQrcode;
  int? vehicleId;

  EviBean({
    this.bindTime,
    this.boxNo,
    this.createdBy,
    this.createdByName,
    this.createdTime,
    this.eviNo,
    this.eviNoSearch,
    this.insideImage,
    this.orgName,
    this.outsideImage,
    this.status,
    this.unbindReason,
    this.updatedBy,
    this.updatedByName,
    this.updatedTime,
    this.urlEviQrcode,
    this.vehicleId,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('bindTime', this.bindTime)
      ..put('boxNo', this.boxNo)
      ..put('createdBy', this.createdBy)
      ..put('createdByName', this.createdByName)
      ..put('createdTime', this.createdTime)
      ..put('eviNo', this.eviNo)
      ..put('eviNoSearch', this.eviNoSearch)
      ..put('insideImage', this.insideImage)
      ..put('orgName', this.orgName)
      ..put('outsideImage', this.outsideImage)
      ..put('status', this.status)
      ..put('unbindReason', this.unbindReason)
      ..put('updatedBy', this.updatedBy)
      ..put('updatedByName', this.updatedByName)
      ..put('updatedTime', this.updatedTime)
      ..put('urlEviQrcode', this.urlEviQrcode)
      ..put('vehicleId', this.vehicleId);
  }

  EviBean.fromJson(Map<String, dynamic> json) {
    this.bindTime = json.asString('bindTime');
    this.boxNo = json.asString('boxNo');
    this.createdBy = json.asInt('createdBy');
    this.createdByName = json.asString('createdByName');
    this.createdTime = json.asString('createdTime');
    this.eviNo = json.asInt('eviNo');
    this.eviNoSearch = json.asString('eviNoSearch');
    this.insideImage = json.asString('insideImage');
    this.orgName = json.asString('orgName');
    this.outsideImage = json.asString('outsideImage');
    this.status = json.asString('status');
    this.unbindReason = json.asString('unbindReason');
    this.updatedBy = json.asInt('updatedBy');
    this.updatedByName = json.asString('updatedByName');
    this.updatedTime = json.asString('updatedTime');
    this.urlEviQrcode = json.asString('urlEviQrcode');
    this.vehicleId = json.asInt('vehicleId');
  }

  static EviBean toBean(Map<String, dynamic> json) => EviBean.fromJson(json);
}

class VehicleBean {
  int? createdBy;
  String? createdByName;
  String? createdTime;
  String? plateColor;
  String? plateNo;
  int? updatedBy;
  String? updatedByName;
  String? updatedTime;
  int? vehicleId;

  VehicleBean({
    this.createdBy,
    this.createdByName,
    this.createdTime,
    this.plateColor,
    this.plateNo,
    this.updatedBy,
    this.updatedByName,
    this.updatedTime,
    this.vehicleId,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('createdBy', this.createdBy)
      ..put('createdByName', this.createdByName)
      ..put('createdTime', this.createdTime)
      ..put('plateColor', this.plateColor)
      ..put('plateNo', this.plateNo)
      ..put('updatedBy', this.updatedBy)
      ..put('updatedByName', this.updatedByName)
      ..put('updatedTime', this.updatedTime)
      ..put('vehicleId', this.vehicleId);
  }

  VehicleBean.fromJson(Map<String, dynamic> json) {
    this.createdBy = json.asInt('createdBy');
    this.createdByName = json.asString('createdByName');
    this.createdTime = json.asString('createdTime');
    this.plateColor = json.asString('plateColor');
    this.plateNo = json.asString('plateNo');
    this.updatedBy = json.asInt('updatedBy');
    this.updatedByName = json.asString('updatedByName');
    this.updatedTime = json.asString('updatedTime');
    this.vehicleId = json.asInt('vehicleId');
  }

  static VehicleBean toBean(Map<String, dynamic> json) =>
      VehicleBean.fromJson(json);
}

class VehicleLicenseBean {
  String? allowNum;
  int? createdBy;
  String? createdByName;
  String? createdTime;
  String? curbWeight;
  String? engineNum;
  String? externalSize;
  String? fileNo;
  String? issueDate;
  String? licenseCopyImage;
  String? licenseImage;
  String? loadQuality;
  String? marks;
  String? model;
  String? ownerAddress;
  String? ownerName;
  String? plateColor;
  String? plateNo;
  String? record;
  String? registerDate;
  String? totalMass;
  String? totalQuasiMass;
  int? updatedBy;
  String? updatedByName;
  String? updatedTime;
  String? useCharacter;
  int? vehicleId;
  String? vehicleType;
  String? vin;

  VehicleLicenseBean({
    this.allowNum,
    this.createdBy,
    this.createdByName,
    this.createdTime,
    this.curbWeight,
    this.engineNum,
    this.externalSize,
    this.fileNo,
    this.issueDate,
    this.licenseCopyImage,
    this.licenseImage,
    this.loadQuality,
    this.marks,
    this.model,
    this.ownerAddress,
    this.ownerName,
    this.plateColor,
    this.plateNo,
    this.record,
    this.registerDate,
    this.totalMass,
    this.totalQuasiMass,
    this.updatedBy,
    this.updatedByName,
    this.updatedTime,
    this.useCharacter,
    this.vehicleId,
    this.vehicleType,
    this.vin,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('allowNum', this.allowNum)
      ..put('createdBy', this.createdBy)
      ..put('createdByName', this.createdByName)
      ..put('createdTime', this.createdTime)
      ..put('curbWeight', this.curbWeight)
      ..put('engineNum', this.engineNum)
      ..put('externalSize', this.externalSize)
      ..put('fileNo', this.fileNo)
      ..put('issueDate', this.issueDate)
      ..put('licenseCopyImage', this.licenseCopyImage)
      ..put('licenseImage', this.licenseImage)
      ..put('loadQuality', this.loadQuality)
      ..put('marks', this.marks)
      ..put('model', this.model)
      ..put('ownerAddress', this.ownerAddress)
      ..put('ownerName', this.ownerName)
      ..put('plateColor', this.plateColor)
      ..put('plateNo', this.plateNo)
      ..put('record', this.record)
      ..put('registerDate', this.registerDate)
      ..put('totalMass', this.totalMass)
      ..put('totalQuasiMass', this.totalQuasiMass)
      ..put('updatedBy', this.updatedBy)
      ..put('updatedByName', this.updatedByName)
      ..put('updatedTime', this.updatedTime)
      ..put('useCharacter', this.useCharacter)
      ..put('vehicleId', this.vehicleId)
      ..put('vehicleType', this.vehicleType)
      ..put('vin', this.vin);
  }

  VehicleLicenseBean.fromJson(Map<String, dynamic> json) {
    this.allowNum = json.asString('allowNum');
    this.createdBy = json.asInt('createdBy');
    this.createdByName = json.asString('createdByName');
    this.createdTime = json.asString('createdTime');
    this.curbWeight = json.asString('curbWeight');
    this.engineNum = json.asString('engineNum');
    this.externalSize = json.asString('externalSize');
    this.fileNo = json.asString('fileNo');
    this.issueDate = json.asString('issueDate');
    this.licenseCopyImage = json.asString('licenseCopyImage');
    this.licenseImage = json.asString('licenseImage');
    this.loadQuality = json.asString('loadQuality');
    this.marks = json.asString('marks');
    this.model = json.asString('model');
    this.ownerAddress = json.asString('ownerAddress');
    this.ownerName = json.asString('ownerName');
    this.plateColor = json.asString('plateColor');
    this.plateNo = json.asString('plateNo');
    this.record = json.asString('record');
    this.registerDate = json.asString('registerDate');
    this.totalMass = json.asString('totalMass');
    this.totalQuasiMass = json.asString('totalQuasiMass');
    this.updatedBy = json.asInt('updatedBy');
    this.updatedByName = json.asString('updatedByName');
    this.updatedTime = json.asString('updatedTime');
    this.useCharacter = json.asString('useCharacter');
    this.vehicleId = json.asInt('vehicleId');
    this.vehicleType = json.asString('vehicleType');
    this.vin = json.asString('vin');
  }

  static VehicleLicenseBean toBean(Map<String, dynamic> json) =>
      VehicleLicenseBean.fromJson(json);
}
