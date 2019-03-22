import 'package:flutter/material.dart';
import 'package:medid/src/models/match_result.dart';

class PillInfoScreen extends StatelessWidget {
  MatchResult pillExtended;


  PillInfoScreen({Key key, this.pillExtended}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('HEJ CHRISTIAN'),
    );
  }
}