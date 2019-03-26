import 'package:flutter/material.dart';
import 'package:medid/src/ui/result_page.dart';

class CamPageMock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Identify Pill"),
        ),
        body: Center(
            child: RaisedButton(
          padding: const EdgeInsets.all(8.0),
          textColor: Colors.white,
          color: Colors.blue,
          child: Column(
            children: <Widget>[
              Icon(Icons.camera_alt),
              Text("Take a picture"),
            ],
          ),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => ResultPage())),
        )));
  }
}
