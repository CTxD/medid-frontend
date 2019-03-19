import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medid/src/blocs/cam_bloc.dart';

class CamPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CamPageState();

}

class _CamPageState extends State<CamPage> {
  @override
  Widget build(BuildContext context) {
    final CamBloc _camBloc = BlocProvider.of<CamBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Identify Pill"),

      ),
      body: BlocBuilder(
        bloc: _camBloc,
        builder: (context, dynamic a){
          return Center(
            child: Text("Widget works!"),
          );
        }
      )
    );
  }

}