import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AdminState();
  }
}

class AdminState extends State<AdminLogin> {
  final form_key = GlobalKey<FormState>();
  bool isHidden = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: form_key,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: 20.0, left: 15.0, right: 15.0, bottom: 0.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Hospital Id',
                      hintText: 'Enter your Individual ID'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 5.0, left: 15.0, right: 15.0, bottom: 0.0),
                child: TextFormField(
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
