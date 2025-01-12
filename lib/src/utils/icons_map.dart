import 'package:flutter/material.dart';

class IconMapping {
  Map<String, IconData> iconMapping = {};

  Icon getIcon(String value){
    return Icon(iconMapping[value]);
  }



}