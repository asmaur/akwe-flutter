import 'package:akwe/src/ui/pages/transaction_detail/transaction_detail_page_controller.dart';
import 'package:get/get.dart';

class TransactionDetailPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionDetailPageController());
  }

}