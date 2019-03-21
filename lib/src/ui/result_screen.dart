import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medid/src/models/match_result.dart';
import 'package:medid/src/ui/widgets/pill_list.dart';

class ResultScreen extends StatelessWidget {
  List<MatchResult> matchResults;

  ResultScreen({Key key, this.matchResults}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resultat"),
      ),
      body: matchResults != null ? PillList(matchResults: matchResults) : PillList.fromNothing(),
    );
  }
}
