import 'package:dio/dio.dart';
import 'package:flutter_map_location/src/models/address_model.dart';
import 'package:flutter_map_location/src/models/map_location_model.dart';


Future<List<MapLocationModel>> searchAddress(String textSearch, {String key})async{
  Dio dio = Dio();
  Response response = await dio.get("https://maps.googleapis.com/maps/api/place/textsearch/json?query=$textSearch&key=$key");
  List<MapLocationModel> listAddress = [];
  for(var address in response.data["results"]){
    MapLocationModel mapLocation = MapLocationModel.fromJson(address);
    listAddress.add(mapLocation);
  }
  return listAddress;
}

Future<Address> getLocationByCoordinates(String lat, String lng, {String key})async{
  Dio dio = Dio();
  Response response = await dio.get("https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$key");
  Address address = Address();

  if (response.statusCode == 200) {
    List components  = response.data["results"][0]["address_components"];
    for(var _address in components){
      if(_address["types"][0] == "street_number") address.number = _address["long_name"];
      if(_address["types"][0] == "route") address.street = _address["long_name"];
      if(_address["types"][0] == "political") address.neighborhood = _address["long_name"];
      if(_address["types"][0] == "administrative_area_level_2") address.city = _address["long_name"];
      if(_address["types"][0] == "administrative_area_level_1") address.uf = _address["short_name"];
      if(_address["types"][0] == "postal_code"){
        address.cep = _address["long_name"];
        if (address.cep.length == 9) address.cep = "${address.cep.substring(0,2)}.${address.cep.substring(2,9)}";
      }
    }
    address.formattedAddress = response.data["results"][0]["formatted_address"];
    address.lat = lat;
    address.lng = lng;
    return address;
  } else return null;
}