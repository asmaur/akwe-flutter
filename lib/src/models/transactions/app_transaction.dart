import 'dart:developer';

import 'package:akwe/src/models/accounts/app_account.dart';
import 'package:akwe/src/models/app_item.dart';
import 'package:akwe/src/models/categories/app_category.dart';
import 'package:akwe/src/models/companies/app_company.dart';
import 'package:akwe/src/utils/payment_type.dart';
import 'package:akwe/src/utils/payment_type_list.dart';


List<PaymentType> paymentTypes = getPaymentTypeList();

class Transaction {
  String? id;
  //String? uid;
  String? code;
  String? name;
  String? description;
  int? totalItems;
  double? discount;
  double? totalValue;
  double totalPayed = 0;
  PaymentType? paymentMethod;
  bool income = false;
  String? invoiceUrl;
  String? invoiceHtml;
  bool? auto;
  bool? processed;
  DateTime? emissionDate;
  DateTime? processedAt;
  DateTime? creationDate;

  AppCategory? category;
  AppAccount? account;
  Company? company;
  List<Item>? items;

  Transaction({
    this.id,
    //this.uid;
    this.code,
    this.description,
    this.name,
    this.totalItems,
    this.discount = 0.0,
    this.totalValue = 0.0,
    this.totalPayed = 0.0,
    this.paymentMethod,
    this.income = false,
    this.invoiceUrl = "",
    this.invoiceHtml,
    this.auto = false,
    this.processed,
    this.emissionDate,
    this.processedAt,
    this.creationDate,
    this.category,
    this.account,
    this.company,
    this.items,

  });

  Transaction.fromJson(dynamic json) {
    try {
      id = json['id'];
      //uid = json['uid'];
      code = "${json['code']}";
      name = json['name'];
      description = json['description'] ?? "";
      totalItems = json['total_items'];
      discount = double.tryParse(json['discount']);
      totalValue = double.tryParse(json['total_value']);
      totalPayed = double.tryParse(json['total_payed'])!;
      paymentMethod = getCurrentPaymentType(json['payment_method']);
      income = json['income'];
      auto = json['auto'];
      processed = json['processed'];
      //invoiceUrl = json['invoice_url'];
      creationDate = DateTime.tryParse(json['creation_date']);
      emissionDate = DateTime.tryParse(json['emission_date'] ?? "");
      processedAt = DateTime.tryParse(json['processed_at'] ?? "");
      invoiceUrl = json['invoice_url'] ?? "";


      category = AppCategory.fromJson(json['category']);
      account = AppAccount.fromJson(json['account']);
      company = Company.fromJson(json['company']);
      // items = Item.fromJsonList(json['items']) as List<Item>?;
    } catch (e) {

      log("Exception: $e");
    }
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = {};
    data['name'] = name;
    data['description'] = description;
    data['income'] = income;
    data['invoice_url'] = invoiceUrl;
    data['invoice_html'] = invoiceHtml;
    data['payment_method'] = paymentMethod?.key;
    data['total_items'] = totalItems;
    data['total_payed'] = totalPayed;
    data['total_value'] = totalValue;
    data['category'] = category?.id;
    data['account'] = account?.id;
    data['auto'] = auto;
    data['processed'] = processed;

    return data;
  }

  getCurrentPaymentType(int key) {

    return paymentTypes.singleWhere((element) => element.key==key);
    // for (PaymentType item in paymentTypes) {
    //   if (item.key == key) {
    //     return item.value;
    //   }
    // }
  }

}
