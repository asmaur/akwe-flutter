class BudgetHistory{
  int? id;
  double? initialBalance;
  double? expense;
  double? percent;
  DateTime? creationDate;


  BudgetHistory.fromJson(Map<String, dynamic> json){
    id = json['id'];
    initialBalance = double.tryParse(json['initial_balance']);
    expense = double.tryParse(json['expense']);
    percent = json['percent'] ?? 0; //double.tryParse(json['percent'] ?? "0.0");
    creationDate = DateTime.tryParse(json['creation_date'] ?? "");
  }


}