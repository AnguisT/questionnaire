import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../modules/http.client.dart';

class QuestionPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _QuestionPage();
}

class _QuestionPage extends State<QuestionPage> {

  String title = 'Question';
  String description = 'Description';
  HttpClient httpClient = new HttpClient();
  int groupValue = 0;
  bool isLoaded = false;
  List<Question> questionArray = [];
  List<Answer> answerArray = [];
  int index = 0;
  List<ArrayResult> resultArray = [];

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
          questionArray.last.answers = answerArray;
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
    }).catchError((error) {
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

  clickBtnFinish(BuildContext context) {
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
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/result');
            },
          )
        ],
      )
    );
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
        onPressed: _pressedNext,
      ),
    );

    Widget btnFinish = new Container(
      width: MediaQuery.of(context).size.width / 2 - 10,
      padding: const EdgeInsets.only(top: 10.0, left: 5.0),
      child: new RaisedButton(
        color: Colors.blue,
        child: new Text('Finish the test', style: new TextStyle(color: Colors.white),),
        onPressed: clickBtnFinish(context)
      ),
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title, style: new TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: new Text(
              isLoaded ? (index + 1).toString() + '/' + questionArray.length.toString() : '',
              style: new TextStyle(color: Colors.white),
            )
          ),
        ],
      ),
      body: isLoaded ? new Container(
        padding: const EdgeInsets.all(10.0),
        child: new Column(
          children: <Widget>[
            new Expanded(
              child: new Column(
                children: <Widget>[
                  new Container(
                    width: MediaQuery.of(context).size.width,
                    child: new Text(questionArray[index].description, style: new TextStyle(fontSize: 17.0)),
                  ),
                  new Container(
                    child: new Row(
                      children: <Widget>[
                        new Radio<int>(
                          groupValue: groupValue,
                          value: 1,
                          onChanged: _pressRadioButton,
                        ),
                        new Text(questionArray[index].answers[0].title)
                      ],
                    )
                  ),
                  new Container(
                    child: new Row(
                      children: <Widget>[
                        new Radio<int>(
                          groupValue: groupValue,
                          value: 2,
                          onChanged: _pressRadioButton,
                        ),
                        new Text(questionArray[index].answers[1].title)
                      ],
                    )
                  ),
                  new Container(
                    child: new Row(
                      children: <Widget>[
                        new Radio<int>(
                          groupValue: groupValue,
                          value: 3,
                          onChanged: _pressRadioButton,
                        ),
                        new Text(questionArray[index].answers[2].title)
                      ],
                    )
                  ),
                  new Container(
                    child: new Row(
                      children: <Widget>[
                        new Radio<int>(
                          groupValue: groupValue,
                          value: 4,
                          onChanged: _pressRadioButton,
                        ),
                        new Text(questionArray[index].answers[3].title)
                      ],
                    )
                  ),
                  new Container(
                    child: new Row(
                      children: <Widget>[
                        new Radio<int>(
                          groupValue: groupValue,
                          value: 5,
                          onChanged: _pressRadioButton,
                        ),
                        new Text(questionArray[index].answers[4].title)
                      ],
                    )
                  ),
                  new Container(
                    child: new Row(
                      children: <Widget>[
                        new Radio<int>(
                          groupValue: groupValue,
                          value: 6,
                          onChanged: _pressRadioButton,
                        ),
                        new Text(questionArray[index].answers[5].title)
                      ],
                    )
                  ),
                ],
              ),
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
      ) : lineProgress,
    );
  }
}