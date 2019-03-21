import 'package:flutter/material.dart';
import 'package:medid/src/models/pill_extended.dart';

class PillInfoScreen extends StatelessWidget {
  PillExtended pillExtended;


  PillInfoScreen({Key key, this.pillExtended}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('HEJ CHRISTIAN'),
    );
  }
}