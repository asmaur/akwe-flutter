import 'package:akwe/src/responsive/device_form_factor.dart';
import 'package:flutter/material.dart';

DeviceFormFactor getDeviceFormFactor(MediaQueryData mediaQuery){
  double deviceWidth = mediaQuery.size.shortestSide;

  if(deviceWidth > 950){
    return DeviceFormFactor.Desktop;
  }
  if(deviceWidth > 600){
    return DeviceFormFactor.Tablet;
  }

  return DeviceFormFactor.Mobile;
}