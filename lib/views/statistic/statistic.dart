// package
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class
import '../../modules/http.client.dart';
import '../../models/models.dart';

class StatisticsPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _StatisticsPage();
}

class _StatisticsPage extends State<StatisticsPage> {

  String mail;
  bool isLoaded = false;
  List<Statistics> arrayStatistics = [];
  CustomHttpClient httpClient = new CustomHttpClient();

  @override
  void initState() {
    super.initState();
    _getMial();
  }

  _getMial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mail = prefs.getString('mail');
    _fillArray();
  }

  _fillArray() {
    httpClient.getAllStatistics(mail).then((res) {
      for (int i = 0; i < res['statistics'].length; i++) {
        setState(() {
          DateTime dateTime = DateTime.parse(res['statistics'][i]['date']);
          var formatter = new DateFormat('yyyy-MM-dd');
          String date = formatter.format(dateTime);

          Statistics statistics = new Statistics(
            date: date,
            toTitle: res['statistics'][i]['tstitle'],
            testTitle: res['statistics'][i]['title'],
            description: res['statistics'][i]['description'],
            countTime: res['statistics'][i]['count_time'],
            numberPoint: res['statistics'][i]['number_point'],
          );
          arrayStatistics.add(statistics);
        });
      }
      setState(() {
        isLoaded = true;
      });
    });
  }

  _getMoreInformatino(Statistics item) {
    showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text('Information'),
        content: new Column(
          children: <Widget>[
            new Text('Your result: ' + item.toTitle),
            new Text('Amount recruited points: ' + item.numberPoint.toString()),
            new Text('The amount of time spent on the test: ' + item.numberPoint.toString()),
          ],
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            }
          )
        ],
      )
    );
  }

  Widget buildListStatistics(BuildContext context, Statistics item) {
    return new MergeSemantics(
      child: new Column(
        children: <Widget>[
          new Container(
            child: new ListTile(
              title: new Text(item.testTitle),
              subtitle: new Text('Date of passing the test: ${item.date}'),
              trailing: new Icon(Icons.description),
              onTap: () {
                _getMoreInformatino(item);
              }
            ),
          ),
          new Divider(),
        ]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Iterable<Widget> listStatistics = arrayStatistics.map((Statistics item) => buildListStatistics(context, item));

    Widget lineProgress = new LinearProgressIndicator();

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Statistics', style: new TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: isLoaded ? new SafeArea(
        top: false,
        bottom: false,
        left: false,
        right: false,
        child: new Container(
          padding: const EdgeInsets.all(10.0),
          child: new Column(
            children: <Widget>[
              new Expanded(
                child: new ListView(
                  children: listStatistics.toList(),
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
      ) : lineProgress,
    );
  }
}