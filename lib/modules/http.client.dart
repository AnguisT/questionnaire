// dart
import "dart:async";
import "dart:convert";

// package
import "package:http/http.dart" as http;

// class
import "../models/models.dart";

class CustomHttpClient {

  String urlServer = "https://salty-mesa-77909.herokuapp.com/";
  String urlLocal = "https://gentle-journey-37004.herokuapp.com/";

  Future getAllSexs() async {
    var url = urlServer + "users/sexs";
    return await http.post(url).then((response) {
      return json.decode(response.body);
    }).catchError((error) {
      return 'Error';
    });
  }

  Future getAllUsers() async {
    var url = urlServer + "users/";
    return await http.post(url).then((response) {
      return json.decode(response.body);
    }).catchError((error) {
      return 'Error';
    });
  }

  Future getTest() async {
    var body = {
      "id_test": 1,
    };
    String lData = json.encode(body);
    Map lHeaders = {"Content-type": "application/json", "Accept": "application/json"};
    var url = urlServer + "tests/id";
    return await http.post(url, body: lData, headers: lHeaders).then((response) {
      return json.decode(response.body);
    }).catchError((error) {
      return 'Error';
    });
  }

  Future getAllQuestion() async {
    var body = {
      "id_test": 1,
    };
    String lData = json.encode(body);
    Map lHeaders = {"Content-type": "application/json", "Accept": "application/json"};
    var url = urlServer + "questions/id";
    return await http.post(url, body: lData, headers: lHeaders).then((response) {
      return json.decode(response.body);
    }).catchError((error) {
      return 'Error';
    });
  }

  Future getAllTotalOptions() async {
    var body = {
      "id_test": 1,
    };
    String lData = json.encode(body);
    Map lHeaders = {"Content-type": "application/json", "Accept": "application/json"};
    var url = urlServer + "totaloptions/";
    return await http.post(url, body: lData, headers: lHeaders).then((response) {
      return json.decode(response.body);
    }).catchError((error) {
      return 'Error';
    });
  }

  Future getAllStatistics(String mail) async {
    var body = {
      "mail": mail,
      "id_test": 1,
    };
    String lData = json.encode(body);
    Map lHeaders = {"Content-type": "application/json", "Accept": "application/json"};
    var url = urlServer + "statistics/own";
    return await http.post(url, body: lData, headers: lHeaders).then((response) {
      return json.decode(response.body);
    }).catchError((error) {
      return 'Error';
    });
  }

  Future getUserByMail(String mail) async {
    var body = {
      "mail": mail
    };
    String lData = json.encode(body);
    Map lHeaders = {"Content-type": "application/json", "Accept": "application/json"};
    var url = urlServer + "users/id";
    return await http.post(url, body: lData, headers: lHeaders).then((response) {
      return json.decode(response.body);
    }).catchError((error) {
      return 'Error';
    });
  }

  Future logIn(String mail, String password) async {
    var body = {
      "mail": mail,
      "password": password,
    };
    String lData = json.encode(body);
    Map lHeaders = {"Content-type": "application/json", "Accept": "application/json"};
    var url = urlServer + "users/login";
    return await http.post(url, body: lData, headers: lHeaders).then((response) {
      return json.decode(response.body);
    }).catchError((error) {
      return 'Error';
    });
  }

  Future signUp(User user) async {
    var body = {
      "mail": user.mail,
      "password": user.password,
      "birthday": user.birthday.toString(),
      "id_sex": user.idSexs,
      "first_name": user.firstName,
      "last_name": user.lastName,
      "city": user.city
    };
    String lData = json.encode(body);
    Map lHeaders = {"Content-type": "application/json", "Accept": "application/json"};
    var url = urlServer + "users/logup";
    return await http.post(url, body: lData, headers: lHeaders).then((response) {
      return json.decode(response.body);
    }).catchError((error) {
      return 'Error';
    });
  }

  saveResult(List<ArrayResult> arrayResult, String mail, int idTest, String date, int numberPoint, int countTime) async {
    var body = {
      "results": [],
      "statistic": {
        "id_test": idTest,
        "mail": mail,
        "date": date,
        "number_point": numberPoint,
        "count_time": countTime
      }
    };
    List array = [];
    for (int i = 0; i < arrayResult.length; i++) {
      array.add(arrayResult[i].toMap());
    }
    body["results"] = array;
    String lData = json.encode(body);
    Map lHeaders = {"Content-type": "application/json", "Accept": "application/json"};
    var url = urlServer + "results/add";
    return await http.post(url, body: lData, headers: lHeaders).then((response) {
      return json.decode(response.body);
    }).catchError((error) {
      return 'Error';
    });
  }

  updateUser(User user) async {
    var body = {
      "mail": user.mail,
      "password": user.password,
      "first_name": user.firstName,
      "last_name": user.lastName,
      "city": user.city,
    };
    String lData = json.encode(body);
    Map lHeaders = {"Content-type": "application/json", "Accept": "application/json"};
    var url = urlServer + "users/update";
    return await http.post(url, body: lData, headers: lHeaders).then((response) {
      return json.decode(response.body);
    }).catchError((error) {
      return 'Error';
    });
  }
}