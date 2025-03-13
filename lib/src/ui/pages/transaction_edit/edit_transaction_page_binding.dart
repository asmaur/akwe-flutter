import 'package:get/get.dart';

import 'edit_transaction_page_controller.dart';

class EditTransactionPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => EditTransactionPageController());
  }
}