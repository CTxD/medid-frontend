import 'package:flutter/material.dart';
import 'package:medid/src/ui/home_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}
