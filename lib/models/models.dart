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