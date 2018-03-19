// dart
import 'dart:async';

// package
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  Database db;

  Future open() async {
    String path = (await getApplicationDocumentsDirectory()).path;
    String dbPath = join(path, "database.db");
    // deleteDatabase(dbPath);
    db = await openDatabase(dbPath, version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
        create table users (
          id_user integer primary key autoincrement,
          mail text not null,
          first_name text not null,
          isLogin integer not null,
          language_code text not null
        );
      ''');
    });
  }

  Future insertUser(String mail, String firstName) async {
    await db.rawQuery("insert into users(mail, first_name, isLogin, language_code) values ('$mail', '$firstName', 1, 'en')");
  }

  Future getLoginUser() async {
    List<Map> maps = await db.rawQuery("select mail, first_name, language_code from users where isLogin=1");
    if (maps.length > 0) {
      return maps.first;
    }
    return null;
  }

  Future getUserByMail(String mail) async {
    List<Map> maps = await db.rawQuery("select * from users where mail='$mail'");
    if (maps.length > 0) {
      return maps.first;
    }
    return null;
  }

  Future<int> login(String mail) async {
    return await db.rawUpdate("UPDATE users SET isLogin = '1' where mail = '$mail'");
  }

  Future<int> logout(String mail) async {
    return await db.rawUpdate("UPDATE users SET isLogin = '0' where mail = '$mail'");
  }

  Future<int> updateLanguage(String mail, String language) async {
    return await db.rawUpdate("UPDATE users SET language_code = '$language' where mail = '$mail'");
  }
}