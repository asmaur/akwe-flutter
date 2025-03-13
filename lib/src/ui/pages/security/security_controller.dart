
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:poupey/src/globals/app_premium_service.dart';
import 'package:poupey/src/routes/app_pages.dart';
import 'package:poupey/src/services/storage/local_auth_storage.dart';

class SecurityController extends GetxController {
  var enableBiometrics = false.obs;
  var enablePinCode = false.obs;
  final LocalAuthentication _localAuth = LocalAuthentication();
  final _premiumService = Get.find<AppPremiumService>();
  final _localAuthStorage = LocalAuthStorage();

  @override
  onInit() {
    setAuthInitialValue();
    super.onInit();
  }

  setAuthInitialValue() async {
    enableBiometrics.value = await _localAuthStorage.readBiometric();
  }

  enableBiometricsAuth() async {
    final bool canAuthenticateWithBiometrics =
    await _localAuth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await _localAuth.isDeviceSupported();

    if (canAuthenticate) {
      if(!_premiumService.isPremium.value){
        enableBiometrics.value = false;
        Get.toNamed(Routes.USERPREMIUM);
      }else {
        await _localAuthStorage.enableBiometric(enableBiometrics.value);
        authenticate();
      }
    }
  }


  Future<void> authenticate() async {
    final bool canAuthenticateWithBiometrics =
        await _localAuth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await _localAuth.isDeviceSupported();

    if (canAuthenticate) {
      try {
          final bool didAuthenticate = await _localAuth.authenticate(
              localizedReason: 'Entrer with fingerprint or pin',
              options: const AuthenticationOptions(
                useErrorDialogs: true,
                stickyAuth: false,
              ));


      } on PlatformException catch (e) {
        print(e);
      }
    }
  }


}
