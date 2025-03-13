import 'package:get/get.dart';

import 'new_transfer_page_controller.dart';

class NewTransferPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => NewTransferPageController());
  }
}