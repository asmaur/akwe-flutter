import 'package:get/get.dart';

import 'invoice_web_controller.dart';

class InvoiceWebBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => InvoiceWebController());
  }

}