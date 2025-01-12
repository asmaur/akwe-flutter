class AppBank {
  String? ispb;
  String? name;
  int? code;
  String? fullName;

  AppBank({
    this.ispb,
    this.code,
    this.name,
    this.fullName,
  });

  AppBank.fromJson(Map<String, dynamic> json){
    ispb = json['ispb'];
    name = json['name'];
    code = json['code'];
    fullName = json['fullName'];
  }

}
