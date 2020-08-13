import 'package:flutter/material.dart';
import 'package:todoapp/Screens/Login/login_screen.dart';
import 'package:todoapp/Screens/Signup/signup_screen.dart';
import 'package:todoapp/components/rounded_button.dart';
import 'background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    imageCache.clear();
    Size size = MediaQuery.of(context).size; //size of screen
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: size.height * 0.1),
          Text("Connect with locals to play pickup sports",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: size.height * 0.3),
          RoundedButton(
            text: 'LOGIN',
            color: Colors.white,
            textColor: Colors.green,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
          ),
          RoundedButton(
            color: Colors.white,
            text: 'SIGN UP',
            textColor: Colors.green,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
