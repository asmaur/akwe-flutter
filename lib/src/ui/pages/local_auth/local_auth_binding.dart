import 'package:get/get.dart';
import 'package:poupey/src/pages/local_auth/local_auth_controller.dart';

class LocalAuthBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LocalAuthController());
  }

}