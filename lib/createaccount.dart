import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return CreateState();
  }
}

class CreateState extends State<CreateAccount>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal,
      title: Text("Create Account"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(100.0)
                    ),

                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 15,right: 15, top: 5,bottom: 0.0),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border:OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                  ),
                  labelText: 'Full Name',
                  hintText: 'e.g. - Abhishek Seth',
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                    ),
                    labelText: 'Mobile no.',
                    hintText: 'Ex - 9999999999'
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}