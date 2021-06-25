import 'dart:async';
import 'dart:io';

import 'package:co_win/users.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Login{
  static final Login _instance = new Login.internal();
  factory Login() => _instance;

  static Database database;
  Future<Database> get db async {
    if(database != null){
      return database;
    }
    database = await initDb();
    return database;
    /*database = await openDatabase(
      join(await getDatabasesPath(), 'user_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE users(""name TEXT, ""user_name TEXT, ""phone_no TEXT, ""email TEXT, ""password TEXT"")",
        );
      },
      version: 1,
    );*/

  }
  Login.internal();
  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "data_flutter.db");

    //ByteData data = await rootBundle.load(join('data', 'flutter.db'));
    //List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    //await new File(path).writeAsBytes(bytes);

    var ourDb = await openDatabase(path,onCreate: (db,version){db.execute(
        "CREATE TABLE users(name TEXT, phone_no TEXT, email TEXT, password TEXT)");
    db.execute("CREATE TABLE hospitals(name TEXT, phone_no TEXT, email TEXT, password TEXT, hospital_id TEXT,beds INTEGER,doctors INTEGERS)");
    },
      version: 1,
    );
    return ourDb;
  }


}