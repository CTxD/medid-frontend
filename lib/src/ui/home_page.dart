import 'package:flutter/material.dart';
import 'package:medid/src/ui/info_page.dart';
import 'package:medid/src/ui/help_page.dart';
import 'package:medid/src/ui/pill_library_page.dart';
import 'package:medid/src/ui/cam_page.dart';
import 'package:medid/src/ui/widgets/home_button.dart';

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
                          child: new Image.asset('images/medid_logo.png'),
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
                            HomeButton(
                              page: CamPage(),
                              imagePath: 'images/photo.png',
                              height: 150,
                              imageWidth: 70,
                              key: navigateToTakeAPictureButtonKey,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            HomeButton(
                              page: PillLibraryPage(),
                              imagePath: 'images/list.png',
                              height: 150,
                              imageWidth: 55,
                              key: navigateToPillLibraryButtonKey,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 152,
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            HomeButton(
                              page: InfoPage(),
                              imagePath: 'images/info.png',
                              height: 100,
                              imageWidth: 35,
                              key: navigateToInfoButtonKey,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            HomeButton(
                              page:HelpPage(),
                              imagePath: 'images/help.png',
                              height: 100,
                              imageWidth: 35,
                              key: navigateToHelpButtonKey,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ])));
  }
}
