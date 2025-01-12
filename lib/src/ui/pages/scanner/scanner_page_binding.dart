import 'package:akwe/src/ui/pages/scanner/scanner_page_controller.dart';
import 'package:get/get.dart';

class ScannerPageViewBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ScannerPageController());
  }
}