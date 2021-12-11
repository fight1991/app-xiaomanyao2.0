class OrderBean {
  String? tradeOrderNo;
  String? status;
  String? plateNo;
  double? payAmount;
  double? totalAmount;
  String? createdTime;

  ///常用用于解析JSON数据
  OrderBean.fromMap(Map<String, dynamic> map) {
    this.tradeOrderNo = map["tradeOrderNo"];
    this.status = map["status"];
    this.plateNo = map["plateNo"];
    this.payAmount = map["payAmount"];
    this.totalAmount = map["totalAmount"];
    this.createdTime = map["createdTime"];
  }
}
