import 'package:flutter/material.dart';
import '../../modules/http.client.dart';

class QuestionPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _QuestionPage();
}

class _QuestionPage extends State<QuestionPage> {

  String title = 'Question';
  String description = 'Description';
  HttpClient httpClient = new HttpClient();
  int groupValue = 0;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    httpClient.getAllQuestion().then((res) {
      print(res);
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget lineProgress = new LinearProgressIndicator();

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title, style: new TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: isLoaded ? new Container(
        padding: const EdgeInsets.all(10.0),
        child: new Column(
          children: <Widget>[
            new Expanded(
              child: new Column(
                children: <Widget>[
                  new Container(
                    width: MediaQuery.of(context).size.width,
                    child: new Text(description),
                  ),
                  new Container(
                    child: new Row(
                      children: <Widget>[
                        new Radio<int>(
                          groupValue: groupValue,
                          value: 1,
                          onChanged: (int value) {
                            setState(() {
                              groupValue = value;
                            });
                          },
                        ),
                        new Text('Question first')
                      ],
                    )
                  ),
                  new Container(
                    child: new Row(
                      children: <Widget>[
                        new Radio<int>(
                          groupValue: groupValue,
                          value: 2,
                          onChanged: (int value) {
                            setState(() {
                              groupValue = value;
                            });
                          },
                        ),
                        new Text('Question second')
                      ],
                    )
                  ),
                  new Container(
                    child: new Row(
                      children: <Widget>[
                        new Radio<int>(
                          groupValue: groupValue,
                          value: 3,
                          onChanged: (int value) {
                            setState(() {
                              groupValue = value;
                            });
                          },
                        ),
                        new Text('Question third')
                      ],
                    )
                  ),
                  new Container(
                    child: new Row(
                      children: <Widget>[
                        new Radio<int>(
                          groupValue: groupValue,
                          value: 4,
                          onChanged: (int value) {
                            setState(() {
                              groupValue = value;
                            });
                          },
                        ),
                        new Text('Question four')
                      ],
                    )
                  ),
                  new Container(
                    child: new Row(
                      children: <Widget>[
                        new Radio<int>(
                          groupValue: groupValue,
                          value: 5,
                          onChanged: (int value) {
                            setState(() {
                              groupValue = value;
                            });
                          },
                        ),
                        new Text('Question five')
                      ],
                    )
                  ),
                  new Container(
                    child: new Row(
                      children: <Widget>[
                        new Radio<int>(
                          groupValue: groupValue,
                          value: 6,
                          onChanged: (int value) {
                            setState(() {
                              groupValue = value;
                            });
                          },
                        ),
                        new Text('Question six')
                      ],
                    )
                  ),
                ],
              ),
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              child: new Row(
                children: <Widget>[
                  new Container(
                    width: MediaQuery.of(context).size.width / 2 - 10,
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 5.0),
                    child: new RaisedButton(
                      color: Colors.blue,
                      child: new Text('Back', style: new TextStyle(color: Colors.white),),
                      onPressed: () {
                      },
                    ),
                  ),
                  new Container(
                    width: MediaQuery.of(context).size.width / 2 - 10,
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 5.0),
                    child: new RaisedButton(
                      color: Colors.blue,
                      child: new Text('Next', style: new TextStyle(color: Colors.white),),
                      onPressed: () {
                      },
                    ),
                  ),
                ],
              )
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              child: new Container(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: new RaisedButton(
                  color: Colors.blue,
                  child: new Text('Finish the test', style: new TextStyle(color: Colors.white),),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/result');
                  },
                ),
              ),
            )
          ],
        )
      ) : lineProgress,
    );
  }
}