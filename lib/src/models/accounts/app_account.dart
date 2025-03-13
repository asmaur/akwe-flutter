import 'dart:io';
import 'dart:ui';

import 'package:akwe/src/models/account_type.dart';
import 'package:akwe/src/models/banking.dart';
import 'package:akwe/src/utils/account_type_list.dart';
import 'package:akwe/src/utils/app_color.dart';
import 'package:akwe/src/utils/app_color_list.dart';
import 'package:akwe/src/utils/app_icon.dart';
import 'package:akwe/src/utils/app_icon_list.dart';
import 'package:akwe/src/utils/instituitions_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_account_history.dart';

var colorList = getAppColorList();
var iconList = getAppIconList();
var bankList = getBankInstitution();
var accountTypes = getAccountType();


class AppAccount{
  String? id;
  //String? uid;
  String? name;
  double? balance;
  bool? isDefault;
  String? description;
  AppColor? color;
  IconData? icon;
  Bank? bank;
  AccountType? accountType;
  bool? archived;
  bool? isFund;
  DateTime? creationDate;
  List<AppAccountHistory>? histories;

  AppAccount({
    this.id,
    this.name,
    this.description,
    this.color,
    this.icon,
    this.bank,
    this.accountType,
    this.archived = false,
    this.isDefault = false,
    this.isFund = false,
    this.balance,
    this.creationDate,
    this.histories,
});

  AppAccount.fromJson(Map<String, dynamic> json){
    try {
      id = json['id'];
      name = getNameIntl(json);
      description = json['description'] ?? "";
      balance = double.parse(json['balance']);
      isDefault = json['is_default'];
      isFund = json['is_fund'];
      color = getColor(json['color']);
      icon = getIcon(json['icon']);
      accountType = getAccountTypeValue(json['account_type']);
      bank = getBank(json['bank_code']);
      creationDate = DateTime.tryParse(json['creation_date']);

      if (json['histories'] != null && json['histories'].isNotEmpty) {
        histories = <AppAccountHistory>[];
        json['histories'].forEach((item) {
          histories?.add(AppAccountHistory.fromJson(item));
        });
      }

    }catch(e, stack){
      print(stack);
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['name'] = name;
    data['description'] = description;
    data['balance'] = balance;
    data['account_type'] = accountType?.key;
    data['is_fund'] = isFund;
    data['color'] = color?.key;
    data['bank_code'] = bank?.key;

    return data;
  }


  Map<String, dynamic> toJsonRequest(){
    Map<String, dynamic> data = {};
    data['name'] = name;
    data['description'] = description;
    data['balance'] = balance;
    data['account_type'] = accountType;
    data['is_fund'] = isFund;
    //data['bank_code'] = bankCode;

    return data;
  }

  Map<String, dynamic> toJsonUpdate(){
    Map<String, dynamic> data = {};
    data['id'] = id;
    data['description'] = description;
    data['balance'] = balance.toString();
    data['archived'] = archived;
    data['is_fund'] = isFund;
    data['bank_code'] = bank?.key;

    return data;
  }

  String getNameIntl(Map<String, dynamic> json) {
    // print("LANGUAGE: ${Get.locale?.languageCode}");
    //AppLocalizations.of(context)!.localeName
    String? lang = Get.locale?.languageCode; //Platform.localeName.substring(0, 2);

    switch (lang) {
      case 'en':{
        return json['name_en'];
      }
      case 'pt':{
        return json['name_pt_BR'];
      }
      case 'fr':{
        return json['name_fr'];
      }
      case 'es':{
        return json['name_es'];
      }
      case 'sw':{
        return json['name_sw'];
      }
      default: return json['name_en'];

    }
  }


  getColor(int key){
    return colorList.singleWhere((AppColor element) => element.key==key);
  }

  getIcon(int key){
    return iconList.singleWhere((AppIcon element) => element.key==key).icon;
  }

  getBank(int key){
    return bankList.singleWhere((Bank element) => element.key==key);
  }

  getAccountTypeValue(int key){
    return accountTypes.singleWhere((AccountType element) => element.key==key);
  }

}