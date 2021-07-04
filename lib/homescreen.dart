import 'dart:async';
import 'package:co_win/Second.dart';
import 'package:co_win/database.dart';
import 'package:co_win/databaseapp.dart';
import 'package:co_win/main.dart';
import 'package:co_win/users.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as LocationManager;
import 'package:shared_preferences/shared_preferences.dart';
import 'place_detail.dart';

//const apikey = "AIzaSyDHoIRdbk8vfGlaHLkdUxh2XWGR8pMgrto";
//GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: apikey);

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomeScreen>{

  LoginApp loginApp = new LoginApp();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<User>> lisp;


  /*GoogleMapController mapController;
  bool isLoading = false;
  String errorMsg;
  List<PlacesSearchResult> places = [];
  Map<MarkerId, Marker> markers = <MarkerId,Marker>{};
  int markerIdcounter = 1;

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
  }*/

  @override
  void initState() {
    super.initState();
    lisp = main();
  }

  Future<List<User>> main() async{
    print("Retrieving list");
    var list = await loginApp.getAlluser();
    return list;
  }

  @override
  Widget build(BuildContext context) {

    //print(lisp);
    //print("w");
    //Future.delayed(
      //Duration(seconds: 3),() {
      //print(fs.list);
    //}
   // );
    Widget expandedChild;
    /*if(isLoading){
      expandedChild = Center(child: CircularProgressIndicator(value: null));
    } else if(errorMsg != null){
      print(errorMsg);
      expandedChild = Center(child: Text(errorMsg),);
    } else{
      expandedChild = buildPlacesList();
    }*/

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xffB8C2BC),
      appBar: AppBar(title: Text("Main"),
      backgroundColor: const Color(0xff135E37),
      /*actions: <Widget>[
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
      ],*/),
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
        body: FutureBuilder(
          initialData: false,
          future: lisp,
          builder: (context,snapshot){
            if(snapshot.hasData){
              print("Step 2");
              print(snapshot.data);
              if(snapshot.data != false){
                List<User> users = snapshot.data;
                return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context,position){
                      return Padding(padding: EdgeInsets.only(top: 4.0),
                      child:ListTile(title: Text(users[position].name),tileColor: const Color(0xffE8EBE9),) ,);
                    });

              }
              return Center(child: Text("Retrieving Data...."),);

            }
            else{
              return Text("Retrieving List");
            }
          },
        ),
        /*body: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          itemCount: fs.liso.length,
          itemBuilder: (context,position){
            return ListTile(
              title: Text(fs.liso[position].name),
            );
          },
        )*/
      /*body: Column(
        children: [
          Container(
            child: SizedBox(
              height: 200.0,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
                initialCameraPosition: const CameraPosition(target: LatLng(0.0, 0.0)),
                markers: Set<Marker>.of(markers.values),
              ),
            ),
          ),
          Expanded(child: expandedChild)
        ],
        ),*/
    );
  }

  void signOut() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("value");
    preferences.remove("user");

    Navigator.pushReplacementNamed(context, '/second');
  }




  /*void refresh() async{
    final center = await getUserLocation();
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: center == null ? LatLng(0, 0) : center, zoom: 15.0)));
    getNearbyPlaces(center);
  }

  Future<LatLng> getUserLocation() async{
    LocationManager.LocationData currentLocation;
    final location = LocationManager.Location();
    try{
      currentLocation = await location.getLocation();
      final lat = currentLocation.latitude;
      final lang = currentLocation.longitude;
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
    final location = Location(lat: center.latitude,lng: center.longitude);
    final result = await _places.searchNearbyWithRadius(location, 2500);
    setState(() {
      this.isLoading = false;
      print(result.status);
      if(result.status == "OK") {
        this.places = result.results;
        result.results.forEach((f) {
          final String markerIdval = 'marker_Id$markerIdcounter';
          markerIdcounter++;
          final MarkerId markerId = MarkerId(markerIdval);
          final Marker marker = Marker(
            markerId: markerId,
            position: LatLng(f.geometry.location.lat,f.geometry.location.lng),
            infoWindow: InfoWindow(title: "${f.name}")
          );
          setState(() {
            markers[markerId] = marker;
          });
          print(f.name);
        });
      }
      else{
        print("error");
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
      location: center == null ? null : Location(lat: center.latitude,lng: center.longitude),
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
  }*/



}