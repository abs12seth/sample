import 'package:flutter/cupertino.dart';

class PlaceDetail extends StatefulWidget{
  String placeId;
  PlaceDetail(String placeId){
    this.placeId = placeId;
  }
  @override
  State<StatefulWidget> createState() {
    return PlaceDetailState();
  }
}

class PlaceDetailState extends State<PlaceDetail>{
  @override
  Widget build(BuildContext context) {

  }
}