// package
import 'package:flutter/material.dart';

// class
import '../../models/models.dart';
import '../../modules/http.client.dart';

class DescStatisticsPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _DescStatisticsPage();
}

class _DescStatisticsPage extends State<DescStatisticsPage> {

  CustomHttpClient httpClient = new CustomHttpClient();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(descStatistics.testTitle, style: new TextStyle(color: Colors.white, fontSize: 15.0),),
        centerTitle: true,
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
                          'Date of passing the test: ' + descStatistics.date,
                          style: new TextStyle(fontSize: 18.0),
                        ),
                      ),
                      new Container(
                        width: MediaQuery.of(context).size.width,
                        child: new Text(
                          'You have recruited ' + descStatistics.numberPoint.toString() + ' points',
                          style: new TextStyle(fontSize: 18.0),
                        ),
                      ),
                      new Container(
                        width: MediaQuery.of(context).size.width,
                        child: new Text(
                          'Time spent on test: ' + descStatistics.countTime.toString(),
                          style: new TextStyle(fontSize: 18.0),
                        ),
                      ),
                      new Container(
                        width: MediaQuery.of(context).size.width,
                        child: new Text(
                          'Result: ' + descStatistics.toTitle,
                          style: new TextStyle(fontSize: 18.0),
                        ),
                      ),
                      new Container(
                        width: MediaQuery.of(context).size.width,
                        child: new Text(
                          'Description: ' + descStatistics.description
                        ),
                      )
                    ],
                  )
                ),
              ),
            ],
          )
        )
      )
    );
  }
}