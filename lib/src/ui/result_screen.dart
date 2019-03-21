import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medid/src/models/match_result.dart';
import 'package:medid/src/ui/widgets/pill_list.dart';

class ResultScreen extends StatelessWidget {
  List<MatchResult> matchResults;

  ResultScreen({Key key, this.matchResults}) : super(key: key);
  ResultScreen.fromNothing() {
    matchResults = List.generate(
        10,
        (i) =>
            MatchResult(title: 'Title $i', activeSubstance: 'Description $i'));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resultat"),
      ),
      body: PillList(matchResults),
    );
  }
}
