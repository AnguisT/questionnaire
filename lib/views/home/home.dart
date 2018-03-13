// package
import 'package:flutter/material.dart';

// class
import '../../models/models.dart';

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _HomePage();
}

class _HomePage extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'Welcome to application Test Reisas',
          style: new TextStyle(
            color: Colors.white,
            fontSize: 17.0
          )
        ),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: new SafeArea(
        top: false,
        bottom: false,
        left: false,
        right: false,
        child: new Center(
          child: new Container(
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
                  child: new RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: new Text('Start test'),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/test');
                    },
                  )
                ),
                new Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 80.0,
                  padding: const EdgeInsets.all(10.0),
                  child: new RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: new Text('Look statistics'),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/statistics');
                    },
                  )
                ),
                new Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 80.0,
                  padding: const EdgeInsets.all(10.0),
                  child: new RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: new Text('Total options'),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/totaloptions');
                    },
                  )
                ),
                new Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 80.0,
                  padding: const EdgeInsets.all(10.0),
                  child: new RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: new Text('Profile'),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/profile');
                    },
                  )
                )
              ],
            )
          )
        )
      )
    );
  }
}