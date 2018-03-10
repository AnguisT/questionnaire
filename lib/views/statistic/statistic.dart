// package
import 'package:flutter/material.dart';

// class
import '../../modules/http.client.dart';

class StatisticPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _StatisticPage();
}

class _StatisticPage extends State<StatisticPage> {

  CustomHttpClient httpClient = new CustomHttpClient();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Statistics', style: new TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
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
                  child: new Text('Statistics')
                )
              ),
              new Container(
              padding: const EdgeInsets.only(top: 10.0),
              width: MediaQuery.of(context).size.width,
                child: new RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: new Text('Return on home page'),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/home');
                  },
                ),
              ),
            ],
          )
        )
      )
    );
  }
}