import 'package:flutter/material.dart';
import 'package:medid/src/ui/info.dart';
import 'package:medid/src/ui/help.dart';
import 'package:medid/src/ui/pill_library.dart';
import 'package:medid/src/ui/take_a_picture.dart';



class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new RaisedButton(
              padding: const EdgeInsets.all(8.0),
              textColor: Colors.white,
              color: Colors.blue,
              child:Column(
                children: <Widget>[
                  Icon(Icons.camera_alt),
                  Text("Take a picture"),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakeAPicture(),
                  ),
                );
              },
            ),
            new RaisedButton(
              padding: const EdgeInsets.all(8.0),
              textColor: Colors.white,
              color: Colors.blue,
              child:Column(
                children: <Widget>[
                  Icon(Icons.folder_open),
                  Text("Pill library"),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PillLibrary(),
                  ),
                );
              },
            ),
            new RaisedButton(
              padding: const EdgeInsets.all(8.0),
              textColor: Colors.white,
              color: Colors.blue,
              child:Column(
                children: <Widget>[
                  Icon(Icons.info),
                  Text("Info"),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Info(),
                  ),
                );
              },
            ),
            new RaisedButton(
              padding: const EdgeInsets.all(8.0),
              textColor: Colors.white,
              color: Colors.blue,
              child:Column(
                children: <Widget>[
                  Icon(Icons.help),
                  Text("Help"),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Help(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}






