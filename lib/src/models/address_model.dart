class Address {
  String street;
  String city;
  String uf;
  String cep;
  String neighborhood;
  String complement;
  String number;
  String lat;
  String lng;
  String formattedAddress;

  Address(
      {this.street,
        this.city,
        this.uf,
        this.cep,
        this.neighborhood,
        this.complement,
        this.number,
        this.lat,
        this.formattedAddress,
        this.lng});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    city = json['city'];
    uf = json['uf'];
    cep = json['cep'];
    neighborhood = json['neighborhood'];
    complement = json['complement'];
    number = json['number'];
    lat = json['lat'];
    lng = json['lng'];
    formattedAddress = json['formattedAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['city'] = this.city;
    data['uf'] = this.uf;
    data['cep'] = this.cep;
    data['neighborhood'] = this.neighborhood;
    data['complement'] = this.complement;
    data['number'] = this.number;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['formattedAddress'] = this.formattedAddress;
    return data;
  }
}