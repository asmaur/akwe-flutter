

import 'package:akwe/src/models/accounts/app_account.dart';
import 'package:akwe/src/models/categories/app_category.dart';
import 'package:akwe/src/utils/payment_type_list.dart';

final paymentTypeList = getPaymentTypeList();


class Routine {
  String? id;
  String? name;
  String? description;
  bool? income;
  bool? toCalendar;
  double? amount;
  int? paymentType;
  // Color? color;
  DateTime? reminderDate;
  DateTime? expirationDate;
  DateTime? executionDate;
  DateTime? creationDate;
  bool? done;
  AppCategory? category;
  AppAccount? account;

  Routine({
    this.id,
    this.name,
    this.description,
    this.income,
    this.amount,
    this.paymentType,
    this.toCalendar,
    this.reminderDate,
    this.expirationDate,
    this.executionDate,
    this.creationDate,
    this.done,
    this.category,
    this.account,
  });

  Routine.fromJson(Map<String, dynamic> json){
    try {
      id = json['id'];
      name = json['name'];
      description = json['description'] ?? "";
      income = json['income'];
      amount = double.parse(json['amount']);
      paymentType = json['payment_method']; //getPaymentType(json['payment_method']);
      toCalendar = json['to_calendar'];
      done = json['done'];
      expirationDate = DateTime.tryParse(json['expiration_date']);
      reminderDate = DateTime.tryParse(json['reminder_date']);
      executionDate = DateTime.tryParse(json['execution_date'] ?? "");
      creationDate = DateTime.tryParse(json['creation_date'] ?? "");
      account = AppAccount.fromJson(json['account']);
      category = AppCategory.fromJson(json['category']);

    }catch(e){
      print(e);
    }
  }

  getPaymentType(int key){
    return paymentTypeList.singleWhere((element) => element.key == key);
  }

}
