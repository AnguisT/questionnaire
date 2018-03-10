TotalOptionsResponse response;

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
  }) : assert(description != null && fromValues != null && toValues != null);

  int fromValues;
  int toValues;
  String description;
}

class TotalOptionsResponse {
  TotalOptionsResponse({
    this.totalOptions,
    this.numberPoint
  }) : assert(totalOptions != null && numberPoint != null);

  List<TotalOptions> totalOptions;
  int numberPoint;
}