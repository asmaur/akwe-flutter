import 'package:akwe/src/responsive/device_form_factor.dart';
import 'package:akwe/src/responsive/responsive_builder.dart';
import 'package:flutter/material.dart';

class DeviceTypeLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const DeviceTypeLayout({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(key, builder: (context, sizingInformation) {
      if(sizingInformation.deviceScreenType == DeviceFormFactor.Tablet){
        return tablet;
      }

      if(sizingInformation.deviceScreenType == DeviceFormFactor.Desktop){
        return desktop;
      }

      return mobile;

    });
  }
}
