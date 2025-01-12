class AppCompanyMetric{
  String? name;
  double? value;

  AppCompanyMetric({this.name, this.value});

  AppCompanyMetric.fromJson(Map<String, dynamic> json){
    name = json['company__description'];
    value = json['value'];
  }

}