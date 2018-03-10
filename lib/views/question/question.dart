// dart
import 'dart:async';

// package
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// class
import '../../modules/http.client.dart';
import '../../models/models.dart';

class QuestionPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _QuestionPage();
}

class _QuestionPage extends State<QuestionPage> {

  String title = 'Question';
  String description = 'Description';
  String mail = '';
  int groupValue = 0;
  int index = 0;
  int resultEnd = 0;
  int seconds = 0;
  int minutes = 0;
  bool isLoaded = false;
  List<Question> questionArray = [];
  List<Answer> answerArray = [];
  List<ArrayResult> resultArray = [];
  CustomHttpClient httpClient = new CustomHttpClient();
  Timer timer;

  @override
  void initState() {
    super.initState();
    httpClient.getAllQuestion().then((res) {
      for (var i = 0; i < res['questions'].length; i++) {
        Answer answer;
        if (questionArray.isNotEmpty && questionArray.last.idQuestion == res['questions'][i]['id_question']) {
          answer = new Answer(
            idAnswer: res['questions'][i]['id_answer'],
            indexAnswer: res['questions'][i]['index_answer'],
            title: res['questions'][i]['title'],
            weight: res['questions'][i]['weight']
          );
          answerArray.add(answer);
          if (questionArray.last.answers.isNotEmpty) {
            questionArray.last.answers.clear();
          }
          questionArray.last.answers.addAll(answerArray);
        } else {
          answerArray.clear();
          answer = new Answer(
            idAnswer: res['questions'][i]['id_answer'],
            indexAnswer: res['questions'][i]['index_answer'],
            title: res['questions'][i]['title'],
            weight: res['questions'][i]['weight']
          );
          answerArray.add(answer);
          Question question = new Question(
            idQuestion: res['questions'][i]['id_question'],
            description: res['questions'][i]['description'],
            answers: []
          );
          questionArray.add(question);
          ArrayResult arrayResult = new ArrayResult(
            idQuestion: res['questions'][i]['id_question'],
          );
          resultArray.add(arrayResult);
        }
      }
      setState(() {
        isLoaded = true;
      });
      _startTimer();
    }).catchError((error) {
      print(error);
      showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text('Error message'),
          content: new Text('Check your network'),
          actions: <Widget>[
            new FlatButton(
              child: new Text('OK'),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/test');
              },
            )
          ],
        )
      );
    });
  }

  _startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(oneSec, (Timer t) {
      setState(() {
        Duration dur = new Duration(seconds: seconds);
        if (dur.inSeconds < 59) {
          seconds += 1;
        } else {
          minutes++;
          seconds = 0;
        }
      });
    });
  }

  _pressedNext() {
    setState(() {
      index++;
    });
    setState(() {
      if (resultArray[index].idAnswer == null) {
        groupValue = 0;
      } else {
        questionArray[index].answers.forEach((Answer answer) {
          if (answer.idAnswer == resultArray[index].idAnswer) {
            groupValue = answer.indexAnswer;
          }
        });
      }
    });
  }

  _pressedBack() {
    setState(() {
      index--;
    });
    setState(() {
      if (resultArray[index].idAnswer == null) {
        groupValue = 0;
      } else {
        questionArray[index].answers.forEach((Answer answer) {
          if (answer.idAnswer == resultArray[index].idAnswer) {
            groupValue = answer.indexAnswer;
          }
        });
      }
    });
  }

  _pressRadioButton(value) {
    setState(() {
      groupValue = value;
    });
    resultArray[index].idAnswer = questionArray[index].answers[value - 1].idAnswer;
  }

  _clickBtnFinish() {
    showDialog(
      context: context,
      child: new AlertDialog(
        content: new Text('Do you really want to finish the test?'),
        actions: <Widget>[
          new FlatButton(
            child: new Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          new FlatButton(
            child: new Text('OK'),
            onPressed: _calculateResultAndSave,
          )
        ],
      )
    );
  }

  _calculateResultAndSave() async {
    timer.cancel();
    Navigator.of(context).pop();

    setState(() {
      title = 'Wait, goes is a counting points';
      isLoaded = false;
    });

    resultEnd = 0;
    for (int i = 0; i < questionArray.length; i++) {
      questionArray[i].answers.forEach((answer) {
        if (answer.idAnswer == resultArray[i].idAnswer) {
          resultEnd += answer.weight;
        }
      });
    }

    await _saveResult();
    await _getMial();

    DateTime now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String date = formatter.format(now);

    Duration countTime = new Duration(minutes: minutes, seconds: seconds);
    httpClient.saveResult(resultArray, mail, 1, date, resultEnd, countTime.inSeconds).then((res) {
      TotalOptionsResponse totalOptionsResponse = new TotalOptionsResponse(
        numberPoint: res['number_point'],
        totalOptions: []
      );
      TotalOptions totalOptions = new TotalOptions(
        fromValues: res['total_options'][0]['from_values'],
        toValues: res['total_options'][0]['to_values'],
        description: res['total_options'][0]['description'],
        title: res['total_options'][0]['title']
      );
      totalOptionsResponse.totalOptions.add(totalOptions);
      response = totalOptionsResponse;
      Navigator.of(context).pushReplacementNamed('/result');
    }).catchError((error) {
      print(error);
      showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text('Error message'),
          content: new Text('Check your network'),
          actions: <Widget>[
            new FlatButton(
              child: new Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        )
      );
    });
  }

  _saveResult() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('resultEnd', resultEnd);
  }

  _getMial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mail = prefs.getString('mail');
  }

  @override
  Widget build(BuildContext context) {
    Widget lineProgress = new LinearProgressIndicator();

    Widget btnBack = new Container(
      width: MediaQuery.of(context).size.width / 2 - 10,
      padding: const EdgeInsets.only(top: 10.0, right: 5.0),
      child: new RaisedButton(
        color: Colors.blue,
        child: new Text('Back', style: new TextStyle(color: Colors.white),),
        onPressed: index == 0 ? null : _pressedBack,
      ),
    );

    Widget btnNext = new Container(
      width: MediaQuery.of(context).size.width / 2 - 10,
      padding: const EdgeInsets.only(top: 10.0, left: 5.0),
      child: new RaisedButton(
        color: Colors.blue,
        child: new Text('Next', style: new TextStyle(color: Colors.white),),
        onPressed: groupValue != 0 ? _pressedNext : null,
      ),
    );

    Widget btnFinish = new Container(
      width: MediaQuery.of(context).size.width / 2 - 10,
      padding: const EdgeInsets.only(top: 10.0, left: 5.0),
      child: new RaisedButton(
        color: Colors.blue,
        child: new Text('Finish the test', style: new TextStyle(color: Colors.white),),
        onPressed: groupValue != 0 ? _clickBtnFinish : null,
      ),
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title, style: new TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: new Container(
          padding: const EdgeInsets.only(top: 18.0, left: 10.0),
          child: new Text(
            isLoaded ? minutes.toString().padLeft(2, '0') + ':' + seconds.toString().padLeft(2, '0') : '',
            style: new TextStyle(color: Colors.white),
          )
        ),
        actions: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(top: 18.0, right: 10.0),
            child: new Text(
              isLoaded ? (index + 1).toString() + '/' + questionArray.length.toString() : '',
              style: new TextStyle(color: Colors.white),
            )
          ),
        ],
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
                child: new SingleChildScrollView(
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        width: MediaQuery.of(context).size.width,
                        child: new Text(questionArray[index].description, style: new TextStyle(fontSize: 17.0)),
                      ),
                      new GestureDetector(
                        child: new Container(
                          child: new Row(
                            children: <Widget>[
                              new Radio<int>(
                                groupValue: groupValue,
                                value: 1,
                                onChanged: _pressRadioButton,
                              ),
                              new Text(questionArray[index].answers[0].title)
                            ],
                          ),
                          decoration: new BoxDecoration(
                            color: Theme.of(context).canvasColor,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            groupValue = 1;
                          });
                          resultArray[index].idAnswer = questionArray[index].answers[1 - 1].idAnswer;
                        },
                      ),
                      new GestureDetector(
                        child: new Container(
                          child: new Row(
                            children: <Widget>[
                              new Radio<int>(
                                groupValue: groupValue,
                                value: 2,
                                onChanged: _pressRadioButton,
                              ),
                              new Text(questionArray[index].answers[1].title)
                            ],
                          ),
                          decoration: new BoxDecoration(
                            color: Theme.of(context).canvasColor,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            groupValue = 2;
                          });
                          resultArray[index].idAnswer = questionArray[index].answers[2 - 1].idAnswer;
                        },
                      ),
                      new GestureDetector(
                        child: new Container(
                          child: new Row(
                            children: <Widget>[
                              new Radio<int>(
                                groupValue: groupValue,
                                value: 3,
                                onChanged: _pressRadioButton,
                              ),
                              new Text(questionArray[index].answers[2].title)
                            ],
                          ),
                          decoration: new BoxDecoration(
                            color: Theme.of(context).canvasColor,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            groupValue = 3;
                          });
                          resultArray[index].idAnswer = questionArray[index].answers[3 - 1].idAnswer;
                        },
                      ),
                      new GestureDetector(
                        child: new Container(
                          child: new Row(
                            children: <Widget>[
                              new Radio<int>(
                                groupValue: groupValue,
                                value: 4,
                                onChanged: _pressRadioButton,
                              ),
                              new Text(questionArray[index].answers[3].title)
                            ],
                          ),
                          decoration: new BoxDecoration(
                            color: Theme.of(context).canvasColor,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            groupValue = 4;
                          });
                          resultArray[index].idAnswer = questionArray[index].answers[4 - 1].idAnswer;
                        },
                      ),
                      new GestureDetector(
                        child: new Container(
                          // height: 100.0,
                          width: MediaQuery.of(context).size.width,
                          child: new Row(
                            children: <Widget>[
                              new Radio<int>(
                                groupValue: groupValue,
                                value: 5,
                                onChanged: _pressRadioButton,
                              ),
                              new Text(questionArray[index].answers[4].title)
                            ],
                          ),
                          decoration: new BoxDecoration(
                            color: Theme.of(context).canvasColor,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            groupValue = 5;
                          });
                          resultArray[index].idAnswer = questionArray[index].answers[5 - 1].idAnswer;
                        },
                      ),
                      new GestureDetector(
                        child: new Container(
                          child: new Row(
                            children: <Widget>[
                              new Radio<int>(
                                groupValue: groupValue,
                                value: 6,
                                onChanged: _pressRadioButton,
                              ),
                              new Text(questionArray[index].answers[5].title)
                            ],
                          ),
                          decoration: new BoxDecoration(
                            color: Theme.of(context).canvasColor,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            groupValue = 6;
                          });
                          resultArray[index].idAnswer = questionArray[index].answers[6 - 1].idAnswer;
                        },
                      ),
                    ],
                  ),
                )
              ),
              new Container(
                width: MediaQuery.of(context).size.width,
                child: new Row(
                  children: <Widget>[
                    btnBack,
                    index == questionArray.length - 1 ? btnFinish : btnNext
                  ],
                )
              ),
            ],
          )
        )
      ) : lineProgress,
    );
  }
}