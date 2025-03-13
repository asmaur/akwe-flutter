import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/auth/authentication_state.dart';
import '../globals/app_authentication_service.dart';
import '../routes/app_pages.dart';

class AuthenticationGuard extends GetMiddleware {
  final AppAuthenticationService _appAuthService =
      Get.find<AppAuthenticationService>();

  @override
  RouteSettings? redirect(String? route) =>
      _appAuthService.state is UnAuthenticated
          ? const RouteSettings(name: AppRoutes.LOGIN)
          : null;
}
