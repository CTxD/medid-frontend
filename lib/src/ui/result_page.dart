import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medid/src/bloc/bloc.dart';
import 'package:medid/src/ui/widgets/pill_list.dart';

class ResultPage extends StatefulWidget {
  final ResultBloc resultBloc;

  const ResultPage({Key key, @required this.resultBloc}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ResultPageState();
  }
}

class _ResultPageState extends State<ResultPage> {
  ResultBloc get _resultBloc => widget.resultBloc;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResultEvent, ResultState>(
        bloc: _resultBloc,
        builder: (BuildContext context, ResultState state) {
          if (state is LoadingMatches) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Identificerer..."),
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is MatchingError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Fejl ved identificering"),
              ),
              body: Center(
                child: Text(
                  'Noget gik galt!',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: Text("Resultat"),
            ),
            body: PillList(resultBloc: _resultBloc),
          );
        });
  }

  void initState() {
    _resultBloc.dispatch(ResultPageLoaded());
    super.initState();
  }
}
