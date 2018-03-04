import 'package:flutter/material.dart';
import '../../modules/http.client.dart';

class TestPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _TestPage();
}

class _TestPage extends State<TestPage> {

  String title = '';
  String description = '';
  HttpClient httpClient = new HttpClient();
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    httpClient.getTest().then((res) {
      print(res);
      setState(() {
        title = res['tests'][0]['title'];
        description = res['tests'][0]['description'];
        isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget lineProgress = new LinearProgressIndicator();

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title, style: new TextStyle(color: Colors.white, fontSize: 17.0),),
        backgroundColor: Colors.blue,
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: isLoaded ? new Container(
        padding: const EdgeInsets.all(10.0),
        child: new Column(
          children: <Widget>[
            new Expanded(
              child: new Container(
                child: new Text(
                  description,
                  style: new TextStyle(fontSize: 20.0)
                ),
              ),
            ),
            new Container(
              // alignment: FractionalOffset.topCenter,
              padding: const EdgeInsets.only(top: 10.0),
              width: MediaQuery.of(context).size.width,
              child: new RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: new Text('Start'),
                onPressed: () {
                  Navigator.of(context).pushNamed('/question');
                },
              ),
            )
          ],
        )
      ) : lineProgress,
    );
  }
}