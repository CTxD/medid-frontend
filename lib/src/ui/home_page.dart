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
                                child: new Image.asset(
                                  'images/photo.png',
                                  height: 70,
                                  width: 70,
                                ),
                                color: Colors.white,
                                onPressed: () => {},
                              ),
                            )),
                            SizedBox(
                              width: 2,
                            ),
                            new Expanded(
                                child: new Container(
                              height: 150,
                              child: new FlatButton(
                                  child: new Image.asset(
                                    'images/list.png',
                                    height: 55,
                                    width: 55,
                                  ),
                                  color: Colors.white,
                                  onPressed: () => {}),
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
                                child: new Image.asset(
                                  'images/info.png',
                                  height: 35,
                                  width: 35,
                                ),
                                color: Colors.white,
                                onPressed: () => {},
                              ),
                            )),
                            SizedBox(
                              width: 2,
                            ),
                            new Expanded(
                                child: new Container(
                              height: 100,
                              child: new FlatButton(
                                  child: new Image.asset(
                                    'images/help.png',
                                    height: 35,
                                    width: 35,
                                  ),
                                  color: Colors.white,
                                  onPressed: () => {}),
                            ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  // new Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     new Expanded(
                  //       child: new FlatButton(
                  //         key: navigateToTakeAPictureButtonKey,
                  //         padding: const EdgeInsets.all(8.0),
                  //         textColor: Colors.black,
                  //         color: Colors.white,
                  //         child: Column(
                  //           children: <Widget>[
                  //             Icon(Icons.camera_alt, color: Colors.black),
                  //             Text("Take a picture"),
                  //           ],
                  //         ),
                  //         onPressed: () {
                  //           Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //               builder: (context) => TakeAPicture(),
                  //             ),
                  //           );
                  //         },
                  //       ),
                  //     ),
                  //     SizedBox(width: 4),
                  //     new Expanded(
                  //         child: new MaterialButton(
                  //       key: navigateToPillLibraryButtonKey,
                  //       padding: const EdgeInsets.all(8.0),
                  //       textColor: Colors.white,
                  //       color: Colors.blue[300],
                  //       height: 150,
                  //       child: Column(
                  //         children: <Widget>[
                  //           Icon(Icons.list),
                  //           Text("Pill library"),
                  //         ],
                  //       ),
                  //       onPressed: () {
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (context) => PillLibrary(),
                  //           ),
                  //         );
                  //       },
                  //     )),
                  //   ],
                  // ),
                  // SizedBox(height: 4),
                  // new Row(
                  //   children: <Widget>[
                  //     new Expanded(
                  //       child: new MaterialButton(
                  //         key: navigateToInfoButtonKey,
                  //         padding: const EdgeInsets.all(8.0),
                  //         textColor: Colors.white,
                  //         color: Colors.blue[300],
                  //         child: Column(
                  //           children: <Widget>[
                  //             Icon(Icons.info),
                  //             Text("Info"),
                  //           ],
                  //         ),
                  //         onPressed: () {
                  //           Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //               builder: (context) => Info(),
                  //             ),
                  //           );
                  //         },
                  //       ),
                  //     ),
                  //     SizedBox(width: 4),
                  //     new Expanded(
                  //       child: new MaterialButton(
                  //         key: navigateToHelpButtonKey,
                  //         padding: const EdgeInsets.all(8.0),
                  //         textColor: Colors.white,
                  //         color: Colors.blue[300],
                  //         child: Column(
                  //           children: <Widget>[
                  //             Icon(Icons.help),
                  //             Text("Help"),
                  //           ],
                  //         ),
                  //         onPressed: () {
                  //           Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //               builder: (context) => Help(),
                  //             ),
                  //           );
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 1),
                ])));
  }
}
