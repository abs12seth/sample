import 'dart:async';

import 'package:co_win/users.dart';
import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Login{
  static Database database;
  Future<Database> get db async {
    openDatabase(
      join(await getDatabasesPath(), 'user_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE users(""name TEXT, ""user_name TEXT, ""phone_no TEXT, ""email TEXT, ""password TEXT"")",
        );
      },
      version: 1,
    );
  }
  Future<int> insertUser(User user) async {
    int res = await database.insert('users', user.toMap());
    return res;
  }

  Future<int> deleteUser(User user) async {
    final Database db = await database;
    int res = await db.delete('users',where: 'user_name = ?',whereArgs: [user.user_name]);
    return res;
  }

  Future<User> getLogin(String user,String password) async{
    final Database db = await database;
    var res = await db.rawQuery("SELECT * FROM user WHERE username = '$user' and password = '$password'");
    if(res.length > 0) {
      return new User.fromMap(res.first);
    }
    return null;
  }

  Future<List<User>> getAlluser() async {
    var res = await database.query('users');
    List<User> list = res.isNotEmpty ? res.map((c) => User.fromMap(c)).toList() : null;
    return list;
  }
}