import 'package:akwe/src/ui/pages/transaction_all/transaction_all_page_controller.dart';
import 'package:get/get.dart';

class TransactionAllPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionAllPageController());
  }

}