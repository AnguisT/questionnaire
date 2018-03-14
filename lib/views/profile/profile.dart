// dart

// package
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class
import '../../models/models.dart';
import '../../modules/http.client.dart';
import '../../models/widget.models.dart';

class ProfilePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {

  bool isLoaded = false;
  CustomHttpClient httpClient = new CustomHttpClient();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  User user;
  TextEditingController _userController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _fillArray();
  }

  // _getMial() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   mail = prefs.getString('mail');
  //   _fillArray();
  // }

  _fillArray() {
    httpClient.getUserByMail(mail).then((res) {
      if (res != 'Error') {
        setState(() {
          user = new User(
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
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) => new CustomAlertDialog(
            title: new Text('Error message'),
            content: new Text('Check your network'),
            onOk: () {
              Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
            },
          )
        );
      }
    });
  }

  String _validationPassword(val) {
    if (val.length < 6) {
      return 'Password too short';
    }
    return null;
  }

  String _validationOther(val) {
    if (val.length < 1) {
      return 'Too short';
    }
    final RegExp exp = new RegExp(r'^[a-zA-Zа-яА-Я]');
    if (!exp.hasMatch(val)) {
      return 'Letters only';
    }
    return null;
  }

  _changeUser(String text, { bool password: false, bool firstName: false, bool lastName: false, bool city: false }) {
    String title = 'Change';

    User updateUser = new User();

    if (password) {
      title = 'Change password';
    } else if (firstName) {
      title = 'Change first name';
    } else if (lastName) {
      title = 'Change last name';
    } else if (city) {
      title = 'Change city';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) => new SystemPadding(
        child: new CustomAlertDialog(
          title: new Text(title),
          content: new Form(
            key: _formKey,
            autovalidate: true,
            child: new TextFormField(
              controller: _userController,
              decoration: new InputDecoration(
                hintText: text
              ),
              validator: (val) {
                if (password) {
                  return _validationPassword(val);
                } else {
                  return _validationOther(val);
                }
              },
            ),
          ),
          onCancel: () {
            Navigator.of(context).pop();
          },
          onOk: () {
            updateUser.mail = mail;
            if (password) {
              updateUser.password = _userController.text;
              updateUser.firstName = user.firstName;
              updateUser.lastName= user.lastName;
              updateUser.city = user.city;
            } else if (firstName) {
              updateUser.password = user.password;
              updateUser.firstName = _userController.text;
              updateUser.lastName= user.lastName;
              updateUser.city = user.city;
            } else if (lastName) {
              updateUser.password = user.password;
              updateUser.firstName = user.firstName;
              updateUser.lastName= _userController.text;
              updateUser.city = user.city;
            } else if (city) {
              updateUser.password = user.password;
              updateUser.firstName = user.firstName;
              updateUser.lastName= user.lastName;
              updateUser.city = _userController.text;
            }
            _updateUser(updateUser);
          },
        ),
      ),
    );
  }

  _updateUser(User updateUser) {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      Navigator.of(context).pop();
      setState(() {
        isLoaded = false;
      });
      httpClient.updateUser(updateUser).then((res) {
        _fillArray();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget lineProgress = new LinearProgressIndicator();

    return new Scaffold(
      appBar: new CustomNavigationBar(
        title: new Text(
          'Profile',
          style: new TextStyle(
            color: Colors.white,
          )
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        buttonBack: true,
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
                          'Mail: ' + user.mail
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
                        onTap: () {
                          _changeUser(user.password, password: true);
                        },
                      ),
                    ),
                    new Divider(),
                    new Container(
                      child: new ListTile(
                        title: new Text(
                          'First name: ' + user.firstName,
                        ),
                        trailing: new Icon(Icons.edit),
                        onTap: () {
                          _changeUser(user.firstName, firstName: true);
                        },
                      ),
                    ),
                    new Divider(),
                    new Container(
                      child: new ListTile(
                        title: new Text(
                          'Last name: ' + user.lastName,
                        ),
                        trailing: new Icon(Icons.edit),
                        onTap: () {
                          _changeUser(user.lastName, lastName: true);
                        },
                      ),
                    ),
                    new Divider(),
                    new Container(
                      child: new ListTile(
                        title: new Text(
                          'City: ' + user.city,
                        ),
                        trailing: new Icon(Icons.edit),
                        onTap: () {
                          _changeUser(user.city, city: true);
                        },
                      ),
                    ),
                    new Divider(),
                    new Container(
                      child: new ListTile(
                        title: new Text(
                          'Birthday: ${user.birthday.year.toString()}-${user.birthday.month.toString().padLeft(2, '0')}-${user.birthday.day.toString().padLeft(2, '0')}',
                        ),
                      ),
                    ),
                    new Divider(),
                    new Container(
                      child: new ListTile(
                        title: new Text(
                          'Sex: ' + (user.idSexs == 1 ? 'Мужской' : 'Женский'),
                        ),
                      ),
                    ),
                    new Divider(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ) : lineProgress,
    );
  }
}