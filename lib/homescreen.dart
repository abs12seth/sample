
import 'dart:ui';
import 'package:co_win/Second.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    SecondState ss = new SecondState();
    return Scaffold(
      appBar: AppBar(title: Text("Main"),),
      body: Center(
        child: RaisedButton(
          onPressed: ()async{
            SharedPreferences preferences = await SharedPreferences.getInstance();
            preferences.remove("value");
            preferences.remove("user");

            Navigator.pushNamed(context, '/second');
          },
          child: Text("Sign Out"),
        ),
      ),
    );
  }

}