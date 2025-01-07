import 'package:akwe/src/ui/pages/qr_code_found/qr_code_found_page_view_controller.dart';
import 'package:get/get.dart';

class QrCodeFoundPageViewBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => QrCodeFoundPageViewController());
  }
}