import 'package:json2dart_safe/json2dart.dart';

class TradeBean {
  int? deleted;
  int? revision;
  int? createdBy;
  String? createdByName;
  String? createdTime;
  String? updatedBy;
  String? updatedByName;
  String? updatedTime;
  String? id;
  String? tradeOrderNo;
  String? tradeNoList;
  String? tradeType;
  String? bizOrderNo;
  String? status;
  String? goodsSummary;
  String? goodsDesc;
  int? goodsNum;
  double? goodsPrice;
  String? goodsSnapshotId;
  String? payType;
  String? payStatus;
  String? payRemark;
  int? payCipher;
  String? payDate;
  String? payErrorCode;
  String? uid;
  String? name;
  String? mobile;
  String? cid;
  String? plateColor;
  String? plateNo;
  String? deviceNo;
  String? provinceCode;
  String? province;
  String? cityCode;
  String? city;
  String? districtCode;
  String? district;
  String? merchantId;
  String? merchantName;
  String? merchantType;
  String? merchantService;
  String? merchantServiceList;
  String? operatorId;
  String? operatorName;
  String? remark;
  double? totalAmount;
  double? payAmount;
  double? billAmount;
  double? couponAmount;
  double? platformDiscount;
  double? platformDiscountAmount;
  double? merchantDiscount;
  String? merchantDiscountAmount;
  String? closeDate;
  String? closeReason;
  String? closeRemark;
  String? extend;
  ExtendObject? extendObject;
  String? projectId;
  String? payNo;
  String? refundOrder;
  String? payExt;
  String? couponReceiveExt;
  String? password;

  TradeBean({
    this.deleted,
    this.revision,
    this.createdBy,
    this.createdByName,
    this.createdTime,
    this.updatedBy,
    this.updatedByName,
    this.updatedTime,
    this.id,
    this.tradeOrderNo,
    this.tradeNoList,
    this.tradeType,
    this.bizOrderNo,
    this.status,
    this.goodsSummary,
    this.goodsDesc,
    this.goodsNum,
    this.goodsPrice,
    this.goodsSnapshotId,
    this.payType,
    this.payStatus,
    this.payRemark,
    this.payCipher,
    this.payDate,
    this.payErrorCode,
    this.uid,
    this.name,
    this.mobile,
    this.cid,
    this.plateColor,
    this.plateNo,
    this.deviceNo,
    this.provinceCode,
    this.province,
    this.cityCode,
    this.city,
    this.districtCode,
    this.district,
    this.merchantId,
    this.merchantName,
    this.merchantType,
    this.merchantService,
    this.merchantServiceList,
    this.operatorId,
    this.operatorName,
    this.remark,
    this.totalAmount,
    this.payAmount,
    this.billAmount,
    this.couponAmount,
    this.platformDiscount,
    this.platformDiscountAmount,
    this.merchantDiscount,
    this.merchantDiscountAmount,
    this.closeDate,
    this.closeReason,
    this.closeRemark,
    this.extend,
    this.extendObject,
    this.projectId,
    this.payNo,
    this.refundOrder,
    this.payExt,
    this.couponReceiveExt,
    this.password,
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
      ..put('tradeOrderNo', this.tradeOrderNo)
      ..put('tradeNoList', this.tradeNoList)
      ..put('tradeType', this.tradeType)
      ..put('bizOrderNo', this.bizOrderNo)
      ..put('status', this.status)
      ..put('goodsSummary', this.goodsSummary)
      ..put('goodsDesc', this.goodsDesc)
      ..put('goodsNum', this.goodsNum)
      ..put('goodsPrice', this.goodsPrice)
      ..put('goodsSnapshotId', this.goodsSnapshotId)
      ..put('payType', this.payType)
      ..put('payStatus', this.payStatus)
      ..put('payRemark', this.payRemark)
      ..put('payCipher', this.payCipher)
      ..put('payDate', this.payDate)
      ..put('payErrorCode', this.payErrorCode)
      ..put('uid', this.uid)
      ..put('name', this.name)
      ..put('mobile', this.mobile)
      ..put('cid', this.cid)
      ..put('plateColor', this.plateColor)
      ..put('plateNo', this.plateNo)
      ..put('deviceNo', this.deviceNo)
      ..put('provinceCode', this.provinceCode)
      ..put('province', this.province)
      ..put('cityCode', this.cityCode)
      ..put('city', this.city)
      ..put('districtCode', this.districtCode)
      ..put('district', this.district)
      ..put('merchantId', this.merchantId)
      ..put('merchantName', this.merchantName)
      ..put('merchantType', this.merchantType)
      ..put('merchantService', this.merchantService)
      ..put('merchantServiceList', this.merchantServiceList)
      ..put('operatorId', this.operatorId)
      ..put('operatorName', this.operatorName)
      ..put('remark', this.remark)
      ..put('totalAmount', this.totalAmount)
      ..put('payAmount', this.payAmount)
      ..put('billAmount', this.billAmount)
      ..put('couponAmount', this.couponAmount)
      ..put('platformDiscount', this.platformDiscount)
      ..put('platformDiscountAmount', this.platformDiscountAmount)
      ..put('merchantDiscount', this.merchantDiscount)
      ..put('merchantDiscountAmount', this.merchantDiscountAmount)
      ..put('closeDate', this.closeDate)
      ..put('closeReason', this.closeReason)
      ..put('closeRemark', this.closeRemark)
      ..put('extend', this.extend)
      ..put('extendObject', this.extendObject?.toJson())
      ..put('projectId', this.projectId)
      ..put('payNo', this.payNo)
      ..put('refundOrder', this.refundOrder)
      ..put('payExt', this.payExt)
      ..put('couponReceiveExt', this.couponReceiveExt)
      ..put('password', this.password);
  }

  TradeBean.fromJson(Map<String, dynamic> json) {
    this.deleted = json.asInt('deleted');
    this.revision = json.asInt('revision');
    this.createdBy = json.asInt('createdBy');
    this.createdByName = json.asString('createdByName');
    this.createdTime = json.asString('createdTime');
    this.updatedBy = json.asString('updatedBy');
    this.updatedByName = json.asString('updatedByName');
    this.updatedTime = json.asString('updatedTime');
    this.id = json.asString('id');
    this.tradeOrderNo = json.asString('tradeOrderNo');
    this.tradeNoList = json.asString('tradeNoList');
    this.tradeType = json.asString('tradeType');
    this.bizOrderNo = json.asString('bizOrderNo');
    this.status = json.asString('status');
    this.goodsSummary = json.asString('goodsSummary');
    this.goodsDesc = json.asString('goodsDesc');
    this.goodsNum = json.asInt('goodsNum');
    this.goodsPrice = json.asDouble('goodsPrice');
    this.goodsSnapshotId = json.asString('goodsSnapshotId');
    this.payType = json.asString('payType');
    this.payStatus = json.asString('payStatus');
    this.payRemark = json.asString('payRemark');
    this.payCipher = json.asInt('payCipher');
    this.payDate = json.asString('payDate');
    this.payErrorCode = json.asString('payErrorCode');
    this.uid = json.asString('uid');
    this.name = json.asString('name');
    this.mobile = json.asString('mobile');
    this.cid = json.asString('cid');
    this.plateColor = json.asString('plateColor');
    this.plateNo = json.asString('plateNo');
    this.deviceNo = json.asString('deviceNo');
    this.provinceCode = json.asString('provinceCode');
    this.province = json.asString('province');
    this.cityCode = json.asString('cityCode');
    this.city = json.asString('city');
    this.districtCode = json.asString('districtCode');
    this.district = json.asString('district');
    this.merchantId = json.asString('merchantId');
    this.merchantName = json.asString('merchantName');
    this.merchantType = json.asString('merchantType');
    this.merchantService = json.asString('merchantService');
    this.merchantServiceList = json.asString('merchantServiceList');
    this.operatorId = json.asString('operatorId');
    this.operatorName = json.asString('operatorName');
    this.remark = json.asString('remark');
    this.totalAmount = json.asDouble('totalAmount');
    this.payAmount = json.asDouble('payAmount');
    this.billAmount = json.asDouble('billAmount');
    this.couponAmount = json.asDouble('couponAmount');
    this.platformDiscount = json.asDouble('platformDiscount');
    this.platformDiscountAmount = json.asDouble('platformDiscountAmount');
    this.merchantDiscount = json.asDouble('merchantDiscount');
    this.merchantDiscountAmount = json.asString('merchantDiscountAmount');
    this.closeDate = json.asString('closeDate');
    this.closeReason = json.asString('closeReason');
    this.closeRemark = json.asString('closeRemark');
    this.extend = json.asString('extend');
    this.projectId = json.asString('projectId');
    this.payNo = json.asString('payNo');
    this.refundOrder = json.asString('refundOrder');
    this.payExt = json.asString('payExt');
    this.couponReceiveExt = json.asString('couponReceiveExt');
    this.password = json.asString('password');
  }

  static TradeBean toBean(Map<String, dynamic> json) =>
      TradeBean.fromJson(json);
}

class ExtendObject {
  int? liters;
  String? oilType;
  String? oilGunName;

  ExtendObject({
    this.liters,
    this.oilType,
    this.oilGunName,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('liters', this.liters)
      ..put('oilType', this.oilType)
      ..put('oilGunName', this.oilGunName);
  }

  ExtendObject.fromJson(Map<String, dynamic> json) {
    this.liters = json.asInt('liters');
    this.oilType = json.asString('oilType');
    this.oilGunName = json.asString('oilGunName');
  }
}
