import 'package:flutter/material.dart';
import 'package:todoapp/constants.dart';
import 'package:todoapp/Screens/Welcome/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  //_MyAppState createState() => _MyAppState();
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PickUp',
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          inputDecorationTheme: InputDecorationTheme(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)))),
      home: WelcomeScreen(),
    );
  }
}
