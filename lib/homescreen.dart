import 'dart:async';
import 'package:co_win/Second.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as LocationManager;
import 'package:shared_preferences/shared_preferences.dart';
import 'place_detail.dart';

const apikey = "AIzaSyDHoIRdbk8vfGlaHLkdUxh2XWGR8pMgrto";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: apikey);

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomeScreen>{
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapController mapController;
  bool isLoading = false;
  String errorMsg;
  List<PlacesSearchResult> places = [];

  void _onMapCreated(GoogleMapController controller){
    mapController = controller;
    refresh();
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
    Widget expandedChild;
    if(isLoading){
      expandedChild = Center(child: CircularProgressIndicator(value: null));
    } else if(errorMsg != null){
      expandedChild = Center(child: Text(errorMsg),);
    } else{
      expandedChild = buildPlacesList();
    }

    return Scaffold(
      key: scaffoldKey,
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
              _handlePressButton();
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
            child: SizedBox(
              height: 200.0,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
                initialCameraPosition: const CameraPosition(target: LatLng(0.0, 0.0)),
              ),
            ),
          ),
          Expanded(child: expandedChild)
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
    getNearbyPlaces(center);
  }

  Future<LatLng> getUserLocation() async{
    Map<String, dynamic> currentLocation;
    final location = LocationManager.Location();
    try{
      currentLocation = await location.getLocation();
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
    MarkerId marker;
    setState(() {
      this.isLoading = true;
      this.errorMsg = null;
    });
    final location = Location(lat: center.latitude,lng: center.longitude);
    final result = await _places.searchNearbyWithRadius(location, 2500);
    setState(() {
      this.isLoading = false;
      if(result.status == "OK") {
        this.places = result.results;
        result.results.forEach((f) {
          final options = Marker(
            markerId: marker,
            position: LatLng(f.geometry.location.lat,f.geometry.location.lng),
            infoWindow: InfoWindow(title: "${f.name}")
          );
          mapController.showMarkerInfoWindow(marker);
          print(f.name);
        });
      }
      else{
        this.errorMsg = result.errorMessage;
      }
    });
  }

  void onError(PlacesAutocompleteResponse response) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage))
    );
  }

  Future<void> _handlePressButton() async{
    try{
      final center = await getUserLocation();
      Prediction p = await PlacesAutocomplete.show(
          context: context,
          strictbounds: center == null ? false : true,
          apiKey: apikey,
      onError: onError,
      mode: Mode.fullscreen,
      language: "en",
      location: center == null ? null : Location(),
      radius: center == null ? null : 10000);
      showDetailPlace(p.placeId);
    }catch(e){
      return;
    }
  }

  Future<Null> showDetailPlace(String placeId) async{
    if(placeId != null){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PlaceDetail(placeId)),
      );
    }
  }

  ListView buildPlacesList() {
    final placesWidget = places.map((f) {
      List<Widget> list = [
        Padding(
            padding: EdgeInsets.only(bottom: 4.0),
          child: Text(
            f.formattedAddress,
            style: Theme.of(context).textTheme.subtitle,
          ),
        ),
      ];
      if(f.formattedAddress != null) {
        list.add(
          Padding(padding: EdgeInsets.only(bottom: 2.0),
          child: Text(f.formattedAddress,
          style: Theme.of(context).textTheme.subtitle,),)
        );
      }
      if(f.vicinity != null){
        list.add(Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Text(
            f.vicinity,
            style: Theme.of(context).textTheme.body1,
          ),
        ));
      }
      if(f.types?.first != null){
        list.add(Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Text(
            f.types.first,
            style: Theme.of(context).textTheme.caption,
          ),
        ));
      }
      return Padding(padding: EdgeInsets.only(top: 4.0,bottom: 4.0,left: 8.0,right: 8.0),
        child: Card(
          child: InkWell(
            onTap: (){
              showDetailPlace(f.placeId);
            },
            highlightColor: Colors.lightBlueAccent,
            splashColor: Colors.red,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: list,
              ),
            ),
          ),
        ),
      );
    }).toList();
    return ListView(shrinkWrap: true, children: placesWidget);
  }

}