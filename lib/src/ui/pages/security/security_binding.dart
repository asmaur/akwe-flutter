import 'package:get/get.dart';
import 'package:poupey/src/pages/security/security_controller.dart';

class SecurityBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SecurityController());
  }

}