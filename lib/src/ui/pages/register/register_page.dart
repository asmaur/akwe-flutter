import 'package:akwe/src/responsive/device_type_layout.dart';
import 'package:akwe/src/responsive/orientation_layout.dart';
import 'package:akwe/src/ui/pages/login/login_page_desktop.dart';
import 'package:akwe/src/ui/pages/login/login_page_portrait.dart';
import 'package:akwe/src/ui/pages/login/login_page_landscape.dart';
import 'package:flutter/material.dart';

import 'register_page_desktop.dart';
import 'register_page_landscape.dart';
import 'register_page_mobile.dart';
import 'register_page_portrait.dart';


class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DeviceTypeLayout(
      mobile: RegisterPageMobile(),
      tablet: OrientationLayout(
        landscape: RegisterPageLandscape(),
        portrait: RegisterPagePortrait(),
      ),
      desktop: RegisterPageDesktop(),
      watch: Container(
        child: Center(
          child: Text("Watch, Not Implemented!"),
        ),
      ),
      smallTV: Container(
        child: Center(
          child: Text("SmallTV, Not Implemented!"),
        ),
      ),
      largeTV: Container(
        child: Center(
          child: Text("LargeTV, Not Implemented!"),
        ),
      ),
    );
  }
}
