import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medid/src/bloc/bloc.dart';
import 'package:medid/src/ui/pill_info_screen.dart';

class PillList extends StatefulWidget {
  final ResultBloc resultBloc;

  PillList({Key key, @required this.resultBloc}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PillListState();
  }
}

class _PillListState extends State<PillList> {
  ResultBloc get _resultBloc => widget.resultBloc;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResultEvent, ResultState>(
        bloc: _resultBloc,
        builder: (BuildContext context, ResultState state) {
          if (state is FoundMatches) {
            return ListView.builder(
                itemCount: state.results?.length,
                itemBuilder: (c, i) {
                  return Card(
                      key: Key(i.toString()),
                      child: ListTile(
                        leading: SizedBox(
                            width: 100,
                            height: 100,
                            child:
                                Image.network(state.results[i].pillImageUrl)),
                        subtitle: Text(state.results[i].activeSubstance),
                        title: Text(state.results[i].title +
                            '  ' +
                            state.results[i].strength),
                        onTap: () {
                          _resultBloc.dispatch(
                              MatchClicked(clickedMr: state.results[i]));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PillInfoPage(
                                    resultBloc: _resultBloc,
                                  ),
                            ),
                          );
                        },
                      ));
                });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
