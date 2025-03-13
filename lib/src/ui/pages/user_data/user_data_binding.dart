import 'package:get/get.dart';
import 'package:poupey/src/pages/user_data/user_data_controller.dart';

class UserDataBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => UserDataController());
  }
}