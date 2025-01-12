
class Company{
  int? id;
  late String description;
  late String number_cnpj;
  String? numberIE;
  //Address? location;
  // late DateTime creation_date;
  // late DateTime modification_date;


  Company.fromJson(Map<String, dynamic> json){
    id = json['id'];
    description = json['description'];
    number_cnpj = json['number_cnpj'];
    numberIE = json['number_ie'];
    //location = Address.fromJson(json['location']);
    // creation_date = json['creation_date'];
    // modification_date = json['modification_date'];
  }

}