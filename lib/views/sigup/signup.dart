import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../modules/http.client.dart';
import '../../models/models.dart';

class SignupPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _SignupPage();
}

class _SignupPage extends State<SignupPage> {

  HttpClient httpClient = new HttpClient();
  User user = new User();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool _autovalidate = false;
  bool isDisabled = false;
  int radioValue = 1;

  @override
  void initState() {
    super.initState();
    user.idSexs = radioValue;
  }

  String _validationEmail(val) {
    if (!val.contains('@')) {
      return 'Not a valid email.';
    }
    return null;
  }

  String _validationPassword(val) {
    if (val.length < 6) {
      return 'Password too short.';
    }
    return null;
  }

  String _validationFirstName(val) {
    if (val.length < 1) {
      return 'You did not enter your first name.';
    }
    return null;
  }

  String _validationLastName(val) {
    if (val.length < 1) {
      return 'You did not enter your last name.';
    }
    return null;
  }

  String _validationCity(val) {
    if (val.length < 1) {
      return 'You did not enter your city.';
    }
    return null;
  }

  String _validationBirthday(String val) {
    final RegExp birthdayExp = new RegExp(r'^\d{4}-\d{2}-\d{2}$');
    if (!birthdayExp.hasMatch(val)) {
      return 'yyyy-mm-dd - Please enter a valid date.';
    }
    var date = DateTime.parse(val);
    var start = val.indexOf('-');
    var end = val.lastIndexOf('-');
    var yyyy = int.parse(val.substring(0, start));
    var mm = int.parse(val.substring(start + 1, end));
    var dd = int.parse(val.substring(end + 1, val.length));
    if (yyyy != date.year || mm != date.month || dd != date.day) {
      return 'Sorry there is no such date';
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
        if (val['isLogup'] == false) {
          showDialog(
            context: context,
            child: new AlertDialog(
              title: new Text('Error message'),
              content: new Text(val['message']),
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
          Navigator.of(context).pop();
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
      appBar: new AppBar(
        backgroundColor: Colors.blue[500], //grey[10],
        title: new Text('Sign up', style: new TextStyle(color: Colors.white),),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new Container(
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
                        labelText: 'E-mail',
                        labelStyle: new TextStyle(
                          color: Colors.white
                        ),
                        hintText: 'Enter your e-mail',
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
                        labelText: 'Password',
                        labelStyle: new TextStyle(
                          color: Colors.white
                        ),
                        hintText: 'Enter your password',
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
                        labelText: 'First name',
                        labelStyle: new TextStyle(
                          color: Colors.white
                        ),
                        hintText: 'Enter your first name',
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
                        labelText: 'Last name',
                        labelStyle: new TextStyle(
                          color: Colors.white
                        ),
                        hintText: 'Enter your last name',
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
                        labelText: 'Birthday',
                        labelStyle: new TextStyle(
                          color: Colors.white
                        ),
                        hintText: 'Enter your birthday',
                        hintStyle: new TextStyle(
                          color: Colors.white
                        ),
                        helperText: 'Format date: yyyy-mm-dd',
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
                        labelText: 'City',
                        labelStyle: new TextStyle(
                          color: Colors.white
                        ),
                        hintText: 'Enter your city',
                        hintStyle: new TextStyle(
                          color: Colors.white
                        ),
                      ),
                      validator: _validationCity,
                      onSaved: (val) => user.city = val,
                    )
                  ],
                )
              )
            ),
            new Container(
              child: new Row(
                children: <Widget>[
                  new Container(
                    width: MediaQuery.of(context).size.width / 2,
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
                          'Мужской',
                          style: new TextStyle(color: Colors.white)
                        )
                      ],
                    )
                  ),
                  new Container(
                    width: MediaQuery.of(context).size.width / 2,
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
                          'Женский',
                          style: new TextStyle(color: Colors.white)
                        )
                      ],
                    )
                  ),
                ]
              )
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0, bottom: 10.0),
              child: new RaisedButton(
                color: Colors.white,
                textColor: Colors.blue,
                child: new Text('Sign up'),
                onPressed: !isDisabled ? _signUp : null,
              )
            ),
          ],
        ),
      ),
    );

    return body;
  }
}