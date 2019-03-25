import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  double height;

  final String imagePath;

  final Key key;

  final Widget page;

  final double imageWidth;

  HomeButton({
    this.key,
    this.page,
    this.height,
    this.imageWidth,
    this.imagePath,
  });
  @override
  Widget build(BuildContext context) {
    return new Expanded(
        child: new Container(
      height: this.height,
      child: new FlatButton(
        key: this.key,
        child: new Image.asset(
          this.imagePath,
          height: this.imageWidth,
          width: this.imageWidth,
        ),
        color: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => this.page,
            ),
          );
        },
      ),
    ));
  }
}
