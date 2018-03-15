// dart
import 'dart:async';

// package
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class
import '../../models/models.dart';
import '../../models/widget.models.dart';

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _HomePage();
}

class _HomePage extends State<HomePage> {

  Future<bool> _onWillPop() async {
    bool res;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return new CustomAlertDialog(
          content: new Text('Do you really want to exit?'),
          onCancel: () {
            res = false;
            Navigator.of(context).pop();
          },
          onOk: () {
            res = true;
            Navigator.of(context).pop();
          },
        );
      }
    );
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new CustomNavigationBar(
        title: new Text(
          'Welcome to application Test Reisas',
          style: new TextStyle(
            color: Colors.white,
            fontSize: 16.0
          )
        ),
        backgroundColor: Colors.blue,
        buttonBack: false,
        centerTitle: true,
      ),
      body: new SafeArea(
        top: false,
        bottom: false,
        left: false,
        right: false,
        child: new Center(
          child: new Form(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 80.0,
                  padding: const EdgeInsets.all(10.0),
                  child: new Text(
                    'Hello ' + firstNameForHomePage,
                    textAlign: TextAlign.center,
                    style: new TextStyle(fontSize: 17.0),
                  )
                ),
                new Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 80.0,
                  padding: const EdgeInsets.all(10.0),
                  child: new CustomButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    text: 'Start test',
                    onPressed: () {
                      Navigator.of(context).pushNamed('/test');
                    },
                  )
                ),
                new Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 80.0,
                  padding: const EdgeInsets.all(10.0),
                  child: new CustomButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    text: 'Look statistics',
                    onPressed: () {
                      Navigator.of(context).pushNamed('/statistics');
                    },
                  )
                ),
                new Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 80.0,
                  padding: const EdgeInsets.all(10.0),
                  child: new CustomButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    text: 'Total options',
                    onPressed: () {
                      Navigator.of(context).pushNamed('/totaloptions');
                    },
                  )
                ),
                new Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 80.0,
                  padding: const EdgeInsets.all(10.0),
                  child: new CustomButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    text: 'Profile',
                    onPressed: () {
                      Navigator.of(context).pushNamed('/profile');
                    },
                  )
                )
              ],
            ),
            onWillPop: _onWillPop,
          )
        )
      )
    );
  }
}