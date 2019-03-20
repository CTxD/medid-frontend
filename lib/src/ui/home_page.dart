import 'package:flutter/material.dart';
import 'package:medid/src/ui/info.dart';
import 'package:medid/src/ui/help.dart';
import 'package:medid/src/ui/pill_library.dart';
import 'package:medid/src/ui/take_a_picture.dart';

class HomePage extends StatelessWidget {
  static const navigateToTakeAPictureButtonKey = Key('navigateToTakeAPicture');
  static const navigateToPillLibraryButtonKey = Key('navigateToPillLibrary');
  static const navigateToInfoButtonKey = Key('navigateToInfo');
  static const navigateToHelpButtonKey = Key('navigateToHelp');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("HomePage"),
        ),
        body: new Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                child: new MaterialButton(
                  key: navigateToTakeAPictureButtonKey,
                  padding: const EdgeInsets.all(8.0),
                  textColor: Colors.white,
                  color: Colors.blue,
                  height: 150,
                  child: Column(
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
              ),
              SizedBox(width: 4),
              new Expanded(
                  child: new MaterialButton(
                    key: navigateToPillLibraryButtonKey,
                padding: const EdgeInsets.all(8.0),
                textColor: Colors.white,
                color: Colors.blue[300],
                height: 150,
                child: Column(
                  children: <Widget>[
                    Icon(Icons.list),
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
              )),
            ],
          ),
          SizedBox(height: 4),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new MaterialButton(
                  key: navigateToInfoButtonKey,
                  padding: const EdgeInsets.all(8.0),
                  textColor: Colors.white,
                  color: Colors.blue[300],
                  child: Column(
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
              ),
              SizedBox(width: 4),
              new Expanded(
                child: new MaterialButton(
                  key: navigateToHelpButtonKey,
                  padding: const EdgeInsets.all(8.0),
                  textColor: Colors.white,
                  color: Colors.blue[300],
                  child: Column(
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
              ),
            ],
          ),
          SizedBox(height: 4),
        ]));
  }
}
