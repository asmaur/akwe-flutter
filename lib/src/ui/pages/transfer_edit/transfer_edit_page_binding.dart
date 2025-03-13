import 'package:akwe/src/ui/pages/transfer_edit/transfer_edit_page_controller.dart';
import 'package:get/get.dart';

class EditTransferPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => EditTransferPageController());
  }
}