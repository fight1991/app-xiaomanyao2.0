import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ParkingListPage extends StatefulWidget {
  @override
  _ParkingListPage createState() => _ParkingListPage();
}

class _ParkingListPage extends State<ParkingListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('智慧停车'),
      ),
    );
  }
}
