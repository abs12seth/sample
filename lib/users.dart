import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'user_database.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE users(name TEXT, user_name TEXT, phone_no TEXT, email TEXT, password TEXT, confirm_password TEXT)",
      );
    },
    version: 1,
  );
  Future<void> insertUser(User user) async {
    final Database db = await database;
    await db.insert('users', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }



}

class User {
  final String name;
  final String user_name;
  final String phone_no;
  final String email;
  final String password;
  final String confirm_password;

  User(
      {this.name,
      this.user_name,
      this.phone_no,
      this.email,
      this.password,
      this.confirm_password});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'user_name': user_name,
      'phone_no': phone_no,
      'email': email,
      'password': password,
      'confirm_password': confirm_password,
    };
  }

  @override
  String toString() {
    return 'User{name: $name,user_name: $user_name,phone_no: $phone_no,email: $email, password: $password,confirm_password: $confirm_password}';
  }
}
