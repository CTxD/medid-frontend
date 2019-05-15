import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medid/src/blocs/result/bloc.dart';
import 'package:medid/src/ui/widgets/pill_list.dart';
import 'package:flutter/services.dart' show rootBundle;

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
                title: Text("Identificerer....."),
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is UserSelectImprint) {
            return Scaffold(
                appBar: AppBar(
                  title: Text("Vælg Præg"),
                ),
                body: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                          child: GridView.count(
                              crossAxisCount: 7,
                              children: List.generate(state.imprints.length,
                                  (i) => renderImprint(i: i, state: state)))),
                      RaisedButton(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Genkend'),
                              Icon(Icons.search),
                            ]),
                        onPressed: () {
                          if (state is SelectedImprint) {
                            _resultBloc.dispatch(UserInitRecog(
                                imageFilePath: state.imageFilePath,
                                imprint: state.chosenImprint));
                          }
                        },
                      ),
                    ],
                  ),
                ));
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
                    key: Key('ResultTryAgainButton'),
                    child: Text('Prøv igen'),
                    onPressed: () => _resultBloc.dispatch(
                        ResultPageLoaded(imageFilePath: state.imageFilePath)),
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

  Widget renderImprint({int i, UserSelectImprint state}) {
    final impId = state.imprints.keys.toList()[i];
    final img = state.imprints.values.toList()[i];

    if (state is SelectedImprint && state.imprints.keys.toList()[i] == state.chosenImprint) {
      return new Container(
          decoration: new BoxDecoration(
              border: new Border.all(color: Colors.blueAccent)),
          child: InkResponse(
            highlightShape: BoxShape.rectangle,
            highlightColor: Colors.blue,
            enableFeedback: true,
            child: Image.memory(img),
            onTap: () {
              _resultBloc.dispatch(ChosenImprint(imprint: impId));
            },
          ));
    }
    return InkResponse(
        highlightShape: BoxShape.rectangle,
        highlightColor: Colors.blue,
        enableFeedback: true,
        child: Image.memory(
          img,
        ),
        onTap: () {
          _resultBloc.dispatch(ChosenImprint(imprint: impId));
        });
  }

  void initState() {
    final json = rootBundle.loadString('assets/imprints.json');
    _resultBloc.dispatch(ResultPageLoaded(
        imageFilePath: widget.imageFilePath, imprintsJson: json));
    super.initState();
  }
}
