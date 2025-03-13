import 'package:akwe/src/ui/pages/transaction_previous/transaction_previous_controller.dart';
import 'package:get/get.dart';

class TransactionPreviousPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionPreviousPageController());
  }

}