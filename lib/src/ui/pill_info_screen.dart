import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medid/src/bloc/bloc.dart';
import 'package:medid/src/bloc/result_bloc.dart';
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
    return BlocBuilder<ResultEvent, ResultState>(
        bloc: _resultBloc,
        builder: (BuildContext context, ResultState state) {
          if (state is ShowPillInfo) {
            return Scaffold(
                appBar: AppBar(
                  title: Text(state.pillInfo.title),
                ),
                body: Container(
                  child: Text('HEJ CHRISTIAN'),
                ));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
