// package
import 'package:flutter/material.dart';

// class
import '../../models/widget.models.dart';
import '../../modules/http.client.dart';

class TestPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _TestPage();
}

class _TestPage extends State<TestPage> {

  String title = '';
  String description = '';
  CustomHttpClient httpClient = new CustomHttpClient();
  bool isLoaded = false;

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
          builder: (BuildContext context) {
            return new CustomAlertDialog(
              title: new Text('Error message'),
              content: new Text('Check your network'),
              onOk: () {
                Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
              },
            );
          }
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
          isLoaded ? title : 'Wait...',
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
          top: false,
          bottom: false,
          left: false,
          right: false,
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
                  text: 'Start',
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