// dart

// package
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class
import '../../models/models.dart';
import '../../modules/http.client.dart';
import '../../models/widget.models.dart';
import '../../modules/localizations.dart';

class ProfilePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {

  bool isLoaded = false;
  bool switchSelect = false;
  int languageVal = 1;
  User user;
  CustomHttpClient httpClient = new CustomHttpClient();
  DemoLocalizations local = new DemoLocalizations();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController _userController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _fillArray();
  }

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

  String _validationPassword(val) {
    if (val.length < 6) {
      return local.localizedValues[languageCode]['profilePage']['password']['password_invalid'];
    }
    return null;
  }

  String _validationOther(val) {
    if (val.length < 1) {
      return local.localizedValues[languageCode]['profilePage']['empty'];
    }
    final RegExp exp = new RegExp(r'^[a-zA-Zа-яА-Я]');
    if (!exp.hasMatch(val)) {
      return local.localizedValues[languageCode]['profilePage']['only_letters'];
    }
    return null;
  }

  _changeUser(String text, { bool password: false, bool firstName: false, bool lastName: false, bool city: false }) {
    String title;

    User updateUser = new User();

    if (password) {
      title = local.localizedValues[languageCode]['profilePage']['password']['password_title'];
    } else if (firstName) {
      title = local.localizedValues[languageCode]['profilePage']['first_name']['first_name_change'];
    } else if (lastName) {
      title = local.localizedValues[languageCode]['profilePage']['last_name']['last_name_change'];
    } else if (city) {
      title = local.localizedValues[languageCode]['profilePage']['city']['city_change'];
    }

    showDialog(
      context: context,
      child: new SystemPadding(
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
      )
    );
  }

  _updateUser(User updateUser) {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      _userController.clear();
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
          local.localizedValues[languageCode]['profilePage']['title_bar'],
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
                  children: <Widget>[
                    new Container(
                      child: new ListTile(
                        title: new Text(
                          '${local.localizedValues[languageCode]['profilePage']['email_title']}: ' + user.mail
                        ),
                      ),
                    ),
                    new Divider(),
                    new Container(
                      child: new ListTile(
                        title: new Text(
                          local.localizedValues[languageCode]['profilePage']['password']['password_title'],
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
                          '${local.localizedValues[languageCode]['profilePage']['first_name']['first_name_title']}: ' + user.firstName,
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
                          '${local.localizedValues[languageCode]['profilePage']['last_name']['last_name_title']}: ' + user.lastName,
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
                          '${local.localizedValues[languageCode]['profilePage']['city']['city_title']}: ' + user.city,
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
                          '${local.localizedValues[languageCode]['profilePage']['birthday_title']}: ${user.birthday.year.toString()}-${user.birthday.month.toString().padLeft(2, '0')}-${user.birthday.day.toString().padLeft(2, '0')}',
                        ),
                      ),
                    ),
                    new Divider(),
                    new Container(
                      child: new ListTile(
                        title: new Text(
                          '${local.localizedValues[languageCode]['profilePage']['sex']['sex_title']}: '
                          + (user.idSexs == 1 ? local.localizedValues[languageCode]['profilePage']['sex']['male']
                          : local.localizedValues[languageCode]['profilePage']['sex']['female']),
                        ),
                      ),
                    ),
                    new Divider(),
                    new Container(
                      child: new ListTile(
                        title: new Text(local.localizedValues[languageCode]['profilePage']['language_title'],
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            child: new RadioInDialog(),
                          );
                        },
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