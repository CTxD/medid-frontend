import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medid/src/models/match_result.dart';

class ResultScreen extends StatelessWidget {
  List<MatchResult> matchResults;

  ResultScreen({Key key, this.matchResults}) : super(key: key);
  ResultScreen.fromNothing() {
    matchResults = List.generate(
        10,
        (i) =>
            MatchResult(title: 'Title $i', activeSubstance: 'Description $i'));
  }
  final Widget text = Text("Result");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resultat"),
      ),
      body: ListView.builder(
          itemCount: matchResults?.length,
          itemBuilder: (c, i) {
            return Card(
                key: Key(i.toString()),
                child: ListTile(
                  leading: SizedBox(width: 100, height: 100, child:Image.network(matchResults[i].pillImageUrl)),
                  subtitle: Text(matchResults[i].activeSubstance),
                  title: Text(matchResults[i].title),
                ));
          }),
    );
  }
}
