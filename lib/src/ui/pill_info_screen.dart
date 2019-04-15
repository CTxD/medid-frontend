import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medid/src/blocs/result/bloc.dart';
import 'package:medid/src/models/match_result.dart';

class PillInfoPage extends StatefulWidget {
  MatchResult pillExtended;

  final ResultBloc resultBloc;
  PillInfoPage({Key key, @required this.resultBloc}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ResultPageState();
  }
}

class _ResultPageState extends State<PillInfoPage> {
  ResultBloc get _resultBloc => widget.resultBloc;
  @override
  Widget build(BuildContext context) {
    // TODO: Implement PillInfoPage w.r.t. ShowPillInfo state and default state
    return BlocBuilder<ResultEvent, ResultState>(
        bloc: _resultBloc,
        builder: (BuildContext context, ResultState state) {
          return Scaffold(
              appBar: AppBar(
                title: Text('Placeholder'),
              ),
              body: Container(
                child: Text('Placeholder child'),
              ));
        });
  }
}
