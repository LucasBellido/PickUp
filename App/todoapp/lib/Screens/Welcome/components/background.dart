import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //size of screen
    return Container(
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            child: Image.asset(
              'assets/images/soccerfield.jpg',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            child: Image.asset("assets/images/pickup_white_no_outline.png"),
            width: size.width * 0.5,
            top: 125,
          ),
          child
        ],
      ),
    );
  }
}
