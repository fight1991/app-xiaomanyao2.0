import 'package:json2dart_safe/json2dart.dart';

class PageBean {
  int? pageNum;
  int? pageIndex;
  int? pageSize;
  int? total;

  PageBean({
    this.pageNum,
    this.pageIndex,
    this.pageSize,
    this.total,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('pageNum', this.pageNum)
      ..put('pageIndex', this.pageIndex)
      ..put('pageSize', this.pageSize)
      ..put('total', this.total);
  }

  PageBean.fromJson(Map<String, dynamic> json) {
    this.pageNum = json.asInt('pageNum');
    this.pageIndex = json.asInt('pageIndex');
    this.pageSize = json.asInt('pageSize');
    this.total = json.asInt('total');
  }

  static PageBean toBean(Map<String, dynamic> json) => PageBean.fromJson(json);
}
