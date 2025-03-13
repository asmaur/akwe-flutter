import 'package:akwe/src/responsive/device_form_factor.dart';
import 'package:akwe/src/responsive/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeviceTypeLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  final Widget watch;
  final Widget smallTV;
  final Widget largeTV;

  const DeviceTypeLayout({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
    required this.watch,
    required this.smallTV,
    required this.largeTV,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      key,
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceFormFactor.Watch) {
          return watch;
        }

        if (sizingInformation.deviceScreenType == DeviceFormFactor.Tablet) {
          return tablet;
        }

        if (sizingInformation.deviceScreenType == DeviceFormFactor.Desktop) {
          return desktop;
        }
        if (sizingInformation.deviceScreenType == DeviceFormFactor.SmallTV) {
          return smallTV;
        }

        if (sizingInformation.deviceScreenType == DeviceFormFactor.LargeTV) {
          return largeTV;
        }

        return mobile;
      },
    );
  }
}
