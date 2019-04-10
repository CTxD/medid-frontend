import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medid/src/blocs/counter_bloc.dart';
import 'package:medid/src/ui/counter_page.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  final _counterBloc = CounterBloc();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _counterBloc,
      child: CounterPage()
    );
  }

}