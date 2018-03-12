TotalOptionsResponse response;
Statistics descStatistics;
String mail;
int resultEndModels;

class User {
  User({
    this.mail,
    this.password,
    this.birthday,
    this.idSexs,
    this.firstName,
    this.lastName,
    this.city
  });

  String mail;
  String password;
  DateTime birthday;
  int idSexs;
  String firstName;
  String lastName;
  String city;
}

class Sexs {
  Sexs({
    this.idSexs,
    this.name
  }) : assert(idSexs != null && name != null);

  int idSexs;
  String name;
}

class Question {
  Question({
    this.idQuestion,
    this.description,
    this.answers
  }) : assert(idQuestion != null && description != null && answers != null);

  int idQuestion;
  String description;
  List<Answer> answers;
}

class Answer {
  Answer({
    this.idAnswer,
    this.indexAnswer,
    this.title,
    this.weight
  }) : assert(idAnswer != null && indexAnswer != null && title != null && weight != null);

  int idAnswer;
  String title;
  int weight;
  int indexAnswer;
}

class ArrayResult {
  ArrayResult({
    this.idAnswer,
    this.idQuestion
  }) : assert(idQuestion != null);

  int idAnswer;
  int idQuestion;

  Map toMap() {
    Map map = {
      "id_answer": this.idAnswer,
      "id_question": this.idQuestion,
    };
    return map;
  }
}

class Result {
  Result({
    this.idAnswer,
    this.idQuestion,
    this.idStatistics,
    this.mail
  }) : assert(idAnswer != null && idQuestion != null && idStatistics != null && mail != null);

  int idAnswer;
  int idQuestion;
  String mail;
  int idStatistics;
}

class TotalOptions {
  TotalOptions({
    this.description,
    this.fromValues,
    this.toValues,
    this.title,
  }) : assert(description != null && fromValues != null && toValues != null && title != null);

  int fromValues;
  int toValues;
  String description;
  String title;
}

class TotalOptionsResponse {
  TotalOptionsResponse({
    this.totalOptions,
    this.numberPoint
  }) : assert(totalOptions != null && numberPoint != null);

  List<TotalOptions> totalOptions;
  int numberPoint;
}

class Statistics {
  Statistics({
    this.date,
    this.toTitle,
    this.testTitle,
    this.description,
    this.countTime,
    this.numberPoint,
  }) : assert(date != null && toTitle != null && testTitle != null && description != null && countTime != null && numberPoint != null);

  String date;
  String toTitle;
  String testTitle;
  String description;
  int countTime;
  int numberPoint;
}

// class DescStatistics {
//   DescStatistics({
//     this.date,
//     this.toTitle,
//     this.testTitle,
//     this.description,
//     this.countTime,
//     this.numberPoint,
//   }) : assert(date != null && toTitle != null && testTitle != null && description != null && countTime != null && numberPoint != null);

//   String date;
//   String toTitle;
//   String testTitle;
//   String description;
//   int countTime;
//   int numberPoint;
// }