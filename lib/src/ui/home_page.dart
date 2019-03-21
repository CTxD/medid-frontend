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
  static final searchBarKey = Key("searchbar");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Container(
            decoration: new BoxDecoration(color: Colors.white),
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Row(
                    children: <Widget>[
                      new Container(
                        child: new Expanded(
                          child: new Image.asset('images/MEDID_LOGO.png'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  new Container(
                    decoration: new BoxDecoration(
                        gradient: new RadialGradient(
                      center: Alignment(0.0, 0.0),
                      colors: [Colors.lightBlue[300], Colors.white],
                      radius: 0.5,
                    )),
                    child: new Wrap(
                      children: <Widget>[
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Expanded(
                                child: new Container(
                              height: 150,
                              child: new FlatButton(
                                key: navigateToTakeAPictureButtonKey,
                                splashColor: Colors.lightBlue[300],
                                highlightColor: Colors.white,
                                child: new Image.asset(
                                  'images/photo.png',
                                  height: 70,
                                  width: 70,
                                ),
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TakeAPicture(),
                                    ),
                                  );
                                },
                              ),
                            )),
                            SizedBox(
                              width: 2,
                            ),
                            new Expanded(
                                child: new Container(
                              height: 150,
                              child: new FlatButton(
                                key: searchBarKey,
                                splashColor: Colors.lightBlue[300],
                                highlightColor: Colors.white,
                                child: new Image.asset(
                                  'images/list.png',
                                  height: 55,
                                  width: 55,
                                ),
                                color: Colors.white,
                                onPressed: () {
                                  showSearch(
                                      context: context, delegate: PillSearch());
                                },
                              ),
                            ))
                          ],
                        ),
                        SizedBox(
                          height: 152,
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Expanded(
                                child: new Container(
                              height: 100,
                              child: new FlatButton(
                                key: navigateToInfoButtonKey,
                                splashColor: Colors.lightBlue[300],
                                highlightColor: Colors.white,
                                child: new Image.asset(
                                  'images/info.png',
                                  height: 35,
                                  width: 35,
                                ),
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Info(),
                                    ),
                                  );
                                },
                              ),
                            )),
                            SizedBox(
                              width: 2,
                            ),
                            new Expanded(
                                child: new Container(
                              height: 100,
                              child: new FlatButton(
                                key: navigateToHelpButtonKey,
                                splashColor: Colors.lightBlue[300],
                                highlightColor: Colors.white,
                                child: new Image.asset(
                                  'images/help.png',
                                  height: 35,
                                  width: 35,
                                ),
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Help(),
                                    ),
                                  );
                                },
                              ),
                            ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ])));
  }
}
