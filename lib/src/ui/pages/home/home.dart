import 'package:akwe/src/responsive/device_type_layout.dart';
import 'package:akwe/src/responsive/orientation_layout.dart';
import 'package:akwe/src/ui/pages/home/home_view_mobile_landscape.dart';
import 'package:akwe/src/ui/pages/home/home_view_mobile_portrait.dart';
import 'package:flutter/material.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return DeviceTypeLayout(
      mobile: OrientationLayout(
          landscape: HomeViewMobileLandscape(),
          portrait: HomeViewMobilePortrait(),
      ),
      tablet: SizedBox(),
      desktop: SizedBox(),
    );
  }
}
