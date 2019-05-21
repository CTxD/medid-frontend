import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medid/src/blocs/result/bloc.dart';
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
            final converter = Base64Decoder();
            List<Uint8List> images = List<Uint8List>();
            state.results.forEach((r) {
              if (r.imgstring != null) {
                Uint8List bytes = converter.convert(r.imgstring);
                print(r.imgstring);
                images.add(bytes);
              }else images.add(Uint8List(0));
            });
            return ListView.builder(
                itemCount: state.results?.length,
                itemBuilder: (c, i) {
                  return Card(
                      key: Key(i.toString()),
                      child: ListTile(
                        leading: SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.memory(images[i])),
                        subtitle: Text(state.results[i].substance),
                        title: Text(state.results[i].name +
                            '  ' +
                            state.results[i].strength),
                        
                      ));
                });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
