
import 'package:akwe/src/models/marital_status.dart';
import 'package:akwe/src/models/user_sex.dart';
import 'package:akwe/src/utils/marital_status_list.dart';
import 'package:akwe/src/utils/user_sex_list.dart';
import 'package:flutter/cupertino.dart';


var maritalStatusList = getMaritalStatusList();
var sexStatusList = getSexList();

class UserData {
  int? id;
  String? firstName;
  String? lastName;
  double? monthlyEarnings;
  String? email;
  UserSex? sex;
  DateTime? birthDate;
  double? children;
  MaritalStatus? maritalStatus;

  UserData({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.birthDate,
    this.children,
    this.maritalStatus,
    this.monthlyEarnings,
    this.sex,
  });

  UserData.fromJson(Map<String, dynamic> json){
    try{
      id = json['id'];
      firstName = json['first_name'] ?? "";
      lastName = json['last_name'] ?? "";
      email = json['email'] ?? "";
      birthDate = DateTime.tryParse(json['birthdate'] ?? "");
      children = json['children'] == null ? 0.0 : json['children'].toDouble(); //double.tryParse(json['children'] ?? 0.0);
      maritalStatus = getMaritalStatus(json['marital_status'] ?? 13);
      sex = getUserSex(json['sex'] ?? 3);
      monthlyEarnings = double.tryParse(json['monthly_earnings'] ?? "0.0");

    }catch(e){
      debugPrint(e.toString());
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    //data['id'];
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['birth_date'] = birthDate?.toIso8601String();
    data['children'] = children?.toDouble() ;
    data['marital_status'] = maritalStatus?.key;
    data['sex'] = sex?.key;
    data['monthly_earnings'] = monthlyEarnings;

    return data;
  }


  getMaritalStatus(int key){
    return maritalStatusList.singleWhere((MaritalStatus element) => element.key==key);
  }

  getUserSex(int key){
    return sexStatusList.singleWhere((UserSex element) => element.key==key);
  }


}
