import 'package:get/get.dart';

import 'new_transaction_page_controller.dart';


class NewTransactionPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => NewTransactionPageController());
  }
}