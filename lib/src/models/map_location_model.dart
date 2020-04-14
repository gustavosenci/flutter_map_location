class MapLocationModel {
  String formattedAddress;
  Geometry geometry;
  String icon;
  String id;
  String name;
  String placeId;
  PlusCode plusCode;
  String rating;
  String reference;
  List<String> types;
  int userRatingsTotal;

  MapLocationModel({this.formattedAddress, this.geometry, this.icon, this.id, this.name, this.placeId, this.plusCode, this.rating, this.reference, this.types, this.userRatingsTotal});

  MapLocationModel.fromJson(Map<String, dynamic> json) {
    formattedAddress = json['formatted_address'];
    geometry = json['geometry'] != null ? new Geometry.fromJson(json['geometry']) : null;
    icon = json['icon'];
    id = json['id'];
    name = json['name'];
    placeId = json['place_id'];
    plusCode = json['plus_code'] != null ? new PlusCode.fromJson(json['plus_code']) : null;
    rating = json['rating'].toString();
    reference = json['reference'];
    types = json['types'].cast<String>();
    userRatingsTotal = json['user_ratings_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['formatted_address'] = this.formattedAddress;
    if (this.geometry != null) {
      data['geometry'] = this.geometry.toJson();
    }
    data['icon'] = this.icon;
    data['id'] = this.id;
    data['name'] = this.name;
    data['place_id'] = this.placeId;
    if (this.plusCode != null) {
      data['plus_code'] = this.plusCode.toJson();
    }
    data['rating'] = this.rating;
    data['reference'] = this.reference;
    data['types'] = this.types;
    data['user_ratings_total'] = this.userRatingsTotal;
    return data;
  }
}

class Geometry {
  Location location;
  Viewport viewport;

  Geometry({this.location, this.viewport});

  Geometry.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null ? new Location.fromJson(json['location']) : null;
    viewport = json['viewport'] != null ? new Viewport.fromJson(json['viewport']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    if (this.viewport != null) {
      data['viewport'] = this.viewport.toJson();
    }
    return data;
  }
}

class Location {
  double lat;
  double lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Viewport {
  Location northeast;
  Location southwest;

  Viewport({this.northeast, this.southwest});

  Viewport.fromJson(Map<String, dynamic> json) {
    northeast = json['northeast'] != null ? new Location.fromJson(json['northeast']) : null;
    southwest = json['southwest'] != null ? new Location.fromJson(json['southwest']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.northeast != null) {
      data['northeast'] = this.northeast.toJson();
    }
    if (this.southwest != null) {
      data['southwest'] = this.southwest.toJson();
    }
    return data;
  }
}

class PlusCode {
  String compoundCode;
  String globalCode;

  PlusCode({this.compoundCode, this.globalCode});

  PlusCode.fromJson(Map<String, dynamic> json) {
    compoundCode = json['compound_code'];
    globalCode = json['global_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['compound_code'] = this.compoundCode;
    data['global_code'] = this.globalCode;
    return data;
  }
}

