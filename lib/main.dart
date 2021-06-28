import 'package:co_win/Admin/admin_login.dart';
import 'package:co_win/Second.dart';
import 'package:co_win/createaccount.dart';
import 'package:co_win/homescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => FirstScreen(),
        '/second': (context) => SecondScreen(),
        '/create': (context) => CreateAccount(),
        '/main': (context) => HomeScreen(),
        '/admin': (context) => AdminLogin(),
      },
    );
  }
}

class FirstScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return FirstState();
  }
}

class FirstState extends State<FirstScreen> {
  BuildContext _buildContext;
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 3), (){
      next();
    },
    );
  }

  @override
  Widget build(BuildContext context) {

    _buildContext = context;



    return Container(
      alignment: Alignment.center,
      color: Color.fromRGBO(197, 234, 225, 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              alignment: Alignment.center,
              //margin: EdgeInsets.symmetric(horizontal: 80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Hack',
                      style: TextStyle(
                          fontSize: 36.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Rubik')),
                  Text('Covid',
                      style: TextStyle(
                          fontSize: 36.0,
                          color: Color.fromRGBO(0, 43, 43, 100),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Rubik')),
                ],

              ),
            ),
          ),

          /*ElevatedButton(
              onPressed: () async{
                await getList();
                liso = list;
                print(liso);
                await next();
                print(liso);
              },
              child: Text("Continue >")),*/
        ],
      ),
    );

  }
  Future next() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(preferences.get("value") != null){
      Navigator.pushReplacementNamed(_buildContext, '/main');
    }
    else{
      Navigator.pushReplacementNamed(_buildContext, '/second');
    }
  }

}
