import 'dart:ui';

import 'package:co_win/createaccount.dart';
import 'package:co_win/database.dart';
import 'package:co_win/homescreen.dart';
import 'package:co_win/login_response.dart';
import 'package:co_win/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SecondState();
  }
}

enum LoginStatus { notSignIn, signIn }

class SecondState extends State<SecondScreen> implements LoginCallBack {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  BuildContext _buildContext;
  bool isLoading = false;
  String _email, _password;
  LoginResponse _loginResponse;
  SecondState() {
    _loginResponse = new LoginResponse(this);
  }
  bool isHidden = true;
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 0.0),
                      child: TextFormField(
                        onSaved: (val) => _email = val,
                        controller: emailController,
                        validator: MultiValidator([
                          RequiredValidator(errorText: "* Required"),
                          EmailValidator(errorText: "Enter valid email ID"),
                        ]),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelText: 'Email',
                            hintText: 'Enter a email',
                            suffixIcon: Icon(Icons.account_circle)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 15, bottom: 0),
                      child: TextFormField(
                        onSaved: (val) => _password = val,
                        controller: passController,
                        validator: MultiValidator([
                          RequiredValidator(errorText: "* Required"),
                        ]),
                        obscureText: isHidden,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText: 'Password',
                          hintText: 'Enter your Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              isHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: passwordVis,
                          ),
                        ),
                      ),
                    ),
                  ],
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
                    final form = _formKey.currentState;
                    if (form.validate()) {
                      setState(() {
                        isLoading = true;
                        form.save();
                        _loginResponse.doLogin(_email, _password);
                      });
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

  savePref(int value, String user, String pass) async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("user", user);
      preferences.setString("pass", pass);
      preferences.commit();
    });
  }

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  void _showSnackBar(String s) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(s),
        );
      },
    );
  }

  @override
  void onLoginError(String error) {
    _showSnackBar(error);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void onLoginSuccess(User user) async {
    if (user != null) {
      savePref(1, user.email, user.password);
      _loginStatus = LoginStatus.signIn;
      Navigator.pushNamed(context, '/main');
    } else {
      _showSnackBar("User not Found");
      setState(() {
        isLoading = false;
      });
    }
  }

  void passwordVis() {
    setState(() {
      isHidden = !isHidden;
    });
  }
}
