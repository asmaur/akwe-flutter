import 'package:akwe/src/ui/pages/transaction_filter/transaction_filter_page_controller.dart';
import 'package:get/get.dart';

class TransactionFilterPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionFilterPageController());
  }

}