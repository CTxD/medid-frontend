import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final double height;

  final String imagePath;

  final Widget page;

  final double imageWidth;

  HomeButton({
    @required Key key,
    @required this.page,
    @required this.height,
    @required this.imageWidth,
    @required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Expanded(
        child: new Container(
      height: this.height,
      child: new FlatButton(
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
