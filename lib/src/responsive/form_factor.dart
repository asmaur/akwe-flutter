import 'package:akwe/src/responsive/device_form_factor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// DeviceFormFactor getDeviceFormFactor(MediaQueryData mediaQuery){
//   double deviceWidth = mediaQuery.size.width;//.shortestSide;
//
//   if(deviceWidth > 840){
//     return DeviceFormFactor.Desktop;
//   }
//   if(deviceWidth > 600 && deviceWidth < 840){
//     return DeviceFormFactor.Tablet;
//   }
//
//   return DeviceFormFactor.Mobile;
// }

DeviceFormFactor getDeviceFormFactor(MediaQueryData mediaQuery, constraints){
  double deviceWidth = mediaQuery.size.width;
  double deviceHeight = mediaQuery.size.height;

  // Consider orientation:
  bool isLandscape = deviceWidth > deviceHeight;

  // Use logical pixel sizes (not just raw pixels)
  double shortestSide = mediaQuery.size.shortestSide;
  double deviseMaxWidth = constraints.maxWidth;

  // print("SHORTESTSIZE: $deviseMaxWidth");

  // if (shortestSide < 350) { // Adjust as needed
  //   return DeviceFormFactor.Watch;
  // } else if (shortestSide < 600) {
  //   return DeviceFormFactor.Phone;
  // } else if (shortestSide < 900) {  // Adjust for larger phones/phablets
  //   return DeviceFormFactor.Tablet;
  // } else if (shortestSide < 1200) {
  //   return DeviceFormFactor.Desktop;
  // } else if (shortestSide < 1920) {
  //   return DeviceFormFactor.SmallTV;
  // } else {
  //   return DeviceFormFactor.LargeTV;
  // }

  if(deviseMaxWidth >= 1366){
    return DeviceFormFactor.Desktop;
  } else if(deviseMaxWidth <1366 && deviseMaxWidth >= 768){
    return DeviceFormFactor.Tablet;
  }else{
    return DeviceFormFactor.Mobile;
  }

}
