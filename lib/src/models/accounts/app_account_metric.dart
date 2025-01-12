class AppAccountMetric{
  int? accountId;
  double? value;


  AppAccountMetric({this.accountId, this.value});

  AppAccountMetric.fromJson(Map<String, dynamic> json){
    accountId = json['account'];
    value = json['value'];
  }

}