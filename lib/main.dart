import 'package:flutter/material.dart';
import './views/login/login.dart';
import './views/home/home.dart';
import './views/sigup/signup.dart';

void main() {
  runApp(
    new MaterialApp(
      title: 'Questionnaire',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        // brightness: Brightness.dark,
        // primarySwatch: Colors.white,
        primaryColor: Colors.white,
      ),
      routes: <String, WidgetBuilder> {
        '/': (BuildContext context) => new LoginPage(),
        '/home': (BuildContext context) => new HomePage(),
        '/signup': (BuildContext context) => new SignupPage(),
      },
    )
  );
}