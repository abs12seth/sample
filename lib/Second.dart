import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return SecondState();
  }
}

class SecondState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("CoWin"),
      ),
      body: Container(
        
      ),
    );
  }
}