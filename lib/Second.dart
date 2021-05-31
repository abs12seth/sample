import 'dart:ui';

import 'package:co_win/createaccount.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SecondState();
  }
}

class SecondState extends State<SecondScreen> {
  bool isHidden = true;
  final emailController = TextEditingController();
  final passController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Color.fromRGBO(197, 234, 225, 40),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: Container(
                      width: 200,
                      height: 150,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(61, 169, 142, 50),
                          borderRadius: BorderRadius.circular(50.0)),
                      child: Center(
                        child: Text(
                          "Sample",
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      )),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 0.0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Email',
                      hintText: 'Enter a email ID or UserID',
                      suffixIcon: Icon(Icons.account_circle)),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 0),
                child: TextField(
                  controller: passController,
                  obscureText: isHidden,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: 'Password',
                    hintText: 'Enter your Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        isHidden ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: passwordVis,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Forgot Password",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
              Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(61, 169, 142, 50),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: FlatButton(
                  onPressed: () {
                    if (emailController.text == '' ||
                        passController.text == '') {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text("Invalid EmailID or Password"),
                          );
                        },
                      );
                    } else {
                      print("Not null");
                    }
                  },
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                        color: Color.fromRGBO(0, 43, 43, 100),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Rubik'),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 60.0),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'First Time User?',
                        style: TextStyle(fontSize: 15.0),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/create');
                        },
                        child: Text(
                          'Create Account',
                          style: TextStyle(color: Colors.blue, fontSize: 15.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void passwordVis() {
    setState(() {
      isHidden = !isHidden;
    });
  }
}
