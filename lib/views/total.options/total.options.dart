// package
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// class
import '../../models/models.dart';
import '../../models/widget.models.dart';
import '../../modules/http.client.dart';
import '../../modules/localizations.dart';

class TotalOptionsPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _TotalOptionsPage();
}

class _TotalOptionsPage extends State<TotalOptionsPage> {

  bool isLoaded = false;
  List<TotalOptions> arrayTotalOptions = [];
  CustomHttpClient httpClient = new CustomHttpClient();
  DemoLocalizations local = new DemoLocalizations();

  @override
  void initState() {
    super.initState();
    httpClient.getAllTotalOptions().then((res) {
      if (res != 'Error') {
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

  _getDescripition(String description) {
    showDialog(
      context: context,
      child: new CustomAlertDialog(
        title: new Text(local.localizedValues[languageCode]['totalOptionsPage']['description_title']),
        content: new Text(description),
        onOk: () {
          Navigator.of(context).pop();
        },
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
                '${local.localizedValues[languageCode]['totalOptionsPage']['from_points']} ${item.fromValues.toString()} ${local.localizedValues[languageCode]['totalOptionsPage']['points']} ${local.localizedValues[languageCode]['totalOptionsPage']['to_points']} ${item.toValues.toString()} ${local.localizedValues[languageCode]['totalOptionsPage']['points']}',
              ),
              trailing: new Icon(Icons.description),
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

    Widget body = new SafeArea(
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
                children: listTotalOptions.toList(),
              )
            ),
          ],
        )
      )
    );

    return new Scaffold(
      appBar: new CustomNavigationBar(
        title: new Text(local.localizedValues[languageCode]['totalOptionsPage']['title_bar'], style: new TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
        iconTheme: new IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: isLoaded ? body : lineProgress
    );
  }
}