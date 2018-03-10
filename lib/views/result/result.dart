import 'package:flutter/material.dart';
import '../../modules/http.client.dart';
import '../../models/models.dart';

class ResultPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _ResultPage();
}

class _ResultPage extends State<ResultPage> {

  HttpClient httpClient = new HttpClient();

  @override
  void initState() {
    super.initState();
    print(response);
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
              new SingleChildScrollView(
                child: new Expanded(
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        width: MediaQuery.of(context).size.width,
                        child: new Text(
                          'Ваши набранные очки: 20',
                          style: new TextStyle(fontSize: 20.0),
                        ),
                      ),
                      new Container(
                        width: MediaQuery.of(context).size.width,
                        child: new Text(
                          'Уверен в себе',
                          style: new TextStyle(fontSize: 20.0),
                        ),
                      ),
                      new Container(
                        width: MediaQuery.of(context).size.width,
                        child: new Text(
                          'Уверенный в себе - боец, закаленный, решительный, упорный, героический, работоспособный, сильный, волевой, твердый, бесстрашный, отважный, самостоятельный.',
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
                    Navigator.of(context).pushNamed('/home');
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
                    Navigator.of(context).pushNamed('/total');
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