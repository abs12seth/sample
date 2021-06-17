import 'dart:html';
import 'dart:ui';
import 'package:co_win/Second.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:location/location.dart' as LocationManager;
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const apikey = "AIzaSyDHoIRdbk8vfGlaHLkdUxh2XWGR8pMgrto";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: apikey);

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomeScreen>{
  //LocationManager.LocationData currentLocation;
  //LocationManager.Location loc = LocationManager.Location();
  String address,date;
  GoogleMapController mapController;
  Marker marker;
  bool isLoading = false;
  String errorMsg;
  List<PlacesSearchResult> places = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLocation();
  }

  void _onMapCreated(GoogleMapController controller){
    mapController = controller;
    /*loc.onLocationChanged.listen((l) {
      mapController.animateCamera(
      CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(
        l.latitude,l.longitude
      ),zoom: 15),
      ),
      );
    });*/
  }

  @override
  Widget build(BuildContext context) {
    SecondState ss = new SecondState();
    return Scaffold(
      appBar: AppBar(title: Text("Main"),
      actions: <Widget>[
        isLoading ?
            IconButton(icon: Icon(Icons.timer), onPressed: (){},)
            : IconButton(icon: Icon(Icons.refresh),
            onPressed:(){
              refresh();
            }
        ),
        IconButton(icon: Icon(Icons.search),
            onPressed: (){
             // _handlePressButton();
            }
        ),
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
      body: Column(
        children: [
          Container(

          ),
        ],
        ),
    );
  }

  void signOut() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("value");
    preferences.remove("user");

    Navigator.pushReplacementNamed(context, '/second');
  }

  void refresh() async{
    final center = await getUserLocation();
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: center == null ? LatLng(0, 0) : center, zoom: 15.0)));
  }

  Future<LatLng> getUserLocation() async{
    var currentLocation = <String, double>{};
    final location = LocationManager.Location();
    try{
      currentLocation = (await location.getLocation()) as Map<String, double>;
      final lat = currentLocation["latitude"];
      final lang = currentLocation["longitude"];
      final center = LatLng(lat, lang);
      return center;
    } on Exception {
      currentLocation = null;
      return null;
    }
  }

  void getNearbyPlaces(LatLng center)async{
    setState(() {
      this.isLoading = true;
      this.errorMsg = null;
    });
    final location = Location();
    final result = await _places.searchNearbyWithRadius(location, 2500);
    setState(() {
      this.isLoading = false;
      if(result.status == "OK") {
        this.places = result.results;
        result.results.forEach((f) {
          print(f.name);
        });
      }
      else{
        this.errorMsg = result.errorMessage;
      }
    });
  }

  void onError(PlacesAutocompleteResult response) {
    print("error");
  }

  

}