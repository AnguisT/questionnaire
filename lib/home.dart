import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _HomePage();
}

class _HomePage extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Welcom page'),
        backgroundColor: Colors.blue,
      ),
      body: new Container(
        child: new Center(
          child: new Text('Welcom my app'),
        ),
      )
    );
  }
}