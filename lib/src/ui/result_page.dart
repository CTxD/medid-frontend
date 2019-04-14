import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medid/src/blocs/result/bloc.dart';
import 'package:medid/src/ui/widgets/pill_list.dart';

class ResultPage extends StatefulWidget {
  final ResultBloc resultBloc;

  final String imageFilePath;

  const ResultPage(
      {Key key, @required this.resultBloc, @required this.imageFilePath})
      : super(key: key);

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
              body: Column(
                children: [
                  Center(
                      child: Text(
                    'Noget gik galt!\n' + state.error.toString(),
                    style: TextStyle(color: Colors.red),
                  )),
                  FlatButton(
                    child: Text('Prøv igen'),
                    onPressed: () => _resultBloc
                        .dispatch(ResultPageLoaded(imageFilePath: state.imageFilePath)),
                  )
                ],
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
    _resultBloc.dispatch(ResultPageLoaded(imageFilePath: widget.imageFilePath));
    super.initState();
  }
}
