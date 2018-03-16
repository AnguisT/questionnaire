// package
import 'package:flutter/material.dart';

// class
import './views/home/home.dart';
import './views/test/test.dart';
import './views/login/login.dart';
import './views/sigup/signup.dart';
import './views/result/result.dart';
import './views/profile/profile.dart';
import './views/question/question.dart';
import './views/statistics/statistics.dart';
import './views/statistics/desc.statistics.dart';
import './views/total.options/total.options.dart';

void main() {
  runApp(
    new MaterialApp(
      title: 'Test Reisas',
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
        '/statistics': (BuildContext context) => new StatisticsPage(),
        '/result': (BuildContext context) => new ResultPage(),
        '/totaloptions': (BuildContext context) => new TotalOptionsPage(),
        '/profile': (BuildContext context) => new ProfilePage(),
        '/descstatistics': (BuildContext context) => new DescStatisticsPage(),
      },
    )
  );
}