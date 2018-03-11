// package
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class
import '../../models/models.dart';
import '../../modules/http.client.dart';

class ProfilePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {

  String mail;
  bool isLoaded = false;
  CustomHttpClient httpClient = new CustomHttpClient();
  User statistics;

  @override
  void initState() {
    super.initState();
    _getMial();
  }

  _getMial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mail = prefs.getString('mail');
    _fillArray();
  }

  _fillArray() {
    httpClient.getUserByMail(mail).then((res) {
      setState(() {
        statistics = new User(
          mail: res['users'][0]['mail'],
          password: res['users'][0]['password'],
          firstName: res['users'][0]['first_name'],
          lastName: res['users'][0]['last_name'],
          birthday: DateTime.parse(res['users'][0]['birthday']),
          city: res['users'][0]['city'],
          idSexs: res['users'][0]['id_sexs'],
        );
        isLoaded = true;
      });
    });
  }

  _changePassword() {
    showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text('Change'),
        content: new Container(),
        actions: <Widget>[
          new FlatButton(
            child: new Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          new FlatButton(
            child: new Text('OK'),
            onPressed: () {},
          ),
        ],
      )
    );
  }

  _changeFirstName() {
    showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text('Change'),
        content: new Container(),
        actions: <Widget>[
          new FlatButton(
            child: new Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          new FlatButton(
            child: new Text('OK'),
            onPressed: () {},
          ),
        ],
      )
    );
  }

  _changeLastName() {
    showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text('Change'),
        content: new Container(),
        actions: <Widget>[
          new FlatButton(
            child: new Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          new FlatButton(
            child: new Text('OK'),
            onPressed: () {},
          ),
        ],
      )
    );
  }

  _changeCity() {
    showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text('Change'),
        content: new Container(),
        actions: <Widget>[
          new FlatButton(
            child: new Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          new FlatButton(
            child: new Text('OK'),
            onPressed: () {},
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget lineProgress = new LinearProgressIndicator();

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Profile', style: new TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: isLoaded ? new SafeArea(
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
                  children: <Widget>[
                    new Container(
                      child: new ListTile(
                        title: new Text(
                          'Mail: ' + statistics.mail
                        ),
                      ),
                    ),
                    new Divider(),
                    new Container(
                      child: new ListTile(
                        title: new Text(
                          'Change password',
                        ),
                        trailing: new Icon(Icons.edit),
                        onTap: _changePassword,
                      ),
                    ),
                    new Divider(),
                    new Container(
                      child: new ListTile(
                        title: new Text(
                          'First name: ' + statistics.firstName,
                        ),
                        trailing: new Icon(Icons.edit),
                        onTap: _changeFirstName,
                      ),
                    ),
                    new Divider(),
                    new Container(
                      child: new ListTile(
                        title: new Text(
                          'Last name: ' + statistics.lastName,
                        ),
                        trailing: new Icon(Icons.edit),
                        onTap: _changeLastName,
                      ),
                    ),
                    new Divider(),
                    new Container(
                      child: new ListTile(
                        title: new Text(
                          'City: ' + statistics.city,
                        ),
                        trailing: new Icon(Icons.edit),
                        onTap: _changeCity,
                      ),
                    ),
                    new Divider(),
                    new Container(
                      child: new ListTile(
                        title: new Text(
                          'Birthday: ${statistics.birthday.year.toString()}-${statistics.birthday.month.toString().padLeft(2, '0')}-${statistics.birthday.day.toString().padLeft(2, '0')}',
                        ),
                      ),
                    ),
                    new Divider(),
                    new Container(
                      child: new ListTile(
                        title: new Text(
                          'Sexs: ' + (statistics.idSexs == 1 ? 'Мужской' : 'Женский'),
                        ),
                      ),
                    ),
                  ],
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
            ],
          ),
        ),
      ) : lineProgress,
    );
  }
}