// package
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

// class
import '../../models/models.dart';
import '../../modules/http.client.dart';
import '../../models/widget.models.dart';
import '../../modules/localizations.dart';

class StatisticsPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _StatisticsPage();
}

class _StatisticsPage extends State<StatisticsPage> {

  bool isLoaded = false;
  List<Statistics> arrayStatistics = [];
  CustomHttpClient httpClient = new CustomHttpClient();
  DemoLocalizations local = new DemoLocalizations();

  @override
  void initState() {
    super.initState();
    _getMial();
  }

  _getMial() async {
    _fillArray();
  }

  _fillArray() {
    httpClient.getAllStatistics(mail).then((res) {
      if (res != 'Error') {
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
      } else {
        showDialog(
          context: context,
          child: new CustomAlertDialog(
            title: new Text(local.localizedValues[languageCode]['errorMessage']['error_title']),
            content: new Text(local.localizedValues[languageCode]['errorMessage']['error_message']),
            onOk: () {
              Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
            },
          )
        );
      }
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
              subtitle: new Text('${local.localizedValues[languageCode]['statisticsPage']['date_passing']}: ${item.date}'),
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
      appBar: new CustomNavigationBar(
        title: new Text(
          local.localizedValues[languageCode]['statisticsPage']['title_bar'],
          style: new TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: isLoaded ? new SafeArea(
        top: true,
        bottom: true,
        left: true,
        right: true,
        child: new Container(
          padding: const EdgeInsets.all(10.0),
          child: new Column(
            children: <Widget>[
              new Expanded(
                child: new ListView(
                  children: listStatistics.toList(),
                )
              ),
            ],
          )
        )
      ) : lineProgress,
    );
  }
}