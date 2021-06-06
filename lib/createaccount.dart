

import 'package:co_win/database.dart';
import 'package:co_win/databaseapp.dart';
import 'package:co_win/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class CreateAccount extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return CreateState();
  }
}

class CreateState extends State<CreateAccount>{
  bool isHidden = true;
  bool _isHiiden = true;
  final _formkey = GlobalKey<FormState>();
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
        child: Form(
          key: _formkey,
          autovalidateMode: AutovalidateMode.always,
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
                        child: TextFormField(
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Please enter a name';
                            }
                            return null;
                          },
                          controller: name,
                          decoration: InputDecoration(
                            border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelText: 'Full Name',
                            hintText: 'e.g. - Abhishek Seth',
                            helperText: "",
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 0),
                        child: TextFormField(
                          controller: mobile,
                          validator: MultiValidator([
                            RequiredValidator(errorText: "* Required"),
                            MinLengthValidator(10, errorText: "Phone no. should be of 10 digits"),
                            MaxLengthValidator(10, errorText: "Phone no. should be of 10 digits"),
                            //PatternValidator(r'(@"^\d{10}$")', errorText: "Enter a valid phone number")
                          ]),
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
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.always,
                          validator: MultiValidator([
                            RequiredValidator(errorText: "* Required"),
                            EmailValidator(errorText: "Please enter a valid email address")
                          ]),
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
                        child: TextFormField(
                          controller: password,
                          validator: MultiValidator([
                            RequiredValidator(errorText: "* Required"),
                            MinLengthValidator(8, errorText: "Password length should be at least 8"),
                          ]),
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
                        child: TextFormField(
                          controller: con_password,
                          validator: (value){
                            if(value.isEmpty){
                              return "* Required";
                            }
                            if(password.text != con_password.text){
                              return "Password doesn't match";
                            }
                            return null;
                          },
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
                  if(_formkey.currentState.validate()){
                    print("Validated");
                    User user = new User();
                    LoginApp login = new LoginApp();
                    user.name = name.text;
                    user.phone_no = mobile.text;
                    user.email = email.text;
                    user.password = password.text;
                    //var c = login.deleteUser(user);
                    var a = login.insertUser(user);
                    var l = login.getAlluser();
                    Navigator.pushNamed(context, '/second');
                  }
                  else{
                    print("Not validated");
                  }
                  //print(user.name);
                  //print(login.insertUser(user));
                  //print(login.getAlluser());
                },
                child: Text('Register'),
              ),
            ),
          ],
        ),
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

//r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'