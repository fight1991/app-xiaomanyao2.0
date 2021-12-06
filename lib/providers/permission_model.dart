import 'package:flutter/foundation.dart';

class PermissionModel extends ChangeNotifier {
  List<String> _permissions = [];
  List<String> get permissions => _permissions;
  set permissions(List<String> list) {
    _permissions = list;
    notifyListeners();
  }
}
