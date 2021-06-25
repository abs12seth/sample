import 'package:co_win/Admin/hospitals.dart';
import 'package:co_win/database.dart';
import 'package:co_win/users.dart';
import 'package:flutter/cupertino.dart';

class LoginApp{

  Login log = new Login();

  Future<bool> insertUser(User user) async {
    var db = await log.db;
    bool ret = false;
    if(db == null){
      print("it is null");
    }
    else {
      bool result = await checkforUser(user.email);
      print(result);
      if(!result){
        int res = await db.insert('users', user.toMap());
        print("inserted");
        ret = true;
        return ret;
      }
      else {
        print("not inserted");
        ret = false;
        return ret;
      }
    }
  }

  Future<void> insertHospital(Hospital hospital) async{
    var db = await log.db;
    int res = await db.insert('hospitals', hospital.toMap());
    print("inserted hospital");
  }

  Future<int> deleteUser(User user) async {
    var db = await log.db;
    int res = await db.delete('users');
    return res;
  }

  Future<bool> checkforUser(String user) async{
    var db = await log.db;
    var res = await db.rawQuery("SELECT * FROM users WHERE email = '$user'");
    bool isCheck = false;
    if(res.length > 0){
      isCheck =  true;
    }
    else{
      isCheck = false;
    }
    print(isCheck);
    return isCheck;
  }

  Future<User> getLogin(String user,String password) async{
    var db = await log.db;
    var res = await db.rawQuery("SELECT * FROM users WHERE email = '$user' and password = '$password'");
    print(res);
    if(res.length > 0) {
      return new User.fromMap(res.first);
    }
    return null;
  }

  Future<Hospital> getLoginHospital(String id,String password) async{
    var db = await log.db;
    var res = await db.rawQuery("SELECT * FROM hospitals WHERE hospital_id = '$id' and password = '$password'");
    print(res);
    if(res.length > 0) {
      return new Hospital.fromMap(res.first);
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