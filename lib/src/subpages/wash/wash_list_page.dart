import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WashListPage extends StatefulWidget {
  @override
  _WashListPage createState() => _WashListPage();
}

class _WashListPage extends State<WashListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('洗车美容'),
      ),
    );
  }
}
