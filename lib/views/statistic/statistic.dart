import 'package:flutter/material.dart';
import '../../modules/http.client.dart';

class StatisticPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _StatisticPage();
}

class _StatisticPage extends State<StatisticPage> {

  HttpClient httpClient = new HttpClient();

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
      body: new SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: new Text('Statistics')
      )
    );
  }
}