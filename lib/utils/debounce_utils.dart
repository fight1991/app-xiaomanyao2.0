// debounce.dart

import 'dart:async';

/// 函数防抖
///
/// [func]: 要执行的方法
/// [delay]: 要迟延的时长(毫秒)
Function debounce(
  Function func, [
  Duration delay = const Duration(milliseconds: 300),
]) {
  Timer? timer;
  Function target = () {
    if (timer?.isActive ?? false) {
      timer?.cancel();
    }
    timer = Timer(delay, () {
      func.call();
    });
  };
  return target;
}
