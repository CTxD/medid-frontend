import 'package:flutter/material.dart';
import 'src/app.dart';
import 'package:medid/src/ui/home_page.dart';

// Run the main App Widget
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "MedID", home: HomePage(), color: Colors.black);
  }
}
