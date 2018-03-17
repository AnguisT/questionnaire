// package
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// class
import '../../models/models.dart';
import '../../modules/http.client.dart';
import '../../models/widget.models.dart';
import '../../modules/localizations.dart';

class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _LoginPage();
}

class _LoginPage extends State<LoginPage> {

  bool isDisabled = false;
  bool _autovalidate = false;
  CustomHttpClient httpClient = new CustomHttpClient();
  DemoLocalizations local = new DemoLocalizations();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  logIn() async {
    final FormState form = _formKey.currentState;
    _autovalidate = true;
    if (form.validate()) {
      setState(() {
        isDisabled = true;
      });
      form.save();
      await httpClient.logIn(_mailController.text, _passwordController.text).then((res) async {
        if (res != 'Error') {
          if (res['user'].length == 0) {
            showDialog(
              context: context,
              child: new CustomAlertDialog(
                title: new Text(local.localizedValues[languageCode]['errorMessage']['error_title']),
                content: new Text(local.localizedValues[languageCode]['errorMessage']['incorrect_password_mail']),
                onOk: () {
                  setState(() {
                    isDisabled = false;
                  });
                  Navigator.of(context).pop();
                },
              )
            );
          } else {
            mail = res['user'][0]['mail'];
            firstNameForHomePage = res['user'][0]['first_name'];
            Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
          }
        } else {
          showDialog(
            context: context,
            child: new CustomAlertDialog(
              title: new Text(local.localizedValues[languageCode]['errorMessage']['error_title']),
              content: new Text(local.localizedValues[languageCode]['errorMessage']['error_message']),
              onOk: () {
                setState(() {
                  isDisabled = false;
                });
                Navigator.of(context).pop();
              },
            )
          );
        }
      });
    }
  }

  signUp() {
    Navigator.of(context).pushNamed('/signup');
  }

  String _validationEmail(val) {
    if (!val.contains('@')) {
      return local.localizedValues[languageCode]['loginPage']['email']['email_invalid'];
    }
    return null;
  }

  String _validationPassword(val) {
    if (val.length < 6) {
      return local.localizedValues[languageCode]['loginPage']['password']['password_invalid'];
    }
    return null;
  }

  TextEditingController _mailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.blue,
      body: new SafeArea(
        top: true,
        bottom: true,
        left: true,
        right: true,
        child: new SingleChildScrollView(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 3,
                child: new Center(
                  child: new Text(
                    local.localizedValues[languageCode]['loginPage']['title'],
                    style: new TextStyle(
                      fontSize: 30.0,
                      color: Colors.white
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ),
              new Container(
                padding: const EdgeInsets.all(10.0),
                child: new Form(
                  key: _formKey,
                  autovalidate: _autovalidate,
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        child: new TextFormField(
                          controller: _mailController,
                          keyboardType: TextInputType.emailAddress,
                          style: new TextStyle(
                            color: Colors.white
                          ),
                          decoration: new InputDecoration(
                            icon: const Icon(Icons.email),
                            labelText: local.localizedValues[languageCode]['loginPage']['email']['email_label'],
                            labelStyle: new TextStyle(
                              color: Colors.white
                            ),
                            hintText: local.localizedValues[languageCode]['loginPage']['email']['email_hint'],
                            hintStyle: new TextStyle(
                              color: Colors.white
                            ),
                          ),
                          validator: _validationEmail,
                        ),
                      ),
                      new Container(
                        child: new TextFormField(
                          controller: _passwordController,
                          style: new TextStyle(
                            color: Colors.white
                          ),
                          decoration: new InputDecoration(
                            icon: const Icon(Icons.security),
                            labelText: local.localizedValues[languageCode]['loginPage']['password']['password_label'],
                            labelStyle: new TextStyle(
                              color: Colors.white
                            ),
                            hintText: local.localizedValues[languageCode]['loginPage']['password']['password_hint'],
                            hintStyle: new TextStyle(
                              color: Colors.white
                            )
                          ),
                          obscureText: true,
                          validator: _validationPassword,
                        ),
                      )
                    ]
                  ),
                ),
              ),
              new Container(
                height: 150.0,
                child: new Column(
                  children: <Widget>[
                    new Container(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 5.0, left: 10.0, right: 10.0),
                      width: MediaQuery.of(context).size.width,
                      child: new CustomButton(
                        text: local.localizedValues[languageCode]['loginPage']['log_in'],
                        color: Colors.white,
                        textColor: Colors.blue,
                        onPressed: !isDisabled ? logIn : null,
                      ),
                    ),
                    new Container(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 10.0, left: 10.0, right: 10.0),
                      width: MediaQuery.of(context).size.width,
                      child: new CustomButton(
                        text: local.localizedValues[languageCode]['loginPage']['sign_up'],
                        color: Colors.white,
                        textColor: Colors.blue,
                        onPressed: !isDisabled ? signUp : null,
                      )
                    ),
                  ],
                )
              ),
            ],
          )
        )
      )
    );
  }
}
