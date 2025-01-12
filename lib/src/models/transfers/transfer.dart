
import 'package:akwe/src/models/accounts/app_account.dart';

class Transfer {
  int? id;
  String? code;
  String? name;
  String? description;
  double? amount;
  bool? processed;
  AppAccount? fromAccount;
  AppAccount? inAccount;
  DateTime? executionDate;
  DateTime? creationDate;

  Transfer({
    this.id,
    this.code,
    this.name,
    this.processed,
    this.description,
    this.amount,
    this.fromAccount,
    this.inAccount,
    this.executionDate,
    this.creationDate,
  });

  Transfer.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'];
      code = json['code'];
      name = json['name'];
      processed = json['processed'];
      description = json['description'] ?? "";
      amount = double.tryParse(json['amount']);
      fromAccount = AppAccount.fromJson(json['from_account']);
      inAccount = AppAccount.fromJson(json['in_account']);
      executionDate = DateTime.tryParse(json['execution_date']);
      creationDate = DateTime.tryParse(json['creation_date']);
    } catch (e) {
      print(e);
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data['name'] = name;
    data['processed'] = processed;
    data['description'] = description;
    data['amount'] = amount;
    data['from_account'] = fromAccount?.id;
    data['in_account'] = inAccount?.id;
    data['execution_date'] = executionDate?.toIso8601String();

    return data;
  }

}
