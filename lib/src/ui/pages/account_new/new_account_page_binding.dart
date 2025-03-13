import 'package:get/get.dart';

import 'new_account_page_controller.dart';

class NewAccountPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => NewAccountPageController());
  }
}