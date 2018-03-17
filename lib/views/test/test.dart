// package
import 'package:flutter/material.dart';

// class
import '../../modules/http.client.dart';
import '../../models/widget.models.dart';
import '../../modules/localizations.dart';

class TestPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _TestPage();
}

class _TestPage extends State<TestPage> {

  String title = '';
  String description = '';
  bool isLoaded = false;
  CustomHttpClient httpClient = new CustomHttpClient();
  DemoLocalizations local = new DemoLocalizations();

  @override
  void initState() {
    super.initState();
    httpClient.getTest().then((res) {
      if (res != 'Error'){
        setState(() {
          title = res['tests'][0]['title'];
          description = res['tests'][0]['description'];
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

  @override
  Widget build(BuildContext context) {
    Widget lineProgress = new LinearProgressIndicator();

    return new Scaffold(
      appBar: new CustomNavigationBar(
        title: new Text(
          isLoaded ? title : local.localizedValues[languageCode]['testPage']['wait'],
          style: new TextStyle(
            color: Colors.white,
            fontSize: 17.0
          ),
        ),
        backgroundColor: Colors.blue,
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: isLoaded ? new Container(
        padding: const EdgeInsets.all(10.0),
        child: new SafeArea(
          top: true,
          bottom: true,
          left: true,
          right: true,
          child: new Column(
            children: <Widget>[
              new Expanded(
                child: new SingleChildScrollView(
                  child: new Container(
                    child: new Text(
                      description,
                      textAlign: TextAlign.justify,
                      style: new TextStyle(fontSize: 18.0)
                    ),
                  ),
                )
              ),
              new Container(
                padding: const EdgeInsets.only(top: 10.0),
                width: MediaQuery.of(context).size.width,
                child: new CustomButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  text: local.localizedValues[languageCode]['testPage']['start'],
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/question');
                  },
                ),
              )
            ],
          )
        )
      ) : lineProgress,
    );
  }
}