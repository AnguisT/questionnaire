// package
import 'package:flutter/material.dart';

// class
import '../../models/widget.models.dart';
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
      appBar: new CustomNavigationBar(
        title: new Text('Result', style: new TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
        centerTitle: true,
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
                        padding: const EdgeInsets.only(bottom: 10.0),
                        width: MediaQuery.of(context).size.width,
                        child: new Row(
                          children: <Widget>[
                            new Text(
                              'You scored the following points: ',
                              style: new TextStyle(fontSize: 16.0),
                            ),
                            new Text(
                              response.numberPoint.toString(),
                              style: new TextStyle(fontSize: 16.0),
                            ),
                          ],
                        )
                      ),
                      new Container(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                        width: MediaQuery.of(context).size.width,
                        child: new Text(
                          'From points ${response.totalOptions[0].fromValues} to points ${response.totalOptions[0].toValues}',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                      ),
                      new Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(top: 5.0, bottom: 13.5),
                        child: new Row(
                          children: <Widget>[
                            new Text(
                              'Your result: ',
                              style: new TextStyle(fontSize: 16.0),
                            ),
                            new Text(
                              response.totalOptions[0].title,
                              style: new TextStyle(fontSize: 16.0),
                            ),
                          ],
                        )
                      ),
                      new Container(
                        width: MediaQuery.of(context).size.width,
                        child: new Text(
                          response.totalOptions[0].description,
                          textAlign: TextAlign.justify,
                          style: new TextStyle(fontSize: 16.0, height: 1.5),
                        ),
                      )
                    ],
                  )
                ),
              ),
              new Container(
                padding: const EdgeInsets.only(top: 10.0),
                width: MediaQuery.of(context).size.width,
                child: new CustomButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  text: 'Look statistics',
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/statistics');
                  },
                ),
              ),
              new Container(
                padding: const EdgeInsets.only(top: 10.0),
                width: MediaQuery.of(context).size.width,
                child: new CustomButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  text: 'Look total options',
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/totaloptions');
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