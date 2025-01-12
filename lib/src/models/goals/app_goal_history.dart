class AppGoalHistory{
  double? amount;
  DateTime? creationDate;

  AppGoalHistory({
    this.amount,
    this.creationDate
  });

  AppGoalHistory.fromJson(Map<String, dynamic> json){
    try{
      amount = double.tryParse(json['amount']);
      creationDate = DateTime.tryParse(json['creation_date']);
    }catch(e){
      print(e);
    }
  }


}