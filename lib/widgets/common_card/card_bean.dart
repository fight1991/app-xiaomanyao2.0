class CardBean {
  // 商户名
  String? title;

  //地址
  String? subTitle;

  // 新价格
  String? newPrice;

  // 原价格
  String? oldPrice;

  // 服务项
  List? serveType;

  ///常用用于解析JSON数据
  CardBean.fromMap(Map<String, dynamic> map) {
    this.title = map["title"];
    this.subTitle = map["address"];
    this.newPrice = map["newPrice"];
    this.oldPrice = map["oldPrice"];
    this.serveType = map["serveType"];
  }
}
