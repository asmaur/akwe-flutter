

import 'package:akwe/src/models/app_location.dart';

import 'categories/app_category.dart';
import 'companies/app_company.dart';

class Item {
  late int id;
  late String code;
  late String description;
  double? quantity;
  late String unit;
  double? unitPrice;
  double? totalPrice;
  String? consumer;
  DateTime? emission;
  Address? location;
  Company? company;
  AppCategory? category;
  late DateTime creationDate;

  Item(
    this.id,
    this.code,
    this.description,
    this.quantity,
    this.unit,
    this.unitPrice,
    this.totalPrice,
    this.consumer,
    this.emission,
    this.location,
    this.company,
    this.category,
    this.creationDate,
  );

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    description = json['description'];
    quantity = double.tryParse(json['quantity']);
    unit = json['unit'];
    unitPrice = double.tryParse(json['unit_price']);
    totalPrice = double.tryParse(json['total_price']);
    consumer = json['consumer'];
    emission = DateTime.parse(json['emission']);
    location = Address.fromJson(json['location']);
    company = Company.fromJson(json['company']);
    category = AppCategory.fromJson(json['category']);
    creationDate = DateTime.parse(json['creation_date']);

  }

  List<Item>? itemList;

  Item.fromJsonList(List<Map<String, dynamic>> items){
    if (items.isNotEmpty) {
      for (var item in items) {
        itemList?.add(Item.fromJson(item));
      }
    }
  }

}
