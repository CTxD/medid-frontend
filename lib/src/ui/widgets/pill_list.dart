import 'package:flutter/material.dart';
import 'package:medid/src/models/match_result.dart';

class PillList extends StatelessWidget {
  List<MatchResult> matchResults;

  PillList(this.matchResults) : super();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
          itemCount: matchResults?.length,
          itemBuilder: (c, i) {
            return Card(
                key: Key(i.toString()),
                child: ListTile(
                  leading: SizedBox(width: 100, height: 100, child:Image.network(matchResults[i].pillImageUrl)),
                  subtitle: Text(matchResults[i].activeSubstance),
                  title: Text(matchResults[i].title),
                ));
          });
  }
}