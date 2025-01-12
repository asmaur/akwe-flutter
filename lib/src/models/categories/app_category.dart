import 'dart:io';

import 'package:akwe/src/utils/app_color.dart';
import 'package:akwe/src/utils/app_color_list.dart';
import 'package:akwe/src/utils/app_icon.dart';
import 'package:akwe/src/utils/app_icon_list.dart';

var colorList = getAppColorList();
var iconList = getAppIconList();

class AppCategory {
  String? id;
  String? uid;
  bool? income;
  String? name;
  String? description;
  bool? isDefault;
  AppColor? color;
  AppIcon? icon;

  AppCategory({
    this.id,
    this.uid,
    this.name,
    this.description,
    this.isDefault,
    this.income,
    this.color,
    this.icon,
  });

  AppCategory.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'];
      name = getNameIntl(json);
      description = json['description'] ?? "";
      isDefault = json['is_default'];
      income = json['income'];
      color = getColor(json['color']);
      icon = getIcon(json['icon']);
    }catch(e, stack){
      print(stack);
    }
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['description'] = description;
    data['color'] = color?.key;
    data['icon'] = icon?.key;
    data['income'] = income;

    return data;
  }


  String getNameIntl(Map<String, dynamic> json) {
    //AppLocalizations.of(context)!.localeName
    String lang = Platform.localeName.substring(0, 2);
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
    try {
      var index = colorList.indexWhere((AppColor element) =>
      element.key == key);
      return colorList[index];
    }catch(e, stack){
      print(stack);
    }
  }

  getIcon(int key){
    try {
      //var index = iconList.indexWhere((element) => element.key==key);
      return iconList
          .singleWhere((AppIcon element) => element.key == key);
    }catch(e, stack){
      print(stack);
    }
  }

}
