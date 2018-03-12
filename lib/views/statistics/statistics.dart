// package
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

// class
import '../../models/models.dart';
import '../../modules/http.client.dart';

class StatisticsPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _StatisticsPage();
}

class _StatisticsPage extends State<StatisticsPage> {

  bool isLoaded = false;
  List<Statistics> arrayStatistics = [];
  CustomHttpClient httpClient = new CustomHttpClient();

  @override
  void initState() {
    super.initState();
    _getMial();
  }

  _getMial() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // mail = prefs.getString('mail');
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
    Statistics stat = new Statistics(
      countTime: item.countTime,
      date: item.date,
      description: item.description,
      numberPoint: item.numberPoint,
      testTitle: item.testTitle,
      toTitle: item.toTitle
    );
    descStatistics = stat;

    Navigator.of(context).pushNamed('/descstatistics');
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