import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AppLayout{
  static getSize(BuildContext context){
    return MediaQuery.of(context).size;
  }
  static getScreenHeight(){
    return Get.height;
  }
  static getScreenWidth(){
    return Get.width;
  }
  static getHeight(double pixels){
    // double x = getScreenHeight()/pixels;
    // return getScreenHeight()/x;
    return pixels.h;
  }
  static getWidth(double pixels){
    // double x = getScreenWidth()/pixels;
    // return getScreenWidth()/x;
    return pixels.w;
  }
  static const kDefaultPadding = 10;
}