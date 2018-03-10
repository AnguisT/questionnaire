// package
import 'package:flutter/material.dart';

// class
import './views/login/login.dart';
import './views/home/home.dart';
import './views/sigup/signup.dart';
import './views/test/test.dart';
import './views/question/question.dart';
import './views/statistic/statistic.dart';
import './views/result/result.dart';
import './views/total.option/total.option.dart';

void main() {
  runApp(
    new MaterialApp(
      title: 'Questionnaire',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      routes: <String, WidgetBuilder> {
        '/': (BuildContext context) => new LoginPage(),
        '/home': (BuildContext context) => new HomePage(),
        '/signup': (BuildContext context) => new SignupPage(),
        '/test': (BuildContext context) => new TestPage(),
        '/question': (BuildContext context) => new QuestionPage(),
        '/statistics': (BuildContext context) => new StatisticPage(),
        '/result': (BuildContext context) => new ResultPage(),
        '/total': (BuildContext context) => new TotalOptionPage()
      },
    )
  );
}