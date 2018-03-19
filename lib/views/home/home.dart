// dart
import 'dart:async';

// package
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class
import '../../models/models.dart';
import '../../models/widget.models.dart';
import '../../modules/local.db.dart';
import '../../modules/localizations.dart';

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _HomePage();
}

class _HomePage extends State<HomePage> {

  bool isLoaded = false;
  DBProvider dbProvider = new DBProvider();
  DemoLocalizations local = new DemoLocalizations();

  @override
  void initState() {
    super.initState();
    dbProvider.open().then((val) {
      setState(() {
        isLoaded = true;
      });
    });
  }

  Future<bool> _onWillPop() async {
    bool res;
    await showDialog(
      context: context,
      child: new CustomAlertDialog(
        content: new Text(local.localizedValues[languageCode]['homePage']['exit_from_app']),
        onCancel: () {
          res = false;
          Navigator.of(context).pop();
        },
        onOk: () {
          res = true;
          Navigator.of(context).pop();
        },
      )
    );
    return res;
  }

  _logoutFromLocalDB() {
    dbProvider.logout(mail).then((val) {
      Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded ? new Scaffold(
      appBar: new CustomNavigationBar(
        title: new Text(
          local.localizedValues[languageCode]['homePage']['title_bar'],
          style: new TextStyle(
            color: Colors.white,
            fontSize: 16.0
          )
        ),
        backgroundColor: Colors.blue,
        buttonBack: false,
        centerTitle: true,
      ),
      body: new SafeArea(
        top: true,
        bottom: true,
        left: true,
        right: true,
        child: new Center(
          child: new Form(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 80.0,
                  padding: const EdgeInsets.all(10.0),
                  child: new Text(
                    local.localizedValues[languageCode]['homePage']['hello'] + ' ' + firstNameForHomePage,
                    textAlign: TextAlign.center,
                    style: new TextStyle(fontSize: 17.0),
                  )
                ),
                new Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 80.0,
                  padding: const EdgeInsets.all(10.0),
                  child: new CustomButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    text: local.localizedValues[languageCode]['homePage']['start_test'],
                    onPressed: () {
                      Navigator.of(context).pushNamed('/test');
                    },
                  )
                ),
                new Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 80.0,
                  padding: const EdgeInsets.all(10.0),
                  child: new CustomButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    text: local.localizedValues[languageCode]['homePage']['look_statistics'],
                    onPressed: () {
                      Navigator.of(context).pushNamed('/statistics');
                    },
                  )
                ),
                new Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 80.0,
                  padding: const EdgeInsets.all(10.0),
                  child: new CustomButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    text: local.localizedValues[languageCode]['homePage']['total_options'],
                    onPressed: () {
                      Navigator.of(context).pushNamed('/totaloptions');
                    },
                  )
                ),
                new Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 80.0,
                  padding: const EdgeInsets.all(10.0),
                  child: new CustomButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    text: local.localizedValues[languageCode]['homePage']['profile'],
                    onPressed: () {
                      Navigator.of(context).pushNamed('/profile');
                    },
                  )
                ),
                new Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 80.0,
                  padding: const EdgeInsets.all(10.0),
                  child: new CustomButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    text: local.localizedValues[languageCode]['homePage']['exit'],
                    onPressed: () {
                      _logoutFromLocalDB();
                    },
                  )
                )
              ],
            ),
            onWillPop: _onWillPop,
          )
        )
      )
    ) : new Container();
  }
}