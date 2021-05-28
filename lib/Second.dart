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
        backgroundColor: Colors.teal,
        title: Text("Sample"),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                  width: 200,
                  height: 150,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                        borderRadius: BorderRadius.circular(50.0)
                    ),
                  child: Center(
                    child: Text("Sample",style: TextStyle(fontSize: 20.0,color: Colors.white),),
                  )

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
                    labelText: 'Email',
                    hintText: 'Enter a email ID',
                  ),
                ),
            ),
            Padding(padding: EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                    ),
                    labelText: 'Password',
                    hintText: 'Enter your Password'
                  ),
                ),
            ),
            FlatButton(
                onPressed: (){
                  print("its happening");
                  // Will make another class
                },
                child: Text("Forgot Password",style: TextStyle(color: Colors.blue,fontSize: 15.0),
                ),
            ),
            Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: FlatButton(onPressed: (){
                print("Logging in");
              },
                child: Text('Login'),
              ),
            ),
          ],
        ),
      )
    );
  }
}