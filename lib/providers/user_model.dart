import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_live/common/global.dart';
import 'package:flutter_car_live/models/profile.dart';
import 'package:flutter_car_live/models/user.dart';

class ProfileChangeNotifier extends ChangeNotifier {
  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile(); //保存Profile变更
    super.notifyListeners(); //通知依赖的Widget更新
  }
}

class UserModel extends ProfileChangeNotifier {
  User get user => _profile.user!;

  //用户信息发生变化，更新用户信息并通知依赖它的子孙Widgets更新
  set user(User user) {
    if (user.userId != _profile.user?.userId) {
      _profile.lastLogin = _profile.user?.userId;
      _profile.user = user;
      notifyListeners();
    }
  }
}
