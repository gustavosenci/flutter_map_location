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
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
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