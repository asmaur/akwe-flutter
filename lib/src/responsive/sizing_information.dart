import 'package:akwe/src/responsive/device_form_factor.dart';
import 'package:flutter/material.dart';

class SizingInformation {
  final DeviceFormFactor deviceScreenType;
  final Size screenSize;
  final Size localWidgetSize;

  SizingInformation({
    required this.deviceScreenType,
    required this.screenSize,
    required this.localWidgetSize
  });

  @override
  String toString(){
    return 'DeviceType:$deviceScreenType ScreenSize:$screenSize LocalWidgetSize:$localWidgetSize';
  }

}