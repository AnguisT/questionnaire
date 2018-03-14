// package
import 'package:flutter/material.dart';

// class
import '../../models/models.dart';
import '../../models/widget.models.dart';
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
      appBar: new CustomNavigationBar(
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
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: new Row(
                          children: <Widget>[
                            new Text(
                              'Date of passing the test: ',
                              style: new TextStyle(fontSize: 16.0),
                            ),
                            new Text(
                              descStatistics.date,
                              style: new TextStyle(fontSize: 16.0),
                            ),
                          ],
                        )
                      ),
                      new Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                        child: new Row(
                          children: <Widget>[
                            new Text(
                              'You scored the following points: ',
                              style: new TextStyle(fontSize: 16.0),
                            ),
                            new Text(
                              descStatistics.numberPoint.toString(),
                              style: new TextStyle(fontSize: 16.0),
                            ),
                          ],
                        )
                      ),
                      new Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                        child: new Row(
                          children: <Widget>[
                            new Text(
                              'Time spent on test: ',
                              style: new TextStyle(fontSize: 16.0),
                            ),
                            new Text(
                              descStatistics.countTime.toString() + ' seconds',
                              style: new TextStyle(fontSize: 16.0),
                            ),
                          ],
                        )
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
                              descStatistics.toTitle,
                              style: new TextStyle(fontSize: 16.0),
                            ),
                          ],
                        )
                      ),
                      new Container(
                        width: MediaQuery.of(context).size.width,
                        child: new Text(
                          descStatistics.description,
                          textAlign: TextAlign.justify,
                          style: new TextStyle(fontSize: 16.0, height: 1.5),
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