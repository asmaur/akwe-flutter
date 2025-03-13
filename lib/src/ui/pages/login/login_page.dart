import 'package:akwe/src/responsive/device_type_layout.dart';
import 'package:akwe/src/responsive/orientation_layout.dart';
import 'package:akwe/src/ui/pages/login/login_page_desktop.dart';
import 'package:akwe/src/ui/pages/login/login_page_portrait.dart';
import 'package:akwe/src/ui/pages/login/login_page_landscape.dart';
import 'package:flutter/material.dart';

import 'login_page_mobile.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DeviceTypeLayout(
      mobile: LoginPageMobile(),
      tablet: OrientationLayout(
        landscape: LoginPageLandscape(),
        portrait: LoginPagePortrait(),
      ),
      desktop: LoginPageDesktop(),
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
