import 'package:flutter/material.dart';
import 'package:medid/src/ui/cam.dart';
import 'package:medid/src/ui/movie_list.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text('Open MovieList'),
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MovieList()),
                  );
                },
              )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text('Open Cam'),
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CamPage()),
                  );
                },
              ),
            )
          ],
        )
      ),
    );
  }
}