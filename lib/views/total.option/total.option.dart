// package
import 'package:flutter/material.dart';

// class
import '../../modules/http.client.dart';

class TotalOptionPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _TotalOptionPage();
}

class _TotalOptionPage extends State<TotalOptionPage> {

  CustomHttpClient httpClient = new CustomHttpClient();
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    isLoaded = true;
  }

  @override
  Widget build(BuildContext context) {
    Widget lineProgress = new LinearProgressIndicator();

    Widget bodyAndroid = new SafeArea(
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
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Total option', style: new TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: isLoaded ? bodyAndroid : lineProgress
    );
  }
}