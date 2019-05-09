import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medid/src/blocs/cam/bloc.dart';
import 'package:medid/src/ui/info_page.dart';
import 'package:medid/src/ui/help_page.dart';
import 'package:medid/src/ui/pill_library_page.dart';
import 'package:medid/src/ui/cam_page.dart';
import 'package:medid/src/ui/widgets/home_button.dart';

class HomePage extends StatelessWidget {
  static const camPageButtonKey = Key('camPageButton');
  static const pillLibButtonKey = Key('pillLibButton');
  static const infoPageButtonKey = Key('infoPageButton');
  static const helpPageButtonKey = Key('helpPageButton');
  @override
  Widget build(BuildContext context) {
    final camBloc = CamBloc();

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
                              page: BlocProvider<CamBloc>(
                                  bloc: camBloc, child: CamPage()),
                              imagePath: 'images/photo.png',
                              height: 150,
                              imageWidth: 70,
                              key: camPageButtonKey,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            HomeButton(
                              page: PillLibraryPage(),
                              imagePath: 'images/list.png',
                              height: 150,
                              imageWidth: 55,
                              key: pillLibButtonKey,
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
                              key: infoPageButtonKey,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            HomeButton(
                              page: HelpPage(),
                              imagePath: 'images/help.png',
                              height: 100,
                              imageWidth: 35,
                              key: helpPageButtonKey,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ])));
  }
}
