class AppCategoryMetric{
  int? categoryId;
  double? value;


  AppCategoryMetric({this.categoryId, this.value});

  AppCategoryMetric.fromJson(Map<String, dynamic> json){
    categoryId = json['category'];
    value = json['value'];
  }

}