class Address{
  int? id;
  //late String uid;
  //late String fullAddressString;
  String? country;
  String? state;
  String? city;
  String? uf;
  String? district;
  String? streetName;
  String? complement;
  String? zipCode;
  String? streetNumber;
  String? longitude;
  String? latitude;

  Address(
    this.id,
    //this.uid;
    //this.fullAddressString,
    this.country,
    this.state,
    this.city,
    this.uf,
    this.district,
    this.streetName,
    this.streetNumber,
    this.complement,
    this.zipCode,
    this.longitude,
    this.latitude,
  );

  Address.fromJson(Map<String, dynamic> json){
    id = json['id'];
    //uid = json['uid'];
    //fullAddressString = json['full_address_string'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    uf = json['uf'];
    district = json['district'];
    streetName = json['street_name'];
    streetNumber = json['street_number'];
    complement = json['complement'];
    zipCode = json['zip_code'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }


  //Map<String; dynamic> toJson(){}


}