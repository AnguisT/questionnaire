class User {
  User({this.mail, this.password, this.birthday, this.idSexs, this.firstName, this.lastName, this.city});

  String mail;
  String password;
  DateTime birthday;
  int idSexs;
  String firstName;
  String lastName;
  String city;
}

class Sexs {
  Sexs({this.idSexs, this.name});

  int idSexs;
  String name;
}

class Question {
  Question({this.idQuestion, this.description, this.answers});

  int idQuestion;
  String description;
  List<Answer> answers;
}

class Answer {
  Answer({this.idAnswer, this.indexAnswer, this.title, this.weight});

  int idAnswer;
  String title;
  int weight;
  int indexAnswer;
}

class ArrayResult {
  ArrayResult({this.idAnswer, this.idQuestion});

  int idAnswer;
  int idQuestion;
}

class Result {
  Result({this.idAnswer, this.idQuestion, this.idStatistics, this.mail});

  int idAnswer;
  int idQuestion;
  String mail;
  int idStatistics;
}