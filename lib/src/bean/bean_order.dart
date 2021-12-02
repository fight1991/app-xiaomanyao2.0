class OrderBean {
  String? orderNo;
  String? status;
  String? plateNo;
  String? price;
  String? createTime;

  ///常用用于解析JSON数据
  OrderBean.fromMap(Map<String, dynamic> map) {
    this.orderNo = map["demo"];
    this.status = map["demo"];
    this.plateNo = map["demo"];
    this.price = map["demo"];
    this.createTime = map["demo"];
  }
}
