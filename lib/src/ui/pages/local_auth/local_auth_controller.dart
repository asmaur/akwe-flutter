import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthController extends GetxController{

  final LocalAuthentication _localAuth = LocalAuthentication();

  @override
  onInit(){
    authenticate();
    super.onInit();
  }

  Future<void> authenticate() async {
    final bool canAuthenticateWithBiometrics =
    await _localAuth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await _localAuth.isDeviceSupported();

    //if (canAuthenticate) {
      try {
        final bool didAuthenticate = await _localAuth.authenticate(
            localizedReason: "Authenticate to enter the app.",
            options: const AuthenticationOptions(
              useErrorDialogs: true,
              stickyAuth: true,
            ));
        if(didAuthenticate) {
          Get.back();//toNamed(Routes.HOME);
        }
        //return didAuthenticate;
      } on PlatformException catch (e) {
        print(e);
        //return false;
      }
    //}
  }

}