import 'package:get/get.dart';

import 'edit_account_page_controller.dart';

class EditAccountPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => EditAccountPageController());
  }
}