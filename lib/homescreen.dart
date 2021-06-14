import 'dart:ui';
import 'package:co_win/Second.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomeScreen>{
  GoogleMapController mapController;
  final LatLng _center = const LatLng(45.521563, -122.677433);
  void _onMapController(GoogleMapController controller){
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    SecondState ss = new SecondState();
    return Scaffold(
      appBar: AppBar(title: Text("Main"),
      actions: <Widget>[
        IconButton(icon: Icon(
          Icons.more_vert_rounded,
          color: Colors.white,
        ), onPressed: (){
          ListTile(
            title: Text("Sign Out"),
          );
        })
      ],),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(child: Text("Hello"),
            decoration: BoxDecoration(
              color: Colors.cyan,
            ),
            ),
            ListTile(
              title: Text("SignOut"),
              onTap: signOut,
            ),
          ],
        ),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: (){
            GoogleMap(
              onMapCreated: _onMapController,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            );
          },
          child: Text("Sign Out"),
        ),
      ),
    );
  }

  void signOut() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("value");
    preferences.remove("user");

    Navigator.pushReplacementNamed(context, '/second');
  }

}