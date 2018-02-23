import 'package:flutter/material.dart';
import 'welcom.dart';
import 'home.dart';

void main() {
  runApp(
    new MaterialApp(
      title: 'Questionnaire',
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder> {
        '/': (BuildContext context) => new WelcomPage(),
        '/home': (BuildContext context) => new HomePage(),
      },
    )
  );
}