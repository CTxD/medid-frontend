import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:medid/src/blocs/cam_bloc.dart';

List<CameraDescription> cameras;

class CamPage extends StatefulWidget {
  @override
  _CamPageState createState() => _CamPageState();
}

class _CamPageState extends State<CamPage> {
  CamBloc _cam;

  @override
  void initState() {
    _cam = new CamBloc();
  }

  @override
  void dispose() {
    _cam.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    if(_cam.camerasAvailable){
      // Camera was found
      return AspectRatio(
        aspectRatio: _cam.controller.value.aspectRatio,
        child: CameraPreview(_cam.controller),
      );
    }else{
      // Camera was not found!
      return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment(0.0, 0.0),
          child: Text("No cameras found", style: TextStyle(
            fontSize: 18,
            decorationColor: Color(255)
          )),
        )
      ],
    );
    }
    
  }

}