import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medid/src/blocs/counter_bloc.dart';
import 'package:medid/src/blocs/counter_event.dart';
import 'package:medid/src/blocs/counter_state.dart';

class CounterPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _CounterPageState();
  }
  
}

class _CounterPageState extends State<CounterPage> {
    final _counterBloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Counter")),
      body: BlocBuilder(
        bloc: _counterBloc,
        builder: (context, CounterState state) {
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("You have pushed the button this many times:"),
                Text(
                  "$state.counter",
                  style: Theme.of(context).textTheme.display1
                ),
              ],
            ),
          );
          },
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () => _counterBloc.dispatch(IncrementEvent()),
              tooltip: "Increment",
              child: Icon(Icons.add),  
            ),
            SizedBox(width: 10),
            FloatingActionButton(
              onPressed: () => _counterBloc.dispatch(DecrementEvent()),
              tooltip: "Decrement",
              child: Icon(Icons.remove),
            )
            
          ],
        ),
    );
  }

  void dispose() {
    _counterBloc.dispose();
    super.dispose();
  }
  
}