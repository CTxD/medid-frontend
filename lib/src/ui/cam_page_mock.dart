import 'package:flutter/material.dart';
import 'package:medid/src/bloc/bloc.dart';
import 'package:medid/src/repositories/pill_api_client.dart';
import 'package:medid/src/repositories/pill_repository.dart';
import 'package:medid/src/ui/result_page.dart';
import 'package:http/http.dart' as http;

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
              context,
              MaterialPageRoute(
                  builder: (context) => ResultPage(
                      resultBloc: ResultBloc(
                          pillRepository: new PillRepository(
                              pillApiClient:
                                  PillApiClient(httpClient: http.Client())))))),
        )));
  }
}
