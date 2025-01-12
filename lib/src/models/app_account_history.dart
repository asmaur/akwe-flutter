class AccountHistory {
  late int id;
  late double currentBalance;
  late double amount;
  late bool income;
  late DateTime creationDate;

  AccountHistory(
    this.id,
    this.currentBalance,
    this.amount,
    this.income,
    this.creationDate,
  );

  AccountHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    currentBalance = json['current_balance'];
    amount = json['amount'];
    income = json['income'];
    creationDate = DateTime.parse("creation_date");
  }
}
