import 'package:akwe/src/ui/pages/transaction_filter_result/transaction_result_page_controller.dart';
import 'package:get/get.dart';

class TransactionResultPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionResultPageController());
  }

}