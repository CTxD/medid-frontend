import 'package:flutter/material.dart';

class CamResult extends StatefulWidget{
  final String imageFilePath;

  CamResult({@required this.imageFilePath});

  @override
  State<StatefulWidget> createState() => _CamResultState();

}

class _CamResultState extends State<CamResult>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resultater"),
      ),
      body: Center(
        child: Image.asset("${widget.imageFilePath}")
      ),
    );
  }

}