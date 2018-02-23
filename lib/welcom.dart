import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _WelcomPage();
}

class _WelcomPage extends State<WelcomPage> {


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Welcom page'),
        backgroundColor: Colors.blue,
      ),
      body: new Container(
        child: new Center(
          child: new Column(
            children: <Widget>[
              Platform.isIOS ? new CupertinoButton(
                child: new Text('IOS'),
                onPressed: () {
                  showDialog(
                    context: context,
                    child: new CupertinoAlertDialog(
                      title: new Text('Hello'),
                      content: new Text('This is IOS'),
                    )
                  );
                }
              ) : new RaisedButton(
                child: new Text('Android'),
                onPressed: () {
                  showDialog(
                    context: context,
                    child: new AlertDialog(
                      title: new Text('Hello'),
                      content: new Text('This is android'),
                    )
                  );
                }
              )
            ],
          )
        ),
      )
    );
  }
}