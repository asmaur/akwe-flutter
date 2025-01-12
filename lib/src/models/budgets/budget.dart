import 'budget_history.dart';

class Budget {
  String? id;
  double? initialBalance;
  double? balance;
  double? expenses;
  double? incomes;
  DateTime? creationDate;
  List<BudgetHistory>? histories;

  Budget({
    this.id,
    this.initialBalance,
    this.balance,
    this.expenses,
    this.incomes,
    this.creationDate,
    this.histories,
  });

  Budget.fromJson(Map<String, dynamic> json){
    try {
      id = json['id'];
      initialBalance = double.parse(json['initial_balance']);
      balance = double.tryParse(json['balance']);
      expenses = double.tryParse(json['expense']);
      incomes = double.tryParse(json['income']);
      creationDate = DateTime.tryParse(json['creation_date']);

      if (json['histories'] != null && json['histories'].isNotEmpty) {
        histories = <BudgetHistory>[];
        json['histories'].forEach((item) {
          histories?.add(BudgetHistory.fromJson(item));
        });
      }else{
        histories = <BudgetHistory>[];
      }
    }catch(e, stack){
      print(stack);
    }
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = {};
    data['id'] = id;
    data['initial_balance'] = initialBalance;
    return data;
  }

}
