import 'package:co_win/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return CreateState();
  }
}

class CreateState extends State<CreateAccount>{
  bool isHidden = true;
  bool _isHiiden = true;
  final name = TextEditingController();
  final user_name = TextEditingController();
  final mobile = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final con_password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(197, 234, 225, 50),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(

                    width: 200,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(61, 169, 142, 50),
                        borderRadius: BorderRadius.circular(100.0)
                    ),

                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 15,right: 15, top: 10.0,bottom: 0.0),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(padding: EdgeInsets.only(left: 15,right: 15, top: 10,bottom: 0.0),
                        child: TextField(
                          controller: name,
                          decoration: InputDecoration(
                            border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelText: 'Full Name',
                            hintText: 'e.g. - Abhishek Seth',
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 0),
                        child: TextField(
                          controller: user_name,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              labelText: 'UserID',
                              hintText: 'e.g., absseth12'
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 0),
                        child: TextField(
                          controller: mobile,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              labelText: 'Mobile no.',
                              hintText: 'Ex - 9999999999'
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 0),
                        child: TextField(
                          controller: email,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              labelText: 'Email',
                              hintText: 'Enter your email ID'
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 0),
                        child: TextField(
                          controller: password,
                          obscureText: _isHiiden,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              labelText: 'Password',
                              hintText: 'Enter your Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isHiiden ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: (){
                                setState(() {
                                  _isHiiden = !_isHiiden;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 10),
                        child: TextField(
                          controller: con_password,
                          obscureText: isHidden,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              labelText: 'Confirm Password',
                              hintText: 'Confirm your Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                isHidden ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: passwordVis,
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                color: Color.fromRGBO(61, 169, 142, 50),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: FlatButton(
                onPressed: () {
                  final acc = User(
                    name: name.text,
                    user_name: user_name.text,
                    phone_no: mobile.text,
                    email: email.text,
                    password: password.text,
                    confirm_password: con_password.text,
                  );
                  User user = new User();
                },
                child: Text('Register'),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void passwordVis() {
    setState(() {
      isHidden = !isHidden;
    });
  }
}