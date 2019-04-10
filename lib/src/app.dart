import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medid/src/blocs/cam_bloc.dart';
import 'package:medid/src/blocs/counter_bloc.dart';
import 'package:medid/src/ui/cam_page.dart';
import 'package:medid/src/ui/counter_page.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App>{
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text("Home!"),
      ),
      body: Center(
        child:FloatingActionButton(
          child: Icon(Icons.camera),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => CamPage(camBloc: CamBloc())
            ));
          },
        ),
      ),
    );
  }

}