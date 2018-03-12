// package
import 'package:flutter/material.dart';

// class
import '../../modules/http.client.dart';
import '../../models/models.dart';

class ResultPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _ResultPage();
}

class _ResultPage extends State<ResultPage> {

  CustomHttpClient httpClient = new CustomHttpClient();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Result', style: new TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: new SafeArea(
        top: false,
        bottom: false,
        left: false,
        right: false,
        child: new Container(
          padding: const EdgeInsets.all(10.0),
          child: new Column(
            children: <Widget>[
              new Expanded(
                child: new SingleChildScrollView(
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        width: MediaQuery.of(context).size.width,
                        child: new Text(
                          'You have recruited ' + response.numberPoint.toString() + ' points',
                          style: new TextStyle(fontSize: 20.0),
                        ),
                      ),
                      new Container(
                        width: MediaQuery.of(context).size.width,
                        child: new Text(
                          'From points ${response.totalOptions[0].fromValues} to points ${response.totalOptions[0].toValues}',
                          style: new TextStyle(fontSize: 20.0),
                        ),
                      ),
                      new Container(
                        width: MediaQuery.of(context).size.width,
                        child: new Text(
                          response.totalOptions[0].title,
                          style: new TextStyle(fontSize: 20.0),
                        ),
                      ),
                      new Container(
                        width: MediaQuery.of(context).size.width,
                        child: new Text(
                          response.totalOptions[0].description
                        ),
                      )
                    ],
                  )
                ),
              ),
              new Container(
                padding: const EdgeInsets.only(top: 10.0),
                width: MediaQuery.of(context).size.width,
                child: new RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: new Text('Return on home page'),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/home');
                  },
                ),
              ),
              new Container(
                padding: const EdgeInsets.only(top: 10.0),
                width: MediaQuery.of(context).size.width,
                child: new RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: new Text('Look total options'),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/total');
                  },
                ),
              )
            ],
          )
        )
      )
    );
  }
}