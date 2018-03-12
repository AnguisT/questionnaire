// package
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// class
import '../../models/models.dart';
import '../../modules/http.client.dart';

class TotalOptionsPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _TotalOptionsPage();
}

class _TotalOptionsPage extends State<TotalOptionsPage> {

  CustomHttpClient httpClient = new CustomHttpClient();
  bool isLoaded = false;
  List<TotalOptions> arrayTotalOptions = [];

  @override
  void initState() {
    super.initState();
    httpClient.getAllTotalOptions().then((res) {
      setState(() {
        for (int i = 0; i < res['total_options'].length; i++) {
          TotalOptions totalOptions = new TotalOptions(
            fromValues: res['total_options'][i]['from_values'],
            toValues: res['total_options'][i]['to_values'],
            title: res['total_options'][i]['title'],
            description: res['total_options'][i]['description']
          );
          arrayTotalOptions.add(totalOptions);
        }
        isLoaded = true;
      });
    });
  }

  _getDescripition(String description) {
    showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text('Description'),
        content: new Text(description),
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

  Widget buildListTotalOptions(BuildContext context, TotalOptions item) {
    return new MergeSemantics(
      child: new Column(
        children: <Widget>[
          new Container(
            child: new ListTile(
              title: new Text(item.title),
              subtitle: new Text(
                'From ${item.fromValues.toString()} points to ${item.toValues.toString()} points',
              ),
              onTap: () {
                _getDescripition(item.description);
              }
            ),
          ),
          new Divider(),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    Iterable<Widget> listTotalOptions = arrayTotalOptions.map((TotalOptions item) => buildListTotalOptions(context, item));

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
              child: new ListView(
                children: listTotalOptions.toList(),
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
        title: new Text('Total options', style: new TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: isLoaded ? bodyAndroid : lineProgress
    );
  }
}