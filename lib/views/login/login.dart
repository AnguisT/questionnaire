// package
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// class
import '../../models/models.dart';
import '../../modules/http.client.dart';

class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _LoginPage();
}

class _LoginPage extends State<LoginPage> {

  bool _autovalidate = false;
  CustomHttpClient httpClient = new CustomHttpClient();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool isDisabled = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  // _saveMail(mail) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('mail', mail);
  // }

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
              child: new AlertDialog(
                title: new Text('Error message'),
                content: new Text('Incorrect password or login'),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text('OK'),
                    onPressed: () {
                      setState(() {
                        isDisabled = false;
                      });
                      Navigator.of(context).pop();
                    },
                  )
                ],
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
            child: new AlertDialog(
              title: new Text('Error message'),
              content: new Text('Check your network'),
              actions: <Widget>[
                new FlatButton(
                  child: new Text('OK'),
                  onPressed: () {
                    setState(() {
                      isDisabled = false;
                    });
                    Navigator.of(context).pop();
                  },
                )
              ],
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
      return 'Not a valid email';
    }
    final RegExp cityExp = new RegExp(r'^[a-zA-Z]');
    if (!cityExp.hasMatch(val)) {
      return 'English letters only';
    }
    return null;
  }

  String _validationPassword(val) {
    if (val.length < 6) {
      return 'Password too short';
    }
    return null;
  }

  TextEditingController _mailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget scaffoldAndroid = new Scaffold(
      backgroundColor: Colors.blue,
      body: new SafeArea(
        top: false,
        bottom: false,
        left: false,
        right: false,
        child: new SingleChildScrollView(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                child: new Center(
                  child: new Text(
                    'Welcome to application Test Reisas',
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
                            labelText: 'E-mail',
                            labelStyle: new TextStyle(
                              color: Colors.white
                            ),
                            hintText: 'Enter you e-mail',
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
                            labelText: 'Password',
                            labelStyle: new TextStyle(
                              color: Colors.white
                            ),
                            hintText: 'Enter you password',
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
                height: 120.0,
                child: new Column(
                  children: <Widget>[
                    new Container(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 5.0, left: 10.0, right: 10.0),
                      width: MediaQuery.of(context).size.width,
                      child: new RaisedButton(
                        child: new Text('Log In'),
                        color: Colors.white,
                        textColor: Colors.blue,
                        onPressed: !isDisabled ? logIn : null,
                      ),
                    ),
                    new Container(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 10.0, left: 10.0, right: 10.0),
                      width: MediaQuery.of(context).size.width,
                      child: new RaisedButton(
                        child: new Text('Sign Up'),
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

    return scaffoldAndroid;
  }
}
