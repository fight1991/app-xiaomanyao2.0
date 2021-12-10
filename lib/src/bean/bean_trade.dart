import 'package:json2dart_safe/json2dart.dart';

class TradeBean {
  int? billAmount;
  String? bizOrderNo;
  int? cid;
  String? city;
  String? cityCode;
  String? closeDate;
  String? closeReason;
  String? closeRemark;
  int? couponAmount;
  int? createdBy;
  String? createdByName;
  String? createdTime;
  String? deviceNo;
  String? district;
  String? districtCode;
  String? extend;
  ExtendObject? extendObject;
  String? goodsDesc;
  int? goodsNum;
  int? goodsPrice;
  int? goodsSnapshotId;
  String? goodsSummary;
  int? merchantDiscount;
  int? merchantDiscountAmount;
  int? merchantId;
  String? merchantName;
  String? merchantService;
  List<String>? merchantServiceList;
  String? merchantType;
  String? mobile;
  String? name;
  int? operatorId;
  String? operatorName;
  int? payAmount;
  String? payCipher;
  String? payDate;
  String? payErrorCode;
  String? payNo;
  String? payRemark;
  String? payStatus;
  String? payType;
  String? plateColor;
  String? plateNo;
  int? platformDiscount;
  int? platformDiscountAmount;
  String? projectId;
  String? province;
  String? provinceCode;
  String? remark;
  String? status;
  int? totalAmount;
  List<String>? tradeNoList;
  String? tradeOrderNo;
  String? tradeType;
  int? uid;
  int? updatedBy;
  String? updatedByName;
  String? updatedTime;

  TradeBean({
    this.billAmount,
    this.bizOrderNo,
    this.cid,
    this.city,
    this.cityCode,
    this.closeDate,
    this.closeReason,
    this.closeRemark,
    this.couponAmount,
    this.createdBy,
    this.createdByName,
    this.createdTime,
    this.deviceNo,
    this.district,
    this.districtCode,
    this.extend,
    this.extendObject,
    this.goodsDesc,
    this.goodsNum,
    this.goodsPrice,
    this.goodsSnapshotId,
    this.goodsSummary,
    this.merchantDiscount,
    this.merchantDiscountAmount,
    this.merchantId,
    this.merchantName,
    this.merchantService,
    this.merchantServiceList,
    this.merchantType,
    this.mobile,
    this.name,
    this.operatorId,
    this.operatorName,
    this.payAmount,
    this.payCipher,
    this.payDate,
    this.payErrorCode,
    this.payNo,
    this.payRemark,
    this.payStatus,
    this.payType,
    this.plateColor,
    this.plateNo,
    this.platformDiscount,
    this.platformDiscountAmount,
    this.projectId,
    this.province,
    this.provinceCode,
    this.remark,
    this.status,
    this.totalAmount,
    this.tradeNoList,
    this.tradeOrderNo,
    this.tradeType,
    this.uid,
    this.updatedBy,
    this.updatedByName,
    this.updatedTime,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('billAmount', this.billAmount)
      ..put('bizOrderNo', this.bizOrderNo)
      ..put('cid', this.cid)
      ..put('city', this.city)
      ..put('cityCode', this.cityCode)
      ..put('closeDate', this.closeDate)
      ..put('closeReason', this.closeReason)
      ..put('closeRemark', this.closeRemark)
      ..put('couponAmount', this.couponAmount)
      ..put('createdBy', this.createdBy)
      ..put('createdByName', this.createdByName)
      ..put('createdTime', this.createdTime)
      ..put('deviceNo', this.deviceNo)
      ..put('district', this.district)
      ..put('districtCode', this.districtCode)
      ..put('extend', this.extend)
      ..put('extendObject', this.extendObject?.toJson())
      ..put('goodsDesc', this.goodsDesc)
      ..put('goodsNum', this.goodsNum)
      ..put('goodsPrice', this.goodsPrice)
      ..put('goodsSnapshotId', this.goodsSnapshotId)
      ..put('goodsSummary', this.goodsSummary)
      ..put('merchantDiscount', this.merchantDiscount)
      ..put('merchantDiscountAmount', this.merchantDiscountAmount)
      ..put('merchantId', this.merchantId)
      ..put('merchantName', this.merchantName)
      ..put('merchantService', this.merchantService)
      ..put('merchantServiceList', this.merchantServiceList)
      ..put('merchantType', this.merchantType)
      ..put('mobile', this.mobile)
      ..put('name', this.name)
      ..put('operatorId', this.operatorId)
      ..put('operatorName', this.operatorName)
      ..put('payAmount', this.payAmount)
      ..put('payCipher', this.payCipher)
      ..put('payDate', this.payDate)
      ..put('payErrorCode', this.payErrorCode)
      ..put('payNo', this.payNo)
      ..put('payRemark', this.payRemark)
      ..put('payStatus', this.payStatus)
      ..put('payType', this.payType)
      ..put('plateColor', this.plateColor)
      ..put('plateNo', this.plateNo)
      ..put('platformDiscount', this.platformDiscount)
      ..put('platformDiscountAmount', this.platformDiscountAmount)
      ..put('projectId', this.projectId)
      ..put('province', this.province)
      ..put('provinceCode', this.provinceCode)
      ..put('remark', this.remark)
      ..put('status', this.status)
      ..put('totalAmount', this.totalAmount)
      ..put('tradeNoList', this.tradeNoList)
      ..put('tradeOrderNo', this.tradeOrderNo)
      ..put('tradeType', this.tradeType)
      ..put('uid', this.uid)
      ..put('updatedBy', this.updatedBy)
      ..put('updatedByName', this.updatedByName)
      ..put('updatedTime', this.updatedTime);
  }

  TradeBean.fromJson(Map<String, dynamic> json) {
    this.billAmount = json.asInt('billAmount');
    this.bizOrderNo = json.asString('bizOrderNo');
    this.cid = json.asInt('cid');
    this.city = json.asString('city');
    this.cityCode = json.asString('cityCode');
    this.closeDate = json.asString('closeDate');
    this.closeReason = json.asString('closeReason');
    this.closeRemark = json.asString('closeRemark');
    this.couponAmount = json.asInt('couponAmount');
    this.createdBy = json.asInt('createdBy');
    this.createdByName = json.asString('createdByName');
    this.createdTime = json.asString('createdTime');
    this.deviceNo = json.asString('deviceNo');
    this.district = json.asString('district');
    this.districtCode = json.asString('districtCode');
    this.extend = json.asString('extend');
    this.goodsDesc = json.asString('goodsDesc');
    this.goodsNum = json.asInt('goodsNum');
    this.goodsPrice = json.asInt('goodsPrice');
    this.goodsSnapshotId = json.asInt('goodsSnapshotId');
    this.goodsSummary = json.asString('goodsSummary');
    this.merchantDiscount = json.asInt('merchantDiscount');
    this.merchantDiscountAmount = json.asInt('merchantDiscountAmount');
    this.merchantId = json.asInt('merchantId');
    this.merchantName = json.asString('merchantName');
    this.merchantService = json.asString('merchantService');
    this.merchantServiceList = json.asList<String>('merchantServiceList', null);
    this.merchantType = json.asString('merchantType');
    this.mobile = json.asString('mobile');
    this.name = json.asString('name');
    this.operatorId = json.asInt('operatorId');
    this.operatorName = json.asString('operatorName');
    this.payAmount = json.asInt('payAmount');
    this.payCipher = json.asString('payCipher');
    this.payDate = json.asString('payDate');
    this.payErrorCode = json.asString('payErrorCode');
    this.payNo = json.asString('payNo');
    this.payRemark = json.asString('payRemark');
    this.payStatus = json.asString('payStatus');
    this.payType = json.asString('payType');
    this.plateColor = json.asString('plateColor');
    this.plateNo = json.asString('plateNo');
    this.platformDiscount = json.asInt('platformDiscount');
    this.platformDiscountAmount = json.asInt('platformDiscountAmount');
    this.projectId = json.asString('projectId');
    this.province = json.asString('province');
    this.provinceCode = json.asString('provinceCode');
    this.remark = json.asString('remark');
    this.status = json.asString('status');
    this.totalAmount = json.asInt('totalAmount');
    this.tradeNoList = json.asList<String>('tradeNoList', null);
    this.tradeOrderNo = json.asString('tradeOrderNo');
    this.tradeType = json.asString('tradeType');
    this.uid = json.asInt('uid');
    this.updatedBy = json.asInt('updatedBy');
    this.updatedByName = json.asString('updatedByName');
    this.updatedTime = json.asString('updatedTime');
  }

  static TradeBean toBean(Map<String, dynamic> json) =>
      TradeBean.fromJson(json);
}

class AdditionalProp1 {
  Map<String, dynamic> toJson() {
    return Map<String, dynamic>();
  }

  AdditionalProp1.fromJson(Map<String, dynamic> json);
}

class AdditionalProp2 {
  Map<String, dynamic> toJson() {
    return Map<String, dynamic>();
  }

  AdditionalProp2.fromJson(Map<String, dynamic> json);
}

class AdditionalProp3 {
  Map<String, dynamic> toJson() {
    return Map<String, dynamic>();
  }

  AdditionalProp3.fromJson(Map<String, dynamic> json);
}

class ExtendObject {
  AdditionalProp1? additionalProp1;
  AdditionalProp2? additionalProp2;
  AdditionalProp3? additionalProp3;

  ExtendObject({
    this.additionalProp1,
    this.additionalProp2,
    this.additionalProp3,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('additionalProp1', this.additionalProp1?.toJson())
      ..put('additionalProp2', this.additionalProp2?.toJson())
      ..put('additionalProp3', this.additionalProp3?.toJson());
  }
}
