class AppAccountHistory {
  int? id;
  double? currentBalance;
  double? amount;
  bool? income;
  DateTime? creationDate;

  AppAccountHistory({
    this.id,
    this.currentBalance,
    this.amount,
    this.income,
    this.creationDate,
  });


  AppAccountHistory.fromJson(Map<String, dynamic> json){
    id = json['id'];
    currentBalance = double.tryParse(json['current_balance']);
    amount = double.tryParse(json['amount']);
    income = json['income'];
    creationDate = DateTime.tryParse(json['creation_date']);
  }


}
