import 'package:akwe/src/ui/pages/transfer_detail/transfer_detail_page_controller.dart';
import 'package:get/get.dart';


class TransferDetailPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => TransferDetailPageController());
  }

}