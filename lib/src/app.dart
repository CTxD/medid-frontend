import 'package:flutter/material.dart';
import 'package:medid/src/ui/home_page.dart';
import 'ui/movie_list.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        home: Scaffold(
          body: HomePage(),
        ),
      );
  }
}