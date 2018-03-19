// package
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// class
import '../../models/widget.models.dart';
import '../../modules/http.client.dart';
import '../../models/models.dart';
import '../../modules/localizations.dart';

class SignupPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _SignupPage();
}

class _SignupPage extends State<SignupPage> {

  int radioValue = 1;
  bool isDisabled = false;
  bool _autovalidate = false;
  User user = new User();
  CustomHttpClient httpClient = new CustomHttpClient();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  DemoLocalizations local = new DemoLocalizations();

  @override
  void initState() {
    super.initState();
    user.idSexs = radioValue;
  }

  String _validationEmail(val) {
    if (!val.contains('@')) {
      return local.localizedValues[languageCode]['signupPage']['email']['email_invalid'];
    }
    return null;
  }

  String _validationPassword(val) {
    if (val.length < 6) {
      return local.localizedValues[languageCode]['signupPage']['password']['password_invalid'];
    }
    return null;
  }

  String _validationFirstName(val) {
    if (val.length < 1) {
      return local.localizedValues[languageCode]['signupPage']['first_name']['first_name_invalid'];
    }
    final RegExp firstNameExp = new RegExp(r'^[a-zA-Zа-яА-Я]');
    if (!firstNameExp.hasMatch(val)) {
      return local.localizedValues[languageCode]['signupPage']['first_name']['first_name_invalid_letters'];
    }
    return null;
  }

  String _validationLastName(val) {
    if (val.length < 1) {
      return local.localizedValues[languageCode]['signupPage']['last_name']['last_name_invalid'];
    }
    final RegExp lastNameExp = new RegExp(r'^[a-zA-Zа-яА-Я]');
    if (!lastNameExp.hasMatch(val)) {
      return local.localizedValues[languageCode]['signupPage']['last_name']['last_name_invalid_letters'];
    }
    return null;
  }

  String _validationCity(val) {
    if (val.length < 1) {
      return local.localizedValues[languageCode]['signupPage']['city']['city_invalid'];
    }
    final RegExp cityExp = new RegExp(r'^[a-zA-Zа-яА-Я]');
    if (!cityExp.hasMatch(val)) {
      return local.localizedValues[languageCode]['signupPage']['city']['city_invalid_letters'];
    }
    return null;
  }

  String _validationBirthday(String val) {
    final RegExp birthdayExp = new RegExp(r'^\d{4}-\d{2}-\d{2}$');
    if (!birthdayExp.hasMatch(val)) {
      return local.localizedValues[languageCode]['signupPage']['birthday']['birthday_format_invalid'];
    }
    var date = DateTime.parse(val);
    var start = val.indexOf('-');
    var end = val.lastIndexOf('-');
    var yyyy = int.parse(val.substring(0, start));
    var mm = int.parse(val.substring(start + 1, end));
    var dd = int.parse(val.substring(end + 1, val.length));
    if (yyyy != date.year || mm != date.month || dd != date.day) {
      return local.localizedValues[languageCode]['signupPage']['birthday']['birthday_date_invalid'];
    }
    user.birthday = date;
    return null;
  }

  _signUp() {
    final FormState form = _formKey.currentState;
    _autovalidate = true;
    if (form.validate()) {
      form.save();
      setState(() {
        isDisabled = true;
      });
      httpClient.signUp(user).then((val) {
        if (val != 'Error') {
          if (val['isLogup'] == false) {
            showDialog(
              context: context,
              child: new CustomAlertDialog(
                content: new Text(local.localizedValues[languageCode]['errorMessage']['email_exist']),
                onOk: () {
                  setState(() {
                    isDisabled = false;
                  });
                  Navigator.of(context).pop();
                },
              )
            );
          } else {
            Navigator.of(context).pop();
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

  TextEditingController _mailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _birthdayController = new TextEditingController();
  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _cityController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var body = new Scaffold(
      backgroundColor: Colors.blue,
      appBar: new CustomNavigationBar(
        backgroundColor: Colors.blue[500],
        title: new Text(local.localizedValues[languageCode]['signupPage']['title_bar'], style: new TextStyle(color: Colors.white),),
        centerTitle: true,
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: new SafeArea(
        top: true,
        bottom: true,
        left: true,
        right: true,
        child: new Column(
          children: <Widget>[
            new Expanded(
              child: new SingleChildScrollView(
                child: new Container(
                  padding: const EdgeInsets.all(10.0),
                  child: new Form(
                    key: _formKey,
                    autovalidate: _autovalidate,
                    child: new Column(
                      children: <Widget>[
                        new TextFormField(
                          controller: _mailController,
                          keyboardType: TextInputType.emailAddress,
                          style: new TextStyle(
                            color: Colors.white
                          ),
                          decoration: new InputDecoration(
                            icon: const Icon(Icons.email),
                            labelText: local.localizedValues[languageCode]['signupPage']['email']['email_label'],
                            labelStyle: new TextStyle(
                              color: Colors.white
                            ),
                            hintText: local.localizedValues[languageCode]['signupPage']['email']['email_hint'],
                            hintStyle: new TextStyle(
                              color: Colors.white
                            ),
                          ),
                          validator: _validationEmail,
                          onSaved: (val) => user.mail = val,
                        ),
                        new TextFormField(
                          controller: _passwordController,
                          style: new TextStyle(
                            color: Colors.white
                          ),
                          decoration: new InputDecoration(
                            icon: const Icon(Icons.security),
                            labelText: local.localizedValues[languageCode]['signupPage']['password']['password_label'],
                            labelStyle: new TextStyle(
                              color: Colors.white
                            ),
                            hintText: local.localizedValues[languageCode]['signupPage']['password']['password_hint'],
                            hintStyle: new TextStyle(
                              color: Colors.white
                            ),
                          ),
                          validator: _validationPassword,
                          onSaved: (val) => user.password = val,
                          obscureText: true,
                        ),
                        new TextFormField(
                          controller: _firstNameController,
                          keyboardType: TextInputType.text,
                          style: new TextStyle(
                            color: Colors.white
                          ),
                          decoration: new InputDecoration(
                            icon: const Icon(Icons.people),
                            labelText: local.localizedValues[languageCode]['signupPage']['first_name']['first_name_label'],
                            labelStyle: new TextStyle(
                              color: Colors.white
                            ),
                            hintText: local.localizedValues[languageCode]['signupPage']['first_name']['first_name_hint'],
                            hintStyle: new TextStyle(
                              color: Colors.white
                            ),
                          ),
                          validator: _validationFirstName,
                          onSaved: (val) => user.firstName = val,
                        ),
                        new TextFormField(
                          controller: _lastNameController,
                          keyboardType: TextInputType.text,
                          style: new TextStyle(
                            color: Colors.white
                          ),
                          decoration: new InputDecoration(
                            icon: const Icon(Icons.people_outline),
                            labelText: local.localizedValues[languageCode]['signupPage']['last_name']['last_name_label'],
                            labelStyle: new TextStyle(
                              color: Colors.white
                            ),
                            hintText: local.localizedValues[languageCode]['signupPage']['last_name']['last_name_hint'],
                            hintStyle: new TextStyle(
                              color: Colors.white
                            ),
                          ),
                          validator: _validationLastName,
                          onSaved: (val) => user.lastName = val,
                        ),
                        new TextFormField(
                          controller: _birthdayController,
                          keyboardType: TextInputType.number,
                          style: new TextStyle(
                            color: Colors.white
                          ),
                          decoration: new InputDecoration(
                            icon: const Icon(Icons.date_range),
                            labelText: local.localizedValues[languageCode]['signupPage']['birthday']['birthday_label'],
                            labelStyle: new TextStyle(
                              color: Colors.white
                            ),
                            hintText: local.localizedValues[languageCode]['signupPage']['birthday']['birthday_hint'],
                            hintStyle: new TextStyle(
                              color: Colors.white
                            ),
                            helperText: local.localizedValues[languageCode]['signupPage']['birthday']['birthday_helper'],
                            helperStyle: new TextStyle(
                              color: Colors.white
                            )
                          ),
                          validator: _validationBirthday,
                          // onSaved: (val) => user. = val,
                        ),
                        new TextFormField(
                          controller: _cityController,
                          keyboardType: TextInputType.text,
                          style: new TextStyle(
                            color: Colors.white
                          ),
                          decoration: new InputDecoration(
                            icon: const Icon(Icons.location_city),
                            labelText: local.localizedValues[languageCode]['signupPage']['city']['city_label'],
                            labelStyle: new TextStyle(
                              color: Colors.white
                            ),
                            hintText: local.localizedValues[languageCode]['signupPage']['city']['city_hint'],
                            hintStyle: new TextStyle(
                              color: Colors.white
                            ),
                          ),
                          validator: _validationCity,
                          onSaved: (val) => user.city = val,
                        ),
                        new Container(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: new Row(
                            children: <Widget>[
                              new Container(
                                decoration: new BoxDecoration(
                                  color: Colors.blue,
                                ),
                                width: MediaQuery.of(context).size.width / 2 - 10.0,
                                child: new GestureDetector(
                                  child: new Row(
                                    children: <Widget>[
                                      new Radio<int>(
                                        groupValue: radioValue,
                                        value: 1,
                                        activeColor: Colors.white,
                                        onChanged: (int value) {
                                          user.idSexs = value;
                                          setState(() {
                                            radioValue = value;
                                          });
                                        },
                                      ),
                                      new Text(
                                        local.localizedValues[languageCode]['signupPage']['sex']['male'],
                                        style: new TextStyle(color: Colors.white)
                                      )
                                    ],
                                  ),
                                  onTap: () {
                                    user.idSexs = 1;
                                    setState(() {
                                      radioValue = 1;
                                    });
                                  }
                                ),
                              ),
                              new Container(
                                decoration: new BoxDecoration(
                                  color: Colors.blue,
                                ),
                                width: MediaQuery.of(context).size.width / 2 - 10.0,
                                child: new GestureDetector(
                                  child: new Row(
                                    children: <Widget>[
                                      new Radio<int>(
                                        groupValue: radioValue,
                                        value: 2,
                                        activeColor: Colors.white,
                                        onChanged: (int value) {
                                          user.idSexs = value;
                                          setState(() {
                                            radioValue = value;
                                          });
                                        },
                                      ),
                                      new Text(
                                        local.localizedValues[languageCode]['signupPage']['sex']['female'],
                                        style: new TextStyle(color: Colors.white)
                                      )
                                    ],
                                  ),
                                  onTap: () {
                                    user.idSexs = 2;
                                    setState(() {
                                      radioValue = 2;
                                    });
                                  },
                                ),
                              ),
                            ]
                          )
                        ),
                        new Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0, bottom: 10.0),
                          child: new CustomButton(
                            color: Colors.white,
                            textColor: Colors.blue,
                            text: local.localizedValues[languageCode]['signupPage']['sign_up'],
                            onPressed: !isDisabled ? _signUp : null,
                          )
                        ),
                      ],
                    )
                  )
                ),
              )
            ),
          ],
        ),
      )
    );

    return body;
  }
}