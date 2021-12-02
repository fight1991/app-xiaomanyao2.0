import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// @Author: Tiancong
/// @Date: 2021-12-02 10:19:52
/// @Description: 无

class UnbindCard extends StatefulWidget {
  final cid;
  UnbindCard({Key? key, String? this.cid}) : super(key: key);
  @override
  _UnbindCardState createState() => _UnbindCardState();
}

class _UnbindCardState extends State<UnbindCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('解绑确认'),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
