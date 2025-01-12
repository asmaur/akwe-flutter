import 'package:akwe/src/ui/pages/transfer/transfer_page_controller.dart';
import 'package:get/get.dart';

class TransferPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => TransferPageController());
  }
}