import 'dart:async';

import 'package:co_win/users.dart';
import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async{
  final database = openDatabase(
      join(await getDatabasesPath(), 'user_database.db'),
      onCreate: (db, version) {
  return db.execute(
  "CREATE TABLE users(name TEXT, user_name TEXT, phone_no TEXT, email TEXT, password TEXT, confirm_password TEXT)",
  );
  },
  version: 1,
  );
  Future<int> insertUser(User user) async {
    final Database db = await database;
    int res = await db.insert('users', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

  Future<int> deleteUser(User user) async {
    final Database db = await database;
    int res = await db.delete('users',where: 'user_name = ?',whereArgs: [user.user_name]);
    return res;
  }

  Future<List<User>> getAlluser() async {
    final Database db = await database;
    var res = await db.query('users'); 
  }

}