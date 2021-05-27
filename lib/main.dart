import 'package:co_win/Second.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/':(context) => FirstScreen(),
        '/second':(context) => SecondScreen(),
      },
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

  return Container(
    alignment: Alignment.center,
    color: Colors.lightBlueAccent,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Welcome!!",),
        ElevatedButton(onPressed: () {
          Navigator.pushNamed(context, '/second');
        }, child: Text("Continue >")),
      ],
    ),
  );
  }
}


