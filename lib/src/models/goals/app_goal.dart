

import 'package:akwe/src/models/categories/app_category.dart';
import 'package:akwe/src/utils/app_color.dart';
import 'package:akwe/src/utils/app_color_list.dart';
import 'package:akwe/src/utils/app_icon.dart';
import 'package:akwe/src/utils/app_icon_list.dart';

import 'app_goal_history.dart';

var colorList = getAppColorList();
var iconList = getAppIconList();

class AppGoal{
  String? id;
  String? name;
  String? description;
  double? targetAmount;
  double? balance;
  bool? active;
  bool? archived;
  bool? paused;
  AppColor? color;
  AppIcon? icon;
  AppCategory? category;
  DateTime? deadlineDate;
  DateTime? creationDate;
  List<AppGoalHistory>? histories;

  AppGoal({
    this.id,
    this.name,
    this.description,
    this.targetAmount,
    this.balance,
    this.active = true,
    this.archived = false,
    this.paused = false,
    this.category,
    this.color,
    this.icon,
    this.deadlineDate,
    this.creationDate,
    this.histories,
  });

  AppGoal.fromJson(Map<String, dynamic> json){
    try{
      id = json['id'];
      name = json['name'];
      description = json['description'];
      active = json['active'];
      archived = json['archived'];
      paused = json['paused'];
      category = AppCategory.fromJson(json['category']);
      targetAmount = double.tryParse(json['target_amount']);
      balance = double.tryParse(json['balance']);
      deadlineDate = DateTime.tryParse(json['deadline_date']);
      color = getColor(json['color']);
      icon = getIcon(json['icon']);

      if (json['histories'] != null && json['histories'].isNotEmpty) {
        histories = <AppGoalHistory>[];
        json['histories'].forEach((item) {
          histories?.add(AppGoalHistory.fromJson(item));
        });
      }

    }catch(e){
      print(e);
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    //data["balance"] = balance;
    data["target_amount"] = targetAmount;
    data["name"] = name;
    data["description"] = description;
    data["deadline_date"] = deadlineDate?.toIso8601String();
    data["color"] = color?.key;
    data["icon"] = icon?.key;
    data['category_id'] = category?.id;

    return data;
  }


  getColor(int key){
    return colorList.singleWhere((AppColor element) => element.key==key);
  }

  getIcon(int key){
    return iconList.singleWhere((AppIcon element) => element.key==key);
  }


}