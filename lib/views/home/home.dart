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
        title: new Text('Home page'),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: new Container(
        child: new Center(
          child: new Text('Home page in my app'),
        ),
      )
    );
  }
}