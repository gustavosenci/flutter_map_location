import 'package:flutter/material.dart';
import 'package:flutter_map_location/src/models/address_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'map_location_repository.dart';

class MapLocation extends StatefulWidget {
  final CameraPosition cameraPosition;
  final Set<Marker> markers;
  final bool myLocationEnabled;
  final ValueChanged<Address> onSelect;
  final Color primaryColor;
  final Function onWillPop;
  final String googleMapKey;
  final IconData iconPin;

  MapLocation({
    @required this.cameraPosition,
    this.markers,
    this.myLocationEnabled = true,
    this.onSelect,
    this.primaryColor = Colors.blue,
    this.onWillPop,
    this.googleMapKey,
    this.iconPin = Icons.person_pin
  });

  @override
  _MapLocationState createState() => _MapLocationState();
}

class _MapLocationState extends State<MapLocation> {
  TextEditingController _searchController = TextEditingController();
  GoogleMapController _googleMapController;
  FocusNode _searchFocus = FocusNode();
  Address _addressSelected;
  CameraPosition cameraPosition;
  bool isMov = false;
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GoogleMap(
          mapType: mapType,
          onCameraMove: (CameraPosition position){
            cameraPosition = position;
            setState(() {
              _addressSelected = null;
              isMov = true;
            });
          },
          onCameraIdle: ()async{
            setState(() {
              isMov = false;
            });
            Address address = await getLocationByCoordinates(cameraPosition.target.latitude.toString(), cameraPosition.target.longitude.toString(), key: widget.googleMapKey);
            setState(() {
              _addressSelected = address;
            });
          },
          onMapCreated: (controller) async{
            _googleMapController = controller;
            Address address = await getLocationByCoordinates(widget.cameraPosition.target.latitude.toString(), widget.cameraPosition.target.longitude.toString(), key: widget.googleMapKey);
            setState(() {
              _addressSelected = address;
            });
          },
          initialCameraPosition: widget.cameraPosition,
          markers: widget.markers,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,

        ),
        SafeArea(
          child: Container(
            margin: EdgeInsets.only(
                top: 15
            ),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 20,
                    height: 65,
                    color: Colors.white,
                    child: Material(
                      elevation: 5,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 55,
                            child: IconButton(
                                icon: Icon(Icons.arrow_back),
                                onPressed: (){
                                  if(_searchController.text.length > 0){
                                    setState(() {
                                      _searchController.text = "";
                                      _searchFocus.unfocus();
                                    });
                                  }else{
                                    widget.onWillPop();
                                  }

                                }
                            ),
                          ),
                          Container(
                            width: 1,
                            color: Colors.grey.shade300,
                            height: 40,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: TextField(
                                focusNode: _searchFocus,
                                controller: _searchController,
                                onChanged: (value){
                                  setState(() {});
                                  searchAddress(value, key: widget.googleMapKey);
                                },
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18
                                ),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Pesquise aqui..",
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18
                                    )
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                _searchController.text == null || _searchController.text == "" ? Container(
                  width: MediaQuery.of(context).size.width - 20,
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: ()async{
                            
                              setState(() {
                                if(mapType == MapType.normal){
                                  mapType = MapType.satellite;
                                }else mapType = MapType.normal;
                              });
                            },
                            child: Container(
                              height: 37,
                              width: 37,
                              child: Material(
                                color: Colors.white,
                                elevation: 7,
                                type: MaterialType.circle,
                                child: Center(
                                  child: Icon(
                                    Icons.map,
                                    color: widget.primaryColor,
                                  )
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: (){
                               _googleMapController.animateCamera(CameraUpdate.newLatLngZoom(
                                widget.cameraPosition.target,
                                18
                              ));
                            },
                            child: Container(
                              height: 37,
                              width: 37,
                              child: Material(
                                color: Colors.white,
                                elevation: 7,
                                type: MaterialType.circle,
                                child: Center(
                                  child: Icon(
                                    Icons.location_searching,
                                    color:  widget.primaryColor,
                                  )
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                ) : Container(),
                _searchController.text == null || _searchController.text == "" ? Container() : Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    height: 220,
                    color: Colors.white,
                    child: Material(
                      elevation: 5,
                      child: Container(
                        child: FutureBuilder(
                          future: searchAddress(_searchController.text, key: widget.googleMapKey),
                          builder: (context, snapshot){
                            if(!snapshot.hasData){
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return Container(
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index){
                                  return ListTile(
                                    onTap: (){
                                      _searchController.text = "";
                                      _searchFocus.unfocus();
                                      _googleMapController.animateCamera(CameraUpdate.newLatLngZoom(
                                        LatLng(snapshot.data[index].geometry.location.lat, snapshot.data[index].geometry.location.lng),
                                        18
                                      ));
                                    },
                                    leading: Icon(
                                      Icons.pin_drop,
                                      color: Colors.black,
                                    ),
                                    title: Text(snapshot.data[index].name,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17
                                      ),
                                    ),
                                    subtitle: Text(snapshot.data[index].formattedAddress,
                                      maxLines: 2,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        _addressSelected == null ? Container() :Positioned(
          bottom: 20,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Material(
                elevation: 4,
                child: Container(
                  width: MediaQuery.of(context).size.width - 20,
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("${_addressSelected?.street ?? ""}, ${_addressSelected?.number ?? ""}",
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20
                        ),
                      ),
                      Text(_addressSelected.formattedAddress?? "",
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15
                        ),
                      ),
                      Expanded(child: Container()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            onPressed: (){
                              widget.onSelect(_addressSelected);
                            },
                            child: Text("Selecionar",
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                            color: widget.primaryColor,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        isMov ?
        Center(
          child: Container(
              height: 70,
              width: 50,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    child: Container(
                      width: 50,
                      child: Center(
                        child: Icon(widget.iconPin?? Icons.person_pin,
                          size: 35,
                          color: widget.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child:Container(
                        height: 35,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Icon(Icons.brightness_1,
                              size: 5,
                              color: widget.primaryColor,
                            ),
                          ],
                        )
                    ),
                  )
                ],
              )
          ),
        )
            : Center(
          child: Icon(Icons.person_pin,
            size: 35,
            color: widget.primaryColor
          ),
        )
      ],
    );
  }
}