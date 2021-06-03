import 'package:co_win/database.dart';
import 'package:co_win/users.dart';
import 'package:flutter/cupertino.dart';

class LoginApp{

  Login log = new Login();

  Future<int> insertUser(User user) async {
    var db = await log.db;
    if(db == null){
      print("it is null");
    }
    else {
      int res = await db.insert('users', user.toMap());
      return res;
    }
  }

  Future<int> deleteUser(User user) async {
    var db = await log.db;
    int res = await db.delete('users',where: 'user_name = ?',whereArgs: [user.user_name]);
    return res;
  }

  Future<User> getLogin(String user,String password) async{
    var db = await log.db;
    var res = await db.rawQuery("SELECT * FROM user WHERE username = '$user' and password = '$password'");
    if(res.length > 0) {
      return new User.fromMap(res.first);
    }
    return null;
  }

  Future<List<User>> getAlluser() async {
    var db = await log.db;
    /*final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i){
      return User(
          name: maps[i]['name'],
        email: maps[i]['email'],
      );
    });*/
    var res = await db.query('users');
    List<User> list = res.isNotEmpty ? res.map((c) => User.fromMap(c)).toList() : null;
    print(list);
    return list;
  }

}