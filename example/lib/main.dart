import 'package:flutter/material.dart';
import 'package:flutter_map_location/flutter_map_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Map Location',
      home: Aplication()
    );
  }
}

class Aplication extends StatefulWidget {
  @override
  _AplicationState createState() => _AplicationState();
}

class _AplicationState extends State<Aplication> {
  @override
  Widget build(BuildContext context) {
    List<Marker> listPositions = [
      Marker(
        markerId: MarkerId("trhr"),
        position: LatLng(-15.546206, -56.067219)
      ),
      Marker(
        markerId: MarkerId("1"),
        position: LatLng(-15.546206, -50.067219)
      ),
    ];
    return MapLocation(
      googleMapKey: "YOUR_KEY_HERE",
      onSelect: (Address address){
        print(address.toJson());
      },
      markers: listPositions.toSet(),
      myLocationEnabled: true,
      cameraPosition: CameraPosition(
        target: LatLng(-15.546206, -56.067219),
        zoom: 18
      ),
    );
  }
}